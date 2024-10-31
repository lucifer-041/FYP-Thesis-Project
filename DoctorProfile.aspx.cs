using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace HealthHub
{
    public partial class DoctorProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int doctorId;
                if (int.TryParse(Request.QueryString["doctorID"], out doctorId))
                {
                    LoadDoctorProfile(doctorId);
                }
            }
        }

        private void LoadDoctorProfile(int doctorId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
        SELECT 
            d.FullName, d.Specialization, d.YearsOfExperience, d.Bio, 
            d.Education, d.Specializations, d.ProfileImage,
            ISNULL(AVG(dr.Rating), 0) AS AverageRating, 
            COUNT(dr.ReviewID) AS ReviewCount,
            COUNT(CASE WHEN dr.Recommend = 'I recommend this doctor' THEN 1 END) AS SatisfiedPatients
        FROM Doctors d
        LEFT JOIN DoctorReviews dr ON d.DoctorID = dr.DoctorID
        WHERE d.DoctorID = @DoctorID
        GROUP BY d.FullName, d.Specialization, d.YearsOfExperience, d.Bio, 
                 d.Education, d.Specializations, d.ProfileImage;
        
        SELECT 
            h.HospitalName, h.City, dh.Fees,
            da.AvailableDay, da.StartTime, da.EndTime
        FROM DoctorHospitals dh
        INNER JOIN Hospitals h ON dh.HospitalID = h.HospitalID
        LEFT JOIN DoctorAvailability da ON dh.DoctorID = da.DoctorID AND dh.HospitalID = da.HospitalID
        WHERE dh.DoctorID = @DoctorID;
        
        SELECT 
            Recommend, Rating, ReviewText, ReviewDate 
        FROM DoctorReviews
        WHERE DoctorID = @DoctorID;";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@DoctorID", doctorId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow doctorRow = ds.Tables[0].Rows[0];
                    lblFullName.Text = doctorRow["FullName"].ToString();
                    lblFullNameAbout.Text = doctorRow["FullName"].ToString();
                    lblSpecialization.Text = doctorRow["Specialization"].ToString();
                    lblYearsOfExperience.Text = doctorRow["YearsOfExperience"].ToString();

                    lblBioDetail.Text = doctorRow["Bio"].ToString();
                    lblSatisfiedPatients.Text = doctorRow["SatisfiedPatients"].ToString();

                    lblEducation.Text = doctorRow["Education"].ToString();
                    lblSpecializations.Text = doctorRow["Specializations"].ToString();
                    lblReviewCount.Text = doctorRow["ReviewCount"].ToString();

                    // Set profile image
                    string profileImagePath = doctorRow["ProfileImage"] != DBNull.Value ? doctorRow["ProfileImage"].ToString() : "pics/F-doc.jpg";
                    imgDoctor.ImageUrl = profileImagePath;

                    StringBuilder stars = new StringBuilder();
                    int averageRating = Convert.ToInt32(doctorRow["AverageRating"]);
                    for (int i = 0; i < averageRating; i++)
                    {
                        stars.Append("★");
                    }
                    litStars.Text = stars.ToString();
                }

                if (ds.Tables[1].Rows.Count > 0)
                {
                    var hospitalGroups = ds.Tables[1].AsEnumerable()
                        .GroupBy(row => new
                        {
                            HospitalName = row.Field<string>("HospitalName"),
                            City = row.Field<string>("City"),
                            Fees = row.Field<int>("Fees")
                        })
                        .Select(g => new
                        {
                            g.Key.HospitalName,
                            g.Key.City,
                            g.Key.Fees,
                            Availability = g.Select(row => new
                            {
                                AvailableDay = row.Field<string>("AvailableDay"),
                                StartTime = row.Field<TimeSpan?>("StartTime")?.ToString(@"hh\:mm"),
                                EndTime = row.Field<TimeSpan?>("EndTime")?.ToString(@"hh\:mm")
                            })
                        }).ToList();

                    rptHospitals.DataSource = hospitalGroups;
                    rptHospitals.DataBind();
                }

                if (ds.Tables[2].Rows.Count > 0)
                {
                    rptReviews.DataSource = ds.Tables[2];
                    rptReviews.DataBind();
                }
            }
        }

        public static string GetStarRating(int rating)
        {
            StringBuilder stars = new StringBuilder();
            for (int i = 0; i < rating; i++)
            {
                stars.Append("★");
            }
            return stars.ToString();
        }
    }
}
