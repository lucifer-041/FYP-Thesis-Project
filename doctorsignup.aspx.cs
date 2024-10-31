using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;

namespace Healthhub
{
    public partial class doctorsignup : Page
    {
        // Define the default profile image path
        private const string DefaultProfileImagePath = "pics/neutraldoctor.jpg";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdowns();
            }
        }

        private void LoadDropdowns()
        {
            // Clear existing items before adding new ones
            spec.Items.Clear();
            city.Items.Clear();
            Hosp.Items.Clear();

            // Populate the Specialization DropDownList
            spec.Items.Add(new ListItem("Select Specialization", ""));
            spec.Items.Add(new ListItem("Allergist/Immunologist", "Allergist/Immunologist"));
            spec.Items.Add(new ListItem("Anesthesiologist", "Anesthesiologist"));
            spec.Items.Add(new ListItem("Cardiologist", "Cardiologist"));
            spec.Items.Add(new ListItem("Dentist", "Dentist"));
            spec.Items.Add(new ListItem("Dermatologist", "Dermatologist"));
            spec.Items.Add(new ListItem("Emergency Medicine Specialist", "Emergency Medicine Specialist"));
            spec.Items.Add(new ListItem("Endocrinologist", "Endocrinologist"));
            spec.Items.Add(new ListItem("Family Medicine Physician", "Family Medicine Physician"));
            spec.Items.Add(new ListItem("Gastroenterologist", "Gastroenterologist"));
            spec.Items.Add(new ListItem("General Physician", "General Physician"));
            spec.Items.Add(new ListItem("Geriatrician", "Geriatrician"));
            spec.Items.Add(new ListItem("Hematologist", "Hematologist"));
            spec.Items.Add(new ListItem("Hepatologist", "Hepatologist"));
            spec.Items.Add(new ListItem("Infectious Disease Specialist", "Infectious Disease Specialist"));
            spec.Items.Add(new ListItem("Internist", "Internist"));
            spec.Items.Add(new ListItem("Nephrologist", "Nephrologist"));
            spec.Items.Add(new ListItem("Neurologist", "Neurologist"));
            spec.Items.Add(new ListItem("Obstetrician and Gynecologist (OB-GYN)", "Obstetrician and Gynecologist (OB-GYN)"));
            spec.Items.Add(new ListItem("Oncologist", "Oncologist"));
            spec.Items.Add(new ListItem("Ophthalmologist", "Ophthalmologist"));
            spec.Items.Add(new ListItem("Orthopedist/Orthopedic Surgeon", "Orthopedist/Orthopedic Surgeon"));
            spec.Items.Add(new ListItem("Otolaryngologist (ENT specialist)", "Otolaryngologist (ENT specialist)"));
            spec.Items.Add(new ListItem("Pathologist", "Pathologist"));
            spec.Items.Add(new ListItem("Pediatrician", "Pediatrician"));
            spec.Items.Add(new ListItem("Psychiatrist", "Psychiatrist"));
            spec.Items.Add(new ListItem("Pulmonologist", "Pulmonologist"));
            spec.Items.Add(new ListItem("Radiologist", "Radiologist"));
            spec.Items.Add(new ListItem("Rheumatologist", "Rheumatologist"));
            spec.Items.Add(new ListItem("Sleep Medicine Specialist", "Sleep Medicine Specialist"));
            spec.Items.Add(new ListItem("Sports Medicine Specialist", "Sports Medicine Specialist"));
            spec.Items.Add(new ListItem("Urologist", "Urologist"));
            // Add more items similarly

            // Populate the City DropDownList
            city.Items.Add(new ListItem("Select City", ""));
            city.Items.Add(new ListItem("Karachi", "Karachi"));
            city.Items.Add(new ListItem("Lahore", "Lahore"));
            city.Items.Add(new ListItem("Islamabad", "Islamabad"));
            city.Items.Add(new ListItem("Quetta", "Quetta"));
            city.Items.Add(new ListItem("Peshawar", "Peshawar"));
            city.Items.Add(new ListItem("Multan", "Multan"));
            city.Items.Add(new ListItem("Faislabad", "Faislabad"));
            city.Items.Add(new ListItem("Rawalpindi", "Rawalpindi"));
            city.Items.Add(new ListItem("Hyderabad", "Hyderabad"));
            city.Items.Add(new ListItem("Sukkur", "Sukkur"));
        }

        protected void city_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadHospitals(city.SelectedValue);
        }

        private void LoadHospitals(string cityName)
        {
            Hosp.Items.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT HospitalID, HospitalName FROM Hospitals WHERE City = @City";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@City", cityName);

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ListItem item = new ListItem(reader["HospitalName"].ToString(), reader["HospitalID"].ToString());
                    Hosp.Items.Add(item);
                }
            }

            // Refresh the Select2 dropdown after data load
            ScriptManager.RegisterStartupScript(this, this.GetType(), "refreshSelect2", "$('#" + Hosp.ClientID + "').select2({ placeholder: 'Select hospitals', allowClear: true, width: '100%' });", true);
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string fullName = txtfullname.Text;
            string email = txtemail.Text;
            string password = HashPassword(txtpassword.Text);
            string phone = "+92" + txtphone.Text;
            string specialization = spec.SelectedValue;
            string city = this.city.SelectedValue;
            string medicalLicenseNumber = txtlicense.Text;
            int yearsOfExperience = int.Parse(txtexperience.Text);
            string bio = txtbio.Text;
            string securityQuestion = ddlSecurityQuestion.SelectedValue;
            string securityAnswer = HashPassword(txtSecurityAnswer.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    string insertDoctorQuery = "INSERT INTO Doctors (FullName, Email, Password, Phone, Specialization, City, MedicalLicenseNumber, YearsOfExperience, Bio, ProfileImage, SecurityQuestion, SecurityAnswer) " +
                                               "VALUES (@FullName, @Email, @Password, @Phone, @Specialization, @City, @MedicalLicenseNumber, @YearsOfExperience, @Bio, @ProfileImage, @SecurityQuestion, @SecurityAnswer); " +
                                               "SELECT SCOPE_IDENTITY();";

                    SqlCommand doctorCommand = new SqlCommand(insertDoctorQuery, connection, transaction);
                    doctorCommand.Parameters.AddWithValue("@FullName", fullName);
                    doctorCommand.Parameters.AddWithValue("@Email", email);
                    doctorCommand.Parameters.AddWithValue("@Password", password);
                    doctorCommand.Parameters.AddWithValue("@Phone", phone);
                    doctorCommand.Parameters.AddWithValue("@Specialization", specialization);
                    doctorCommand.Parameters.AddWithValue("@City", city);
                    doctorCommand.Parameters.AddWithValue("@MedicalLicenseNumber", medicalLicenseNumber);
                    doctorCommand.Parameters.AddWithValue("@YearsOfExperience", yearsOfExperience);
                    doctorCommand.Parameters.AddWithValue("@Bio", bio);
                    doctorCommand.Parameters.AddWithValue("@ProfileImage", DefaultProfileImagePath); // Set default profile image
                    doctorCommand.Parameters.AddWithValue("@SecurityQuestion", securityQuestion);
                    doctorCommand.Parameters.AddWithValue("@SecurityAnswer", securityAnswer);

                    int doctorId = Convert.ToInt32(doctorCommand.ExecuteScalar());

                    foreach (ListItem item in Hosp.Items)
                    {
                        if (item.Selected)
                        {
                            int hospitalId = Convert.ToInt32(item.Value);

                            // Insert into DoctorHospitals table
                            string insertDoctorHospitalQuery = "INSERT INTO DoctorHospitals (DoctorID, HospitalID) VALUES (@DoctorID, @HospitalID)";
                            SqlCommand insertDoctorHospitalCommand = new SqlCommand(insertDoctorHospitalQuery, connection, transaction);
                            insertDoctorHospitalCommand.Parameters.AddWithValue("@DoctorID", doctorId);
                            insertDoctorHospitalCommand.Parameters.AddWithValue("@HospitalID", hospitalId);

                            insertDoctorHospitalCommand.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    ShowMessage("Registration successful!");
                    // Clear all fields
                    ClearForm();
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627 || ex.Number == 2601)
                    {
                        ShowMessage("A doctor with this email or medical license number already exists.");
                    }
                    else
                    {
                        ShowMessage("Error: " + ex.Message);
                    }

                    transaction.Rollback();
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
            txtfullname.Text = string.Empty;
            txtemail.Text = string.Empty;
            txtpassword.Text = string.Empty;
            txtphone.Text = string.Empty;
            spec.SelectedIndex = 0;
            city.SelectedIndex = 0;
            Hosp.ClearSelection();
            txtlicense.Text = string.Empty;
            txtexperience.Text = string.Empty;
            txtbio.Text = string.Empty;
            ddlSecurityQuestion.SelectedIndex = 0;
            txtSecurityAnswer.Text = string.Empty;
            chkTerms.Checked = false;
        }
    }
}
