using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace HealthHub
{
    public partial class RecommendedDoctorsList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var selectedSymptoms = Session["SelectedSymptoms"] as List<string>;
                if (selectedSymptoms != null)
                {
                    FindDoctors(selectedSymptoms);
                }
            }
        }

        private void FindDoctors(List<string> symptoms)
        {
            var combinedSymptoms = string.Join(" ", symptoms);
            var predictedSpecializations = MLModel.PredictSpecialization(combinedSymptoms, 3); // Get up to 3 specializations
            Console.WriteLine($"Predicted specializations: {string.Join(", ", predictedSpecializations)}");

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("GetDoctorsBySpecializations", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Specializations", string.Join(",", predictedSpecializations));
                    SqlDataReader reader = cmd.ExecuteReader();
                    var doctors = new Dictionary<int, Doctor>();

                    while (reader.Read())
                    {
                        int doctorID = Convert.ToInt32(reader["DoctorID"]);

                        if (!doctors.ContainsKey(doctorID))
                        {
                            var doctor = new Doctor
                            {
                                DoctorID = doctorID,
                                FullName = reader["FullName"].ToString(),
                                Specialization = reader["Specialization"].ToString(),
                                City = reader["City"].ToString(),
                                YearsOfExperience = Convert.ToInt32(reader["YearsOfExperience"]),
                                ProfileImage = reader["ProfileImage"].ToString(),
                                AverageRating = reader["AverageRating"] != DBNull.Value ? Convert.ToDouble(reader["AverageRating"]) : 0.0,
                                AvailabilityID = Convert.ToInt32(reader["AvailabilityID"]),
                                Hospitals = new List<Hospital>()
                            };
                            doctors[doctorID] = doctor;
                        }

                        var hospitalName = reader["HospitalName"].ToString();
                        if (!doctors[doctorID].Hospitals.Any(h => h.HospitalName == hospitalName))
                        {
                            var hospital = new Hospital
                            {
                                HospitalName = hospitalName,
                                City = reader["City"].ToString(),
                                Fees = Convert.ToDouble(reader["Fees"])
                            };
                            doctors[doctorID].Hospitals.Add(hospital);
                        }
                    }

                    rptDoctors.DataSource = doctors.Values.ToList();
                    rptDoctors.DataBind();
                }
            }
        }

        protected void rptDoctors_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var doctor = (Doctor)e.Item.DataItem;
                var rptHospitals = (Repeater)e.Item.FindControl("rptHospitals");
                rptHospitals.DataSource = doctor.Hospitals;
                rptHospitals.DataBind();

                var lnkDoctorName = (HyperLink)e.Item.FindControl("lnkDoctorName");
                lnkDoctorName.Text = doctor.FullName;
                lnkDoctorName.NavigateUrl = $"DoctorProfile.aspx?doctorID={doctor.DoctorID}";

                ((Literal)e.Item.FindControl("litSpecialization")).Text = doctor.Specialization;
                ((Literal)e.Item.FindControl("litYearsOfExperience")).Text = doctor.YearsOfExperience.ToString();

                var litAverageRating = (Literal)e.Item.FindControl("litAverageRating");
                litAverageRating.Text = GenerateStarRatingHtml(doctor.AverageRating);

                var imgDoctor = (Image)e.Item.FindControl("imgDoctor");
                imgDoctor.ImageUrl = doctor.ProfileImage;
                imgDoctor.AlternateText = doctor.FullName;

                ((HyperLink)e.Item.FindControl("lnkBookAppointment")).NavigateUrl = $"BookAppointment.aspx?availabilityID={doctor.AvailabilityID}";
            }
        }

        private string GenerateStarRatingHtml(double averageRating)
        {
            int fullStars = (int)averageRating;
            bool halfStar = averageRating % 1 >= 0.5;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            for (int i = 0; i < fullStars; i++)
            {
                sb.Append("<span class='star'>&#9733;</span>");
            }

            if (halfStar)
            {
                sb.Append("<span class='star'>&#9733;</span>");
            }

            for (int i = fullStars + (halfStar ? 1 : 0); i < 5; i++)
            {
                sb.Append("<span class='star'>&#9734;</span>");
            }

            return sb.ToString();
        }

        public class Doctor
        {
            public int DoctorID { get; set; }
            public string FullName { get; set; }
            public string Specialization { get; set; }
            public string City { get; set; }
            public int YearsOfExperience { get; set; }
            public string ProfileImage { get; set; }
            public double AverageRating { get; set; }
            public int AvailabilityID { get; set; }
            public List<Hospital> Hospitals { get; set; }
        }

        public class Hospital
        {
            public string HospitalName { get; set; }
            public string City { get; set; }
            public double Fees { get; set; }
        }
    }
}
