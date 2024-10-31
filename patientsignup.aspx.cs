using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace Healthhub
{
    public partial class patientsignup : Page
    {
        // Define the default profile image paths based on gender
        private const string DefaultMaleImagePath = "pics/malepatient.png";
        private const string DefaultFemaleImagePath = "pics/femalepatient.png";
        private const string DefaultNeutralImagePath = "pics/neutralpatient.png";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Fetch input data from form fields
                    string patientName = txtPatientName.Text.Trim();
                    DateTime dob = DateTime.Parse(txtDOB.Text);
                    string email = txtEmail.Text.Trim();
                    string password = HashPassword(txtPassword.Text);
                    string phone = "+92" + txtPhone.Text.Trim();
                    string gender = ddlGender.SelectedValue;
                    string securityQuestion = ddlSecurityQuestion.SelectedValue;
                    string securityAnswer = HashPassword(txtSecurityAnswer.Text);

                    // Determine the default profile image based on gender
                    string profileImagePath = DefaultNeutralImagePath;
                    if (gender == "Male")
                    {
                        profileImagePath = DefaultMaleImagePath;
                    }
                    else if (gender == "Female")
                    {
                        profileImagePath = DefaultFemaleImagePath;
                    }

                    string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        SqlTransaction transaction = connection.BeginTransaction();

                        try
                        {
                            // Check if the email already exists
                            string checkEmailQuery = "SELECT COUNT(*) FROM Patients WHERE Email = @Email";
                            SqlCommand checkEmailCommand = new SqlCommand(checkEmailQuery, connection, transaction);
                            checkEmailCommand.Parameters.AddWithValue("@Email", email);
                            int emailCount = (int)checkEmailCommand.ExecuteScalar();

                            if (emailCount > 0)
                            {
                                ShowMessage("Email already exists. Please sign up with a different email.");
                                transaction.Rollback();
                                return;
                            }

                            // Insert new patient record
                            string insertPatientQuery = "INSERT INTO Patients (PatientName, DOB, Email, Password, Phone, Gender, ProfileImage, SecurityQuestion, SecurityAnswer) " +
                                                        "VALUES (@PatientName, @DOB, @Email, @Password, @Phone, @Gender, @ProfileImage, @SecurityQuestion, @SecurityAnswer)";

                            SqlCommand patientCommand = new SqlCommand(insertPatientQuery, connection, transaction);
                            patientCommand.Parameters.AddWithValue("@PatientName", patientName);
                            patientCommand.Parameters.AddWithValue("@DOB", dob);
                            patientCommand.Parameters.AddWithValue("@Email", email);
                            patientCommand.Parameters.AddWithValue("@Password", password);
                            patientCommand.Parameters.AddWithValue("@Phone", phone);
                            patientCommand.Parameters.AddWithValue("@Gender", gender);
                            patientCommand.Parameters.AddWithValue("@ProfileImage", profileImagePath); // Set default profile image based on gender
                            patientCommand.Parameters.AddWithValue("@SecurityQuestion", securityQuestion);
                            patientCommand.Parameters.AddWithValue("@SecurityAnswer", securityAnswer);

                            int result = patientCommand.ExecuteNonQuery();

                            // Commit the transaction
                            transaction.Commit();

                            if (result > 0)
                            {
                                ShowMessage("Registration successful!");
                                ClearForm();
                            }
                            else
                            {
                                ShowMessage("An error occurred. Please try again.");
                            }
                        }
                        catch (Exception ex)
                        {
                            // Rollback the transaction in case of error
                            transaction.Rollback();
                            ShowMessage("An error occurred: " + ex.Message);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("An error occurred: " + ex.Message);
                }
            }
        }


        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ClearForm()
        {
            txtPatientName.Text = string.Empty;
            txtDOB.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtPassword.Text = string.Empty;
            ddlGender.SelectedIndex = 0;
            chkTerms.Checked = false;
        }
    }
}
