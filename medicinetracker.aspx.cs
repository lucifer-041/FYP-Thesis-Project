using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Configuration;
using System.Collections.Generic;
using System.Runtime.InteropServices.ComTypes;

namespace HealthHub
{
    public partial class MedicineTracker : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load patient details when the page loads for the first time
                LoadPatientDetails();
                LoadMedicineSchedule();
            }
            else
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "DeleteMedicine")
                {
                    int medicineId;
                    if (int.TryParse(eventArgument, out medicineId))
                    {
                        DeleteMedicine(medicineId);
                    }
                }
            }
        }

        private void LoadPatientDetails()
        {
            string email = Session["PatientEmail"]?.ToString();
            if (!string.IsNullOrEmpty(email))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT PatientName, Email FROM Patients WHERE Email = @Email";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        // Set patient name and email to textboxes
                        PatientName.Text = reader["PatientName"].ToString();
                        Email.Text = reader["Email"].ToString();
                    }
                    connection.Close();
                }
            }
            else
            {
                // Redirect to login page if session variable is not available
                Response.Redirect("patientlogin.aspx");
            }
        }

        private void DeleteMedicine(int medicineId)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            string deleteDoseQuery = "DELETE FROM MedicineDoses WHERE MedicineId = @MedicineId";
            string deleteMedicineQuery = "DELETE FROM Medicines WHERE Id = @MedicineId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(deleteDoseQuery, connection))
                {
                    command.Parameters.AddWithValue("@MedicineId", medicineId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand(deleteMedicineQuery, connection))
                {
                    command.Parameters.AddWithValue("@MedicineId", medicineId);
                    command.ExecuteNonQuery();
                }
            }

            Response.Write("<script>alert('Medicine schedule deleted successfully.');</script>");
            LoadMedicineSchedule(); // Reload the schedule after deleting data
        }

        private void LoadMedicineSchedule()
        {
            string email = Session["PatientEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                // Redirect to login page if session variable is not available
                Response.Redirect("Login.aspx");
                return;
            }

            string connectionString = WebConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            string query = "SELECT D.Id, M.Id AS MedicineId, M.MedicineName, D.DoseDate, D.DoseNumber, D.IsTaken " +
                           "FROM MedicineDoses D " +
                           "JOIN Medicines M ON D.MedicineId = M.Id " +
                           "JOIN Patients P ON M.PatientID = P.PatientID " +
                           "WHERE P.Email = @Email " +
                           "ORDER BY M.MedicineName, D.DoseDate, D.DoseNumber";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        StringBuilder sb = new StringBuilder();
                        string currentMedicine = null;
                        int currentMedicineId = -1;

                        while (reader.Read())
                        {
                            string medicineName = reader["MedicineName"].ToString();
                            int medicineId = (int)reader["MedicineId"];
                            if (currentMedicine != medicineName)
                            {
                                if (currentMedicine != null)
                                {
                                    sb.Append("</table>");
                                    sb.AppendFormat("<button type='button' onclick='deleteMedicine({0})' class='remove-btn'>Delete</button>", currentMedicineId);
                                    sb.Append("</div>");
                                    MedicineSchedulePlaceholder.Controls.Add(new LiteralControl(sb.ToString()));
                                    sb.Clear();
                                }

                                currentMedicine = medicineName;
                                currentMedicineId = medicineId;
                                sb.AppendFormat("<div class='schedule-wrapper'><h3>{0}</h3>", medicineName);
                                sb.Append("<table><tr><th>Date</th><th>Dose Number</th><th>Is Taken</th></tr>");
                            }

                            sb.AppendFormat("<tr><td>{0}</td><td>{1}</td><td><input type='checkbox' name='dose-{3}' class='IsTakenCheckBox' {2} /></td></tr>",
                                DateTime.Parse(reader["DoseDate"].ToString()).ToString("yyyy-MM-dd"),
                                reader["DoseNumber"],
                                Convert.ToBoolean(reader["IsTaken"]) ? "checked" : "",
                                reader["Id"]);
                        }

                        if (currentMedicine != null)
                        {
                            sb.Append("</table>");
                            sb.AppendFormat("<button type='button' onclick='deleteMedicine({0})' class='remove-btn'>Delete</button>", currentMedicineId);
                            sb.Append("</div>");
                            MedicineSchedulePlaceholder.Controls.Add(new LiteralControl(sb.ToString()));
                        }
                    }
                }
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string patientEmail = Session["PatientEmail"]?.ToString();

                if (!string.IsNullOrEmpty(patientEmail))
                {
                    int patientId = GetPatientIdByEmail(patientEmail);

                    if (patientId != -1)
                    {
                        string connectionString = WebConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
                        string insertMedicineQuery = "INSERT INTO Medicines (MedicineName, DosagesPerDay, StartDate, EndDate, PatientId) OUTPUT INSERTED.Id VALUES (@MedicineName, @DosagesPerDay, @StartDate, @EndDate, @PatientId)";

                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            using (SqlCommand command = new SqlCommand(insertMedicineQuery, connection))
                            {
                                command.Parameters.AddWithValue("@PatientId", patientId);
                                command.Parameters.AddWithValue("@MedicineName", MedicineName.Text);
                                command.Parameters.AddWithValue("@DosagesPerDay", DosagesPerDay.Text);
                                command.Parameters.AddWithValue("@StartDate", StartDate.Text);
                                command.Parameters.AddWithValue("@EndDate", EndDate.Text);

                                try
                                {
                                    connection.Open();
                                    int medicineId = (int)command.ExecuteScalar();

                                    DateTime startDate = DateTime.Parse(StartDate.Text);
                                    DateTime endDate = DateTime.Parse(EndDate.Text);

                                    List<string> doseTimes = new List<string>();
                                    if (chkMorning.Checked)
                                        doseTimes.Add("Morning");
                                    if (chkEvening.Checked)
                                        doseTimes.Add("Evening");
                                    if (chkNight.Checked)
                                        doseTimes.Add("Night");

                                    string insertDoseQuery = "INSERT INTO MedicineDoses (MedicineId, DoseDate, DoseNumber, DoseTime) VALUES (@MedicineId, @DoseDate, @DoseNumber, @DoseTime)";

                                    using (SqlCommand doseCommand = new SqlCommand(insertDoseQuery, connection))
                                    {
                                        for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
                                        {
                                            for (int doseNumber = 0; doseNumber < doseTimes.Count; doseNumber++)
                                            {
                                                doseCommand.Parameters.Clear();
                                                doseCommand.Parameters.AddWithValue("@MedicineId", medicineId);
                                                doseCommand.Parameters.AddWithValue("@DoseDate", date);
                                                doseCommand.Parameters.AddWithValue("@DoseNumber", doseNumber + 1);
                                                doseCommand.Parameters.AddWithValue("@DoseTime", doseTimes[doseNumber]);
                                                doseCommand.ExecuteNonQuery();
                                            }
                                        }
                                    }

                                    Response.Write("<script>alert('Medicine schedule added successfully.');</script>");
                                    LoadMedicineSchedule();
                                }
                                catch (Exception ex)
                                {
                                    Response.Write($"<script>alert('Error: {ex.Message}');</script>");
                                }
                            }
                        }
                    }
                }
            }
        }

        private int GetPatientIdByEmail(string email)
        {
            int patientId = -1; // Default value if not found

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT PatientID FROM Patients WHERE Email = @Email";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        patientId = Convert.ToInt32(result);
                    }
                }
            }

            return patientId;
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string updateQuery = "UPDATE MedicineDoses SET IsTaken = @IsTaken WHERE Id = @DoseId";

                foreach (string key in Request.Form.Keys)
                {
                    if (key.StartsWith("dose-"))
                    {
                        int doseId = int.Parse(key.Substring(5));
                        bool isTaken = Request.Form[key] == "on";

                        using (SqlCommand command = new SqlCommand(updateQuery, connection))
                        {
                            command.Parameters.AddWithValue("@DoseId", doseId);
                            command.Parameters.AddWithValue("@IsTaken", isTaken);
                            command.ExecuteNonQuery();
                        }
                    }
                }

                Response.Write("<script>alert('Dose status updated successfully.');</script>");
                LoadMedicineSchedule(); // Reload the schedule after updating data
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            Button deleteButton = (Button)sender;
            int medicineId = int.Parse(deleteButton.CommandArgument);

            string connectionString = WebConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            string deleteDoseQuery = "DELETE FROM MedicineDoses WHERE MedicineId = @MedicineId";
            string deleteMedicineQuery = "DELETE FROM Medicines WHERE Id = @MedicineId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(deleteDoseQuery, connection))
                {
                    command.Parameters.AddWithValue("@MedicineId", medicineId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand(deleteMedicineQuery, connection))
                {
                    command.Parameters.AddWithValue("@MedicineId", medicineId);
                    command.ExecuteNonQuery();
                }
            }

            Response.Write("<script>alert('Medicine schedule deleted successfully.');</script>");
            LoadMedicineSchedule(); // Reload the schedule after deleting data
        }
    }
}
