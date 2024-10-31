using Microsoft.ML;
using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using CsvHelper;
using CsvHelper.Configuration;
using System.Linq;
using System.Web;

namespace HealthHub
{
    public class SymptomData
    {
        public string Symptom { get; set; }
        public string Specialization { get; set; }
    }

    public class SpecializationPrediction
    {
        [ColumnName("PredictedLabel")]
        public string Specialization { get; set; }

        [ColumnName("Score")]
        public float[] Score { get; set; }
    }

    public class MLModel
    {
        private static MLContext mlContext = new MLContext();
        private static PredictionEngine<SymptomData, SpecializationPrediction> predEngine;
        private static ITransformer trainedModel;

        public static void TrainModel()
        {
            var symptomData = new List<SymptomData>();
            string filePath = HttpContext.Current.Server.MapPath("~/App_Data/Expanded_Specialization_Symptoms_Dataset.csv");
            using (var reader = new StreamReader(filePath))
            using (var csv = new CsvReader(reader, CultureInfo.InvariantCulture))
            {
                var records = csv.GetRecords<SymptomRecord>().ToList();
                foreach (var record in records)
                {
                    symptomData.Add(new SymptomData { Symptom = record.Symptom1, Specialization = record.Specializations });
                    symptomData.Add(new SymptomData { Symptom = record.Symptom2, Specialization = record.Specializations });
                    symptomData.Add(new SymptomData { Symptom = record.Symptom3, Specialization = record.Specializations });
                    symptomData.Add(new SymptomData { Symptom = record.Symptom4, Specialization = record.Specializations });
                    symptomData.Add(new SymptomData { Symptom = record.Symptom5, Specialization = record.Specializations });
                }
            }

            var data = mlContext.Data.LoadFromEnumerable(symptomData);
            var pipeline = mlContext.Transforms.Conversion.MapValueToKey("Label", "Specialization")
                .Append(mlContext.Transforms.Text.FeaturizeText("Features", "Symptom"))
                .Append(mlContext.Transforms.Concatenate("Features", "Features"))
                .Append(mlContext.Transforms.NormalizeMinMax("Features", "Features"))
                .AppendCacheCheckpoint(mlContext)
                .Append(mlContext.MulticlassClassification.Trainers.SdcaMaximumEntropy("Label", "Features"))
                .Append(mlContext.Transforms.Conversion.MapKeyToValue("PredictedLabel", "PredictedLabel"));

            trainedModel = pipeline.Fit(data);
            predEngine = mlContext.Model.CreatePredictionEngine<SymptomData, SpecializationPrediction>(trainedModel);

            // Save the trained model to disk
            string modelPath = HttpContext.Current.Server.MapPath("~/App_Data/TrainedModel.zip");
            mlContext.Model.Save(trainedModel, data.Schema, modelPath);
        }

        public static void LoadModel()
        {
            string modelPath = HttpContext.Current.Server.MapPath("~/App_Data/TrainedModel.zip");
            if (File.Exists(modelPath))
            {
                DataViewSchema modelSchema;
                trainedModel = mlContext.Model.Load(modelPath, out modelSchema);
                predEngine = mlContext.Model.CreatePredictionEngine<SymptomData, SpecializationPrediction>(trainedModel);
            }
            else
            {
                TrainModel();
            }
        }


        public static List<string> PredictSpecialization(string symptom, int topN = 3)
        {
            var prediction = predEngine.Predict(new SymptomData { Symptom = symptom });
            var topSpecializations = new List<string>();

            // Create a VBuffer to hold the slot names
            VBuffer<ReadOnlyMemory<char>> slotNames = default;

            // Get slot names
            predEngine.OutputSchema["Score"].GetSlotNames(ref slotNames);

            // Convert the VBuffer to an array of strings
            var specializations = slotNames.DenseValues().Select(v => v.ToString()).ToArray();
            var probabilities = prediction.Score; // Get the scores directly from the prediction

            // Get top N specializations based on probabilities
            var topSpecializationsList = specializations
                .Zip(probabilities, (specialization, probability) => new { Specialization = specialization, Probability = probability })
                .OrderByDescending(x => x.Probability)
                .Take(topN)
                .Select(x => x.Specialization)
                .ToList();

            return topSpecializationsList;
        }

        public class SymptomRecord
        {
            public string Specializations { get; set; }
            public string Symptom1 { get; set; }
            public string Symptom2 { get; set; }
            public string Symptom3 { get; set; }
            public string Symptom4 { get; set; }
            public string Symptom5 { get; set; }
        }
    }
}