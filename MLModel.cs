using Microsoft.ML;
using Microsoft.ML.Data;
using System;
using System.Collections.Generic;

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
    }

    public class MLModel
    {
        private static MLContext mlContext = new MLContext();
        private static PredictionEngine<SymptomData, SpecializationPrediction> predEngine;
        private static ITransformer trainedModel;

        public static void TrainModel()
        {
            var symptomData = new List<SymptomData>
            {
                new SymptomData { Symptom = "Sneezing", Specialization = "Allergist/Immunologist" },
                new SymptomData { Symptom = "Itchy eyes", Specialization = "Allergist/Immunologist" },
                new SymptomData { Symptom = "Chest pain", Specialization = "Cardiologist" },
                new SymptomData { Symptom = "Acne", Specialization = "Dermatologist" },
                // Add more data here
            };

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
        }

        public static string PredictSpecialization(string symptom)
        {
            var prediction = predEngine.Predict(new SymptomData { Symptom = symptom });
            Console.WriteLine($"Predicted specialization for symptom '{symptom}': {prediction.Specialization}");
            return prediction.Specialization;
        }

    }
}
