using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHub
{
    public partial class BookAppointment : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPatientDetails();
                LoadInitialData();
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
                        txtPatientName.Text = reader["PatientName"].ToString();
                        txtPatientEmail.Text = reader["Email"].ToString();
                    }
                    connection.Close();
                }
            }
            else
            {
                ShowMessage("Invalid patient session.");
            }
        }

        private void LoadInitialData()
        {
            string availabilityIDStr = Request.QueryString["AvailabilityID"];
            if (int.TryParse(availabilityIDStr, out int availabilityID))
            {
                hfAvailabilityID.Value = availabilityIDStr;
                LoadDoctorAndHospitalDetails(availabilityID);
            }
            else
            {
                ShowMessage("Invalid availability ID.");
            }
        }

        private void LoadDoctorAndHospitalDetails(int availabilityID)
        {
            ddlHospital.Items.Clear();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT DISTINCT h.HospitalID, h.HospitalName, d.FullName AS DoctorName
                    FROM DoctorAvailability da
                    JOIN Hospitals h ON da.HospitalID = h.HospitalID
                    JOIN Doctors d ON da.DoctorID = d.DoctorID
                    WHERE da.DoctorID = (SELECT DoctorID FROM DoctorAvailability WHERE AvailabilityID = @AvailabilityID)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@AvailabilityID", availabilityID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ddlHospital.Items.Add(new ListItem(reader["HospitalName"].ToString(), reader["HospitalID"].ToString()));
                    txtDoctorName.Text = reader["DoctorName"].ToString();
                }
                connection.Close();
            }

            if (ddlHospital.Items.Count > 0)
            {
                LoadAvailableDays();
            }
        }

        protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAvailableDays();
        }

        private void LoadAvailableDays()
        {
            ddlDay.Items.Clear();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT DISTINCT da.AvailableDay 
                    FROM DoctorAvailability da
                    WHERE da.HospitalID = @HospitalID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@HospitalID", ddlHospital.SelectedValue);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ddlDay.Items.Add(new ListItem(reader["AvailableDay"].ToString(), reader["AvailableDay"].ToString()));
                }
                connection.Close();
            }

            if (ddlDay.Items.Count > 0)
            {
                LoadAvailableDates();
            }
        }

        protected void ddlDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAvailableDates();
        }

        private void LoadAvailableDates()
        {
            ddlDate.Items.Clear();
            if (!string.IsNullOrEmpty(ddlDay.SelectedValue))
            {
                string selectedDay = ddlDay.SelectedValue;
                List<DateTime> dates = GenerateDatesForNextFourWeeks(selectedDay);
                foreach (var date in dates)
                {
                    ddlDate.Items.Add(new ListItem(date.ToString("yyyy-MM-dd"), date.ToString("yyyy-MM-dd")));
                }
            }

            if (ddlDate.Items.Count > 0)
            {
                LoadAvailableTimes();
            }
        }

        private List<DateTime> GenerateDatesForNextFourWeeks(string dayOfWeek)
        {
            List<DateTime> dates = new List<DateTime>();
            DateTime startDate = DateTime.Today;
            DayOfWeek selectedDay = (DayOfWeek)Enum.Parse(typeof(DayOfWeek), dayOfWeek);

            for (int i = 0; i < 4; i++)
            {
                DateTime nextDate = GetNextWeekday(startDate, selectedDay);
                dates.Add(nextDate);
                startDate = nextDate.AddDays(1); // move to the next week
            }

            return dates;
        }

        private DateTime GetNextWeekday(DateTime start, DayOfWeek day)
        {
            // The (... + 7) % 7 ensures we end up with a value in the range [0, 6]
            int daysToAdd = ((int)day - (int)start.DayOfWeek + 7) % 7;
            return start.AddDays(daysToAdd);
        }

        protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAvailableTimes();
        }

        private void LoadAvailableTimes()
        {
            ddlTime.Items.Clear();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT da.StartTime, da.EndTime 
                    FROM DoctorAvailability da
                    WHERE da.HospitalID = @HospitalID AND da.AvailableDay = @AvailableDay";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@HospitalID", ddlHospital.SelectedValue);
                command.Parameters.AddWithValue("@AvailableDay", ddlDay.SelectedValue);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    TimeSpan startTime = (TimeSpan)reader["StartTime"];
                    TimeSpan endTime = (TimeSpan)reader["EndTime"];
                    while (startTime < endTime)
                    {
                        ddlTime.Items.Add(new ListItem(startTime.ToString(@"hh\:mm"), startTime.ToString(@"hh\:mm")));
                        startTime = startTime.Add(TimeSpan.FromMinutes(20)); // 20-minute intervals
                    }
                }
                connection.Close();
            }
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            string email = Session["PatientEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("patientlogin.aspx");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO Appointments (DoctorID, PatientID, HospitalID, AppointmentDate, AppointmentTime)
                    SELECT d.DoctorID, p.PatientID, h.HospitalID, @AppointmentDate, @AppointmentTime
                    FROM DoctorAvailability da
                    JOIN Doctors d ON da.DoctorID = d.DoctorID
                    JOIN Patients p ON p.Email = @PatientEmail
                    JOIN Hospitals h ON h.HospitalID = da.HospitalID
                    WHERE da.AvailabilityID = @AvailabilityID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@AvailabilityID", hfAvailabilityID.Value);
                command.Parameters.AddWithValue("@PatientEmail", email);
                command.Parameters.AddWithValue("@AppointmentDate", ddlDate.SelectedValue);
                command.Parameters.AddWithValue("@AppointmentTime", ddlTime.SelectedValue);
                try
                {
                    connection.Open();
                    int result = command.ExecuteNonQuery();
                    connection.Close();

                    if (result > 0)
                    {
                        ShowMessage("Appointment booked successfully.");
                    }
                    else
                    {
                        ShowMessage("Failed to book appointment.");
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627) // Unique constraint violation
                    {
                        ShowMessage("The selected appointment time is already booked. Please choose another time.");
                    }
                    else
                    {
                        ShowMessage("An error occurred while booking the appointment. Please try again later.");
                    }
                }
            }
        }
    }
}

