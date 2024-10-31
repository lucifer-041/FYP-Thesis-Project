using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHub
{
    public partial class ForgotPasswordDoctor : System.Web.UI.Page
    {
            protected void Page_Load(object sender, EventArgs e)
            {
                // No additional logic required on page load
            }

            protected void txtEmail_TextChanged(object sender, EventArgs e)
            {
                LoadSecurityQuestion(txtEmail.Text);
            }

            private void LoadSecurityQuestion(string email)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT SecurityQuestion FROM Doctors WHERE Email = @Email";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", email);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        string securityQuestion = reader["SecurityQuestion"].ToString();
                        lblSecurityQuestion.Text = securityQuestion;
                        lblMessage.Text = ""; // Clear any previous error messages
                    }
                    else
                    {
                        lblSecurityQuestion.Text = "Security question not found.";
                        lblMessage.Text = "Email not found. Please try again.";
                    }
                    connection.Close();
                }
            }

            protected void btnSubmit_Click(object sender, EventArgs e)
            {
                string email = txtEmail.Text;
                string securityAnswer = txtSecurityAnswer.Text;
                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT SecurityAnswer FROM Doctors WHERE Email = @Email";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", email);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        string storedSecurityAnswer = reader["SecurityAnswer"].ToString();

                        if (VerifySecurityAnswer(securityAnswer, storedSecurityAnswer))
                        {
                            Session["ResetPasswordEmail"] = email; // Store email in session for password reset
                            Response.Redirect("ResetPasswordDoctor.aspx"); // Redirect to reset password page
                        }
                        else
                        {
                            lblMessage.Text = "Incorrect answer. Please try again.";
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Email not found. Please try again.";
                    }
                    connection.Close();
                }
            }

            private bool VerifySecurityAnswer(string enteredAnswer, string storedAnswer)
            {
                string hashedEnteredAnswer = HashAnswer(enteredAnswer);
                return hashedEnteredAnswer == storedAnswer;
            }

            private string HashAnswer(string answer)
            {
                using (SHA256 sha256 = SHA256.Create())
                {
                    byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(answer));
                    System.Text.StringBuilder builder = new System.Text.StringBuilder();
                    for (int i = 0; i < bytes.Length; i++)
                    {
                        builder.Append(bytes[i].ToString("x2"));
                    }
                    return builder.ToString();
                }
            }
        }
    }
