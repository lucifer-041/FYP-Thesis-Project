using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace HealthHub
{
    public partial class Endocrinologist : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCitiesDropdown();
                LoadEndocrinologists();
            }
        }

        private void LoadEndocrinologists()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            DataTable dataTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetEndocrinologists", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                int? minExperience = !string.IsNullOrEmpty(txtMinExperience.Text) ? (int?)Convert.ToInt32(txtMinExperience.Text) : null;
                float? minRating = !string.IsNullOrEmpty(txtMinRating.Text) ? (float?)Convert.ToDouble(txtMinRating.Text) : null;
                string city = ddlCity.SelectedValue;

                cmd.Parameters.AddWithValue("@MinExperience", minExperience ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@MinRating", minRating ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(city) ? (object)DBNull.Value : city);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dataTable);
            }

            var doctorDictionary = new Dictionary<int, List<DataRow>>();
            foreach (DataRow row in dataTable.Rows)
            {
                int doctorID = Convert.ToInt32(row["DoctorID"]);
                if (!doctorDictionary.ContainsKey(doctorID))
                {
                    doctorDictionary[doctorID] = new List<DataRow>();
                }
                doctorDictionary[doctorID].Add(row);
            }

            var doctors = new List<Dictionary<string, object>>();
            foreach (var entry in doctorDictionary)
            {
                var doctorRows = entry.Value;
                var firstRow = doctorRows[0];

                var hospitals = doctorRows.GroupBy(r => r["HospitalName"])
                                          .Select(g => g.First())
                                          .Select(row => new
                                          {
                                              HospitalName = row["HospitalName"],
                                              City = row["City"],
                                              Fees = row["Fees"]
                                          }).ToList();

                var doctor = new Dictionary<string, object>
                {
                    { "DoctorID", firstRow["DoctorID"] },
                    { "FullName", firstRow["FullName"] },
                    { "Specialization", firstRow["Specialization"] },
                    { "YearsOfExperience", firstRow["YearsOfExperience"] },
                    { "AverageRating", firstRow["AverageRating"] != DBNull.Value ? firstRow["AverageRating"] : 0.0 },
                    { "AvailabilityID", firstRow["AvailabilityID"] },
                    { "Hospitals", hospitals },
                    { "ProfileImage", firstRow["ProfileImage"] != DBNull.Value ? firstRow["ProfileImage"].ToString() : "Images/neutraldoctor.jpg" }
                };

                doctors.Add(doctor);
            }

            rptEndocrinologists.DataSource = doctors;
            rptEndocrinologists.DataBind();
        }

        protected void rptEndocrinologists_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var doctor = (Dictionary<string, object>)e.Item.DataItem;
                var rptHospitals = (Repeater)e.Item.FindControl("rptHospitals");
                rptHospitals.DataSource = doctor["Hospitals"];
                rptHospitals.DataBind();

                var lnkDoctorName = (HyperLink)e.Item.FindControl("lnkDoctorName");
                lnkDoctorName.Text = doctor["FullName"].ToString();
                lnkDoctorName.NavigateUrl = $"DoctorProfile.aspx?doctorID={doctor["DoctorID"]}";

                ((Literal)e.Item.FindControl("litSpecialization")).Text = doctor["Specialization"].ToString();
                ((Literal)e.Item.FindControl("litYearsOfExperience")).Text = doctor["YearsOfExperience"].ToString();

                var litAverageRating = (Literal)e.Item.FindControl("litAverageRating");
                double averageRating = doctor["AverageRating"] != DBNull.Value ? Convert.ToDouble(doctor["AverageRating"]) : 0.0;
                litAverageRating.Text = GenerateStarRatingHtml(averageRating);

                var imgDoctor = (Image)e.Item.FindControl("imgDoctor");
                imgDoctor.ImageUrl = doctor["ProfileImage"].ToString();
                imgDoctor.AlternateText = doctor["FullName"].ToString();

                ((HyperLink)e.Item.FindControl("lnkBookAppointment")).NavigateUrl = $"BookAppointment.aspx?availabilityID={doctor["AvailabilityID"]}";
            }
        }

        private void PopulateCitiesDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            DataTable dataTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT City FROM Hospitals", conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dataTable);
            }

            ddlCity.DataSource = dataTable;
            ddlCity.DataTextField = "City";
            ddlCity.DataValueField = "City";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("Select City", ""));
        }

        private string GenerateStarRatingHtml(double averageRating)
        {
            int fullStars = (int)averageRating;
            bool halfStar = averageRating % 1 >= 0.5;

            StringBuilder sb = new StringBuilder();

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

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadEndocrinologists();
        }

        protected void btnFindNearby_Click(object sender, EventArgs e)
        {
            string specialization = "Endocrinologist";
            Response.Redirect($"Location.aspx?specialization={specialization}");
        }
    }
}
