using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace Healthhub
{
    public partial class DoctorDashboard : Page
    {
        private const string DefaultProfileImagePath = "pics/neutraldoctor.jpg";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDoctorDetails();
                LoadDoctorAvailability();
                LoadDoctorAppointments();
                LoadConfirmedAppointments();
                LoadPreviousAppointments();
            }
        }

        private void LoadDoctorDetails()
        {
            string email = Session["DoctorEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT FullName, Email, Specialization, YearsOfExperience, ProfileImage FROM Doctors WHERE Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    lblDoctorName.Text = reader["FullName"].ToString();
                    lblDoctorNameHeader.Text = reader["FullName"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    lblSpecialization.Text = reader["Specialization"].ToString();
                    lblExperience.Text = reader["YearsOfExperience"].ToString();
                    imgProfile.ImageUrl = reader["ProfileImage"].ToString();
                }
                connection.Close();
            }
        }

        private void LoadDoctorAvailability()
        {
            string email = Session["DoctorEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT h.HospitalName, a.AvailableDay, a.StartTime, a.EndTime
                    FROM DoctorAvailability a
                    JOIN Hospitals h ON a.HospitalID = h.HospitalID
                    JOIN Doctors d ON a.DoctorID = d.DoctorID
                    WHERE d.Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();

                    var hospitalGroups = dt.AsEnumerable()
                                           .GroupBy(row => row.Field<string>("HospitalName"));

                    foreach (var group in hospitalGroups)
                    {
                        sb.AppendLine("<table class='table'>");
                        sb.AppendLine("<tr><th colspan='3'>" + group.Key + "</th></tr>");
                        sb.AppendLine("<tr><th>Available Days</th><th>Start Time</th><th>End Time</th></tr>");

                        foreach (var row in group)
                        {
                            sb.AppendLine("<tr>");
                            sb.AppendLine($"<td>{row["AvailableDay"]}</td>");
                            sb.AppendLine($"<td>{FormatTime(row["StartTime"])}</td>");
                            sb.AppendLine($"<td>{FormatTime(row["EndTime"])}</td>");
                            sb.AppendLine("</tr>");
                        }

                        sb.AppendLine("</table><br>");
                    }

                    ltAvailabilityData.Text = sb.ToString();
                }
                else
                {
                    ltAvailabilityData.Text = "<p>No availability data found. Please add it.</p>";
                }

                connection.Close();
            }
        }

        private string FormatTime(object time)
        {
            if (time is TimeSpan)
            {
                return ((TimeSpan)time).ToString(@"hh\:mm");
            }
            else if (time is DateTime)
            {
                return ((DateTime)time).ToString("HH:mm");
            }
            else
            {
                return time.ToString();
            }
        }

        private void LoadDoctorAppointments()
        {
            string email = Session["DoctorEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT ROW_NUMBER() OVER (ORDER BY a.AppointmentDate ASC) AS SerialNumber, a.AppointmentID, p.PatientName, h.HospitalName, a.AppointmentDate, a.AppointmentTime, a.Status
                    FROM Appointments a
                    JOIN Patients p ON a.PatientID = p.PatientID
                    JOIN Hospitals h ON a.HospitalID = h.HospitalID
                    JOIN Doctors d ON a.DoctorID = d.DoctorID
                    WHERE d.Email = @Email AND a.Status = 'Pending'";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("<table class='table'>");
                    sb.AppendLine("<tr><th>Serial Number</th><th>Patient Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th><th>Actions</th><th>Status</th></tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sb.AppendLine($"<td>{row["PatientName"]}</td>");
                        sb.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}</td>");
                        sb.AppendLine($"<td>{((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}</td>");
                        sb.AppendLine($"<td>{row["Status"]}</td>");
                        sb.AppendLine($"<td><button type='submit' class='btn btn-confirm' name='confirm' value='{row["AppointmentID"]}'>Confirm</button> <button type='submit' class='btn btn-reject' name='reject' value='{row["AppointmentID"]}'>Reject</button></td>");
                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltAppointmentData.Text = sb.ToString();
                }
                else
                {
                    ltAppointmentData.Text = "<p>No appointments found.</p>";
                }

                connection.Close();
            }
        }

        private void LoadConfirmedAppointments()
        {
            string email = Session["DoctorEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT ROW_NUMBER() OVER (ORDER BY a.AppointmentDate ASC) AS SerialNumber, p.PatientID, p.PatientName, h.HospitalName, a.AppointmentDate, a.AppointmentTime
            FROM Appointments a
            JOIN Patients p ON a.PatientID = p.PatientID
            JOIN Hospitals h ON a.HospitalID = h.HospitalID
            JOIN Doctors d ON a.DoctorID = d.DoctorID
            WHERE d.Email = @Email AND a.Status = 'Confirmed' AND a.AppointmentDate >= @Today
            ORDER BY a.AppointmentDate ASC";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Today", DateTime.Today);

                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("<table class='table'>");
                    sb.AppendLine("<tr><th>Serial Number</th><th>Patient Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th><th>View Medical Records</th></tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sb.AppendLine($"<td>{row["PatientName"]}</td>");
                        sb.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}</td>");
                        sb.AppendLine($"<td>{((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}</td>");
                        sb.AppendLine($"<td><a href='ViewMedicalRecords.aspx?patientId={row["PatientID"]}' class='top-right-link'>View Records</a></td>");
                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltConfirmedAppointments.Text = sb.ToString();
                }
                else
                {
                    ltConfirmedAppointments.Text = "<p>No confirmed appointments found.</p>";
                }

                connection.Close();
            }
        }

        private void LoadPreviousAppointments()
        {
            string email = Session["DoctorEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT ROW_NUMBER() OVER (ORDER BY a.AppointmentDate DESC) AS SerialNumber, p.PatientName, h.HospitalName, a.AppointmentDate, a.AppointmentTime, a.Status
                    FROM Appointments a
                    JOIN Patients p ON a.PatientID = p.PatientID
                    JOIN Hospitals h ON a.HospitalID = h.HospitalID
                    JOIN Doctors d ON a.DoctorID = d.DoctorID
                    WHERE d.Email = @Email AND a.AppointmentDate < @Today AND a.Status = 'Confirmed'
                    ORDER BY a.AppointmentDate DESC";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@Today", DateTime.Today);

                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("<table class='table'>");
                    sb.AppendLine("<tr><th>Serial Number</th><th>Patient Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th><th>Status</th></tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sb.AppendLine($"<td>{row["PatientName"]}</td>");
                        sb.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}</td>");
                        sb.AppendLine($"<td>{((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}</td>");
                        sb.AppendLine($"<td>{row["Status"]}</td>");
                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltPreviousAppointments.Text = sb.ToString();
                }
                else
                {
                    ltPreviousAppointments.Text = "<p>No previous appointments found.</p>";
                }

                connection.Close();
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (Request.Form["confirm"] != null)
                {
                    int appointmentId = int.Parse(Request.Form["confirm"]);
                    UpdateAppointmentStatus(appointmentId, "Confirmed");
                    hfStatusMessage.Value = "Appointment confirmed successfully.";
                }
                else if (Request.Form["reject"] != null)
                {
                    int appointmentId = int.Parse(Request.Form["reject"]);
                    CancelAppointment(appointmentId);
                    hfStatusMessage.Value = "Appointment cancelled successfully.";
                }

                LoadDoctorAppointments();
                LoadConfirmedAppointments();
                LoadPreviousAppointments();
            }
        }

        private void UpdateAppointmentStatus(int appointmentId, string status)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Appointments SET Status = @Status WHERE AppointmentID = @AppointmentID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Status", status);
                command.Parameters.AddWithValue("@AppointmentID", appointmentId);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        private void CancelAppointment(int appointmentId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Begin transaction
                SqlTransaction transaction;
                connection.Open();
                transaction = connection.BeginTransaction();

                try
                {
                    // Insert into CancelledAppointments
                    string insertQuery = @"
                        INSERT INTO CancelledAppointments (AppointmentID, DoctorID, PatientID, HospitalID, AppointmentDate, AppointmentTime)
                        SELECT AppointmentID, DoctorID, PatientID, HospitalID, AppointmentDate, AppointmentTime
                        FROM Appointments
                        WHERE AppointmentID = @AppointmentID";
                    SqlCommand insertCommand = new SqlCommand(insertQuery, connection, transaction);
                    insertCommand.Parameters.AddWithValue("@AppointmentID", appointmentId);
                    insertCommand.ExecuteNonQuery();

                    // Delete from Appointments
                    string deleteQuery = "DELETE FROM Appointments WHERE AppointmentID = @AppointmentID";
                    SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection, transaction);
                    deleteCommand.Parameters.AddWithValue("@AppointmentID", appointmentId);
                    deleteCommand.ExecuteNonQuery();

                    // Commit transaction
                    transaction.Commit();
                }
                catch (Exception)
                {
                    // Rollback transaction in case of error
                    transaction.Rollback();
                    throw;
                }
                finally
                {
                    connection.Close();
                }
            }
        }
    }
}
