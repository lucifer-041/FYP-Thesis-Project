using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHub
{
    public partial class EditDoctorProfile : Page
    {
        private const string DefaultProfileImagePath = "~/pics/neutraldoctor.jpg";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDoctorProfile();
                LoadDoctorHospitals();
            }
        }

        private void LoadDoctorProfile()
        {
            string email = Session["DoctorEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("doctorlogin.aspx");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Doctors WHERE Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    txtFullName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtSpecialization.Text = reader["Specialization"].ToString();
                    txtMedicalLicenseNumber.Text = reader["MedicalLicenseNumber"].ToString();
                    txtYearsOfExperience.Text = reader["YearsOfExperience"].ToString();
                    txtBio.Text = reader["Bio"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                    txtEducation.Text = reader["Education"].ToString();
                    txtSpecializations.Text = reader["Specializations"].ToString();
                    string profileImagePath = reader["ProfileImage"].ToString();

                    imgProfile.ImageUrl = string.IsNullOrEmpty(profileImagePath) ? DefaultProfileImagePath : profileImagePath;
                }
                connection.Close();
            }
        }

        private void LoadDoctorHospitals()
        {
            string email = Session["DoctorEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("doctorlogin.aspx");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT dh.DoctorID, dh.HospitalID, h.HospitalName, dh.Fees
            FROM DoctorHospitals dh
            INNER JOIN Hospitals h ON dh.HospitalID = h.HospitalID
            INNER JOIN Doctors d ON dh.DoctorID = d.DoctorID
            WHERE d.Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                var hospitals = new List<dynamic>();
                while (reader.Read())
                {
                    hospitals.Add(new
                    {
                        DoctorID = reader["DoctorID"],
                        HospitalID = reader["HospitalID"],
                        HospitalName = reader["HospitalName"],
                        Fees = reader["Fees"]
                    });
                }
                rptHospitals.DataSource = hospitals;
                rptHospitals.DataBind();
                connection.Close();
            }
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        protected void btnSaveFees_Click(object sender, EventArgs e)
        {
            bool allFeesFilled = true;
            foreach (RepeaterItem item in rptHospitals.Items)
            {
                var txtFees = (TextBox)item.FindControl("txtFees");
                if (string.IsNullOrWhiteSpace(txtFees.Text))
                {
                    allFeesFilled = false;
                    break;
                }
            }

            if (!allFeesFilled)
            {
                ShowMessage("Please fill in all the fees before saving.");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                foreach (RepeaterItem item in rptHospitals.Items)
                {
                    var txtFees = (TextBox)item.FindControl("txtFees");
                    var hfDoctorID = (HiddenField)item.FindControl("hfDoctorID");
                    var hfHospitalID = (HiddenField)item.FindControl("hfHospitalID");
                    int fees = int.Parse(txtFees.Text);
                    int doctorID = int.Parse(hfDoctorID.Value);
                    int hospitalID = int.Parse(hfHospitalID.Value);

                    string query = "UPDATE DoctorHospitals SET Fees = @Fees WHERE DoctorID = @DoctorID AND HospitalID = @HospitalID";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Fees", fees);
                    command.Parameters.AddWithValue("@DoctorID", doctorID);
                    command.Parameters.AddWithValue("@HospitalID", hospitalID);
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }
            ShowMessage("Fees updated successfully!");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = Session["DoctorEmail"]?.ToString();
                if (string.IsNullOrEmpty(email))
                {
                    Response.Redirect("doctorlogin.aspx");
                    return;
                }

                string fullName = txtFullName.Text;
                string specialization = txtSpecialization.Text;
                string medicalLicenseNumber = txtMedicalLicenseNumber.Text;
                int yearsOfExperience = int.Parse(txtYearsOfExperience.Text);
                string bio = txtBio.Text;
                string phone = txtPhone.Text;
                string education = txtEducation.Text;
                string specializations = txtSpecializations.Text;

                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Doctors SET FullName = @FullName, Specialization = @Specialization, MedicalLicenseNumber = @MedicalLicenseNumber, YearsOfExperience = @YearsOfExperience, Bio = @Bio, Phone = @Phone,Education = @Education, Specializations = @Specializations, ProfileImage = @ProfileImage WHERE Email = @Email";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@FullName", fullName);
                    command.Parameters.AddWithValue("@Specialization", specialization);
                    command.Parameters.AddWithValue("@MedicalLicenseNumber", medicalLicenseNumber);
                    command.Parameters.AddWithValue("@YearsOfExperience", yearsOfExperience);
                    command.Parameters.AddWithValue("@Bio", bio);
                    command.Parameters.AddWithValue("@Phone", phone);
                    command.Parameters.AddWithValue("@Education", education);
                    command.Parameters.AddWithValue("@Specializations", specializations);
                    command.Parameters.AddWithValue("@ProfileImage", imgProfile.ImageUrl); // Use the existing image URL
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    connection.Close();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Profile updated successfully!");
                    }
                    else
                    {
                        ShowMessage("An error occurred while updating the profile. Please try again.");
                    }
                }
            }
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            if (fuProfileImage.HasFile)
            {
                string email = Session["DoctorEmail"]?.ToString();
                if (string.IsNullOrEmpty(email))
                {
                    Response.Redirect("doctorlogin.aspx");
                    return;
                }

                string fileName = Path.GetFileName(fuProfileImage.PostedFile.FileName);
                string folderPath = Server.MapPath("~/Images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                string filePath = folderPath + fileName;
                fuProfileImage.SaveAs(filePath);

                string relativeFilePath = "~/Images/" + fileName;
                imgProfile.ImageUrl = relativeFilePath;

                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Doctors SET ProfileImage = @ProfileImage WHERE Email = @Email";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@ProfileImage", relativeFilePath);
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }

                ShowMessage("Image uploaded successfully!");
            }
            else
            {
                ShowMessage("Please select an image to upload.");
            }
        }
    }
}
