using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CsvHelper;
using System.Globalization;
using System.Data;
using System.Text;

namespace HealthHub
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSymptoms();
                MLModel.LoadModel(); // Load the pre-trained model (or train if it doesn't exist)
            }
        }


        private void LoadSymptoms()
        {
            // Load symptoms from the dataset
            var symptoms = new List<string>();
            string filePath = Server.MapPath("~/App_Data/Expanded_Specialization_Symptoms_Dataset.csv");
            using (var reader = new StreamReader(filePath))
            using (var csv = new CsvReader(reader, CultureInfo.InvariantCulture))
            {
                var records = csv.GetRecords<MLModel.SymptomRecord>().ToList();
                foreach (var record in records)
                {
                    symptoms.Add(record.Symptom1);
                    symptoms.Add(record.Symptom2);
                    symptoms.Add(record.Symptom3);
                    symptoms.Add(record.Symptom4);
                    symptoms.Add(record.Symptom5);
                }
            }

            // Sort symptoms in alphabetical order
            symptoms = symptoms.Distinct().OrderBy(symptom => symptom).ToList();

            lstSymptoms.DataSource = symptoms;
            lstSymptoms.DataBind();
        }

        protected void btnFindDoctors_Click(object sender, EventArgs e)
        {
            var selectedSymptoms = new List<string>();
            foreach (ListItem item in lstSymptoms.Items)
            {
                if (item.Selected)
                {
                    selectedSymptoms.Add(item.Text);
                }
            }

            if (selectedSymptoms.Count > 0)
            {
                Session["SelectedSymptoms"] = selectedSymptoms;
                Response.Redirect("RecommendedDoctorsList.aspx");
            }
        }


    }
}