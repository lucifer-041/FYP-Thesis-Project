using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using HealthHub;

namespace HealthHub
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSymptoms();
                MLModel.TrainModel(); // Train the model at startup (or load a pre-trained model)
            }
        }

        private void LoadSymptoms()
        {
            // Load symptoms from the dataset
            var symptoms = new List<string>
            {
                "Sneezing", "Itchy eyes", "Runny nose", "Pain management", "Nausea", "Chest pain", "Shortness of breath", "Acne", "Eczema", "Trauma", "Acute pain"
            };

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
                FindDoctors(selectedSymptoms);
            }
        }

        private void FindDoctors(List<string> symptoms)
        {
            // Aggregate symptoms into a single string for prediction
            var combinedSymptoms = string.Join(" ", symptoms);

            // Predict the specialization
            var predictedSpecialization = MLModel.PredictSpecialization(combinedSymptoms);
            Console.WriteLine($"Predicted specialization: {predictedSpecialization}");

            // Fetch doctors from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT FullName, Specialization, City, YearsOfExperience FROM Doctors WHERE Specialization = @Specialization";
                Console.WriteLine($"Executing query: {query} with parameter: {predictedSpecialization}");
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Specialization", predictedSpecialization);
                    SqlDataReader reader = cmd.ExecuteReader();
                    var doctors = new List<Doctor>();

                    while (reader.Read())
                    {
                        var doctor = new Doctor
                        {
                            FullName = reader["FullName"].ToString(),
                            Specialization = reader["Specialization"].ToString(),
                            City = reader["City"].ToString(),
                            YearsOfExperience = Convert.ToInt32(reader["YearsOfExperience"])
                        };
                        doctors.Add(doctor);
                    }

                    Console.WriteLine($"Number of doctors found: {doctors.Count}");
                    gvDoctors.DataSource = doctors;
                    gvDoctors.DataBind();
                }
            }
        }

        public class Doctor
        {
            public string FullName { get; set; }
            public string Specialization { get; set; }
            public string City { get; set; }
            public int YearsOfExperience { get; set; }
        }
    }
}
