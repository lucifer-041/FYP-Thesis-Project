using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace Healthhub
{
    public partial class PatientDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPatientDetails();
                LoadPatientAppointments();
                LoadCancelledAppointments();
                LoadMedicalRecords();
                LoadHealthMetrics();
            }

            // Handle delete request separately
            if (Request.QueryString["deleteRecord"] == "true")
            {
                int recordId;
                if (int.TryParse(Request.QueryString["recordId"], out recordId))
                {
                    DeleteMedicalRecord(recordId);
                }
            }
        }



        private void LoadPatientDetails()
        {
            string email = Session["PatientEmail"].ToString(); // Assuming the email is stored in the session after login
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT PatientName, Email, Phone, DOB, ProfileImage FROM Patients WHERE Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    lblPatientName.Text = reader["PatientName"].ToString();
                    lblPatientNameHeader.Text = reader["PatientName"].ToString();
                    lblPhone.Text = reader["Phone"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    lblDOB.Text = Convert.ToDateTime(reader["DOB"]).ToString("dd MMM yyyy"); // Format the date as needed
                    string profileImagePath = reader["ProfileImage"].ToString();
                    if (!string.IsNullOrEmpty(profileImagePath))
                    {
                        imgDashboardProfile.ImageUrl = profileImagePath;
                    }
                }
                connection.Close();
            }
        }

        private void LoadPatientAppointments()
        {
            string email = Session["PatientEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Load upcoming appointments
                string upcomingQuery = @"
        SELECT ROW_NUMBER() OVER (ORDER BY a.AppointmentDate ASC) AS SerialNumber, 
               d.FullName AS DoctorName, 
               h.HospitalName, 
               a.AppointmentDate, 
               a.AppointmentTime, 
               a.Status,
               dh.Fees,
               a.AppointmentID,
               p.PatientName
        FROM Appointments a
        JOIN Doctors d ON a.DoctorID = d.DoctorID
        JOIN Hospitals h ON a.HospitalID = h.HospitalID
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN DoctorHospitals dh ON a.DoctorID = dh.DoctorID AND a.HospitalID = dh.HospitalID
        WHERE p.Email = @Email AND a.AppointmentDate >= @Today
        ORDER BY a.AppointmentDate ASC";

                SqlCommand upcomingCommand = new SqlCommand(upcomingQuery, connection);
                upcomingCommand.Parameters.AddWithValue("@Email", email);
                upcomingCommand.Parameters.AddWithValue("@Today", DateTime.Today);

                connection.Open();
                SqlDataAdapter daUpcoming = new SqlDataAdapter(upcomingCommand);
                DataTable upcomingDt = new DataTable();
                daUpcoming.Fill(upcomingDt);

                if (upcomingDt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("<table class='table'>");
                    sb.AppendLine("<tr><th>Serial Number</th><th>Doctor Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th><th>Status</th><th>Fees</th><th>Invoice</th></tr>");

                    foreach (DataRow row in upcomingDt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sb.AppendLine($"<td>{row["DoctorName"]}</td>");
                        sb.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}</td>");
                        sb.AppendLine($"<td>{((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}</td>");
                        sb.AppendLine($"<td>{row["Status"]}</td>");
                        sb.AppendLine($"<td>{row["Fees"]}</td>");

                        if (row["Status"].ToString() == "Confirmed")
                        {
                            sb.AppendLine($"<td><a href='PatientDashboard.aspx?generateInvoice=true&appointmentId={row["AppointmentID"]}&appointmentDate={((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}&appointmentTime={((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}' target='_blank'>Generate Invoice</a></td>");
                        }
                        else
                        {
                            sb.AppendLine("<td>Pending</td>");
                        }

                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltUpcomingAppointmentsData.Text = sb.ToString();
                }
                else
                {
                    ltUpcomingAppointmentsData.Text = "<p>No upcoming appointments found.</p>";
                }

                connection.Close();

                // Load previous appointments
                string previousQuery = @"
    SELECT ROW_NUMBER() OVER (ORDER BY a.AppointmentDate DESC) AS SerialNumber, 
           d.FullName AS DoctorName, 
           h.HospitalName, 
           a.AppointmentDate, 
           a.AppointmentTime, 
           a.Status,
           a.AppointmentID,
           p.PatientName
    FROM Appointments a
    JOIN Doctors d ON a.DoctorID = d.DoctorID
    JOIN Hospitals h ON a.HospitalID = h.HospitalID
    JOIN Patients p ON a.PatientID = p.PatientID
    WHERE p.Email = @Email AND a.AppointmentDate < @Today
    ORDER BY a.AppointmentDate DESC";

                SqlCommand previousCommand = new SqlCommand(previousQuery, connection);
                previousCommand.Parameters.AddWithValue("@Email", email);
                previousCommand.Parameters.AddWithValue("@Today", DateTime.Today);

                SqlDataAdapter daPrevious = new SqlDataAdapter(previousCommand);
                DataTable previousDt = new DataTable();
                daPrevious.Fill(previousDt);

                if (previousDt.Rows.Count > 0)
                {
                    StringBuilder sbPrevious = new StringBuilder();
                    sbPrevious.AppendLine("<table class='table'>");
                    sbPrevious.AppendLine("<tr><th>Serial Number</th><th>Doctor Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th><th>Invoice</th><th>Review</th></tr>");

                    foreach (DataRow row in previousDt.Rows)
                    {
                        int appointmentId = Convert.ToInt32(row["AppointmentID"]);
                        string patientName = row["PatientName"].ToString();
                        string doctorName = row["DoctorName"].ToString();
                        string hospitalName = row["HospitalName"].ToString();
                        DateTime appointmentDate = (DateTime)row["AppointmentDate"];
                        TimeSpan appointmentTime = (TimeSpan)row["AppointmentTime"];
                        bool hasReviewed = CheckIfReviewed(appointmentId);

                        sbPrevious.AppendLine("<tr>");
                        sbPrevious.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sbPrevious.AppendLine($"<td>{row["DoctorName"]}</td>");
                        sbPrevious.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sbPrevious.AppendLine($"<td>{appointmentDate.ToString("yyyy-MM-dd")}</td>");
                        sbPrevious.AppendLine($"<td>{appointmentTime.ToString(@"hh\:mm")}</td>");

                        sbPrevious.AppendLine($"<td><a href='PatientDashboard.aspx?generateInvoice=true&appointmentId={appointmentId}&appointmentDate={appointmentDate.ToString("yyyy-MM-dd")}&appointmentTime={appointmentTime.ToString(@"hh\:mm")}' target='_blank'>Download Invoice</a></td>");

                        if (hasReviewed)
                        {
                            sbPrevious.AppendLine("<td>Reviewed</td>");
                        }
                        else
                        {
                            sbPrevious.AppendLine($"<td><a href='review.aspx?appointment_id={appointmentId}' class='top-right-link'>Review</a></td>");
                        }

                        sbPrevious.AppendLine("</tr>");
                    }

                    sbPrevious.AppendLine("</table>");
                    ltPreviousAppointmentsData.Text = sbPrevious.ToString();
                }
                else
                {
                    ltPreviousAppointmentsData.Text = "<p>No previous appointments found.</p>";
                }

                connection.Close();
            }

            // Check if an invoice generation is requested
            if (Request.QueryString["generateInvoice"] == "true")
            {
                int appointmentId;
                DateTime appointmentDate;
                TimeSpan appointmentTime;
                if (int.TryParse(Request.QueryString["appointmentId"], out appointmentId) &&
                    DateTime.TryParse(Request.QueryString["appointmentDate"], out appointmentDate) &&
                    TimeSpan.TryParse(Request.QueryString["appointmentTime"], out appointmentTime))
                {
                    GenerateInvoicePdf(appointmentId, appointmentDate, appointmentTime);
                }
            }
        }




        private string GenerateInvoiceId(int patientId, DateTime appointmentDate, TimeSpan appointmentTime)
        {
            // Format the date and time
            string datePart = appointmentDate.ToString("yyyyMMdd");
            string timePart = appointmentTime.ToString("hhmm");

            // Combine parts to create the invoice ID
            return $"{patientId}{datePart}{timePart}";
        }


        private void GenerateInvoicePdf(int appointmentId, DateTime appointmentDate, TimeSpan appointmentTime)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
        SELECT d.FullName AS DoctorName, 
               h.HospitalName, 
               a.AppointmentDate, 
               a.AppointmentTime, 
               dh.Fees,
               p.PatientName,
               p.PatientID
        FROM Appointments a
        JOIN Doctors d ON a.DoctorID = d.DoctorID
        JOIN Hospitals h ON a.HospitalID = h.HospitalID
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN DoctorHospitals dh ON a.DoctorID = dh.DoctorID AND a.HospitalID = dh.HospitalID
        WHERE a.AppointmentID = @AppointmentID";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@AppointmentID", appointmentId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows && reader.Read())
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        Document document = new Document(PageSize.A4, 25, 25, 100, 30); // Adjust the top margin to move text down
                        PdfWriter writer = PdfWriter.GetInstance(document, ms);
                        document.Open();

                        // Add the border image to the top left corner
                        string borderPath = Server.MapPath("~/Images/border.png");
                        if (File.Exists(borderPath))
                        {
                            iTextSharp.text.Image border = iTextSharp.text.Image.GetInstance(borderPath);
                            border.ScaleToFit(document.PageSize.Width * 2, document.PageSize.Height); // Scale to twice the width
                            border.SetAbsolutePosition(0, document.PageSize.Height - border.ScaledHeight);
                            document.Add(border);
                        }

                        // Add the logo image to the top right corner
                        string logoPath = Server.MapPath("~/Images/lolo.jpeg");
                        if (File.Exists(logoPath))
                        {
                            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(logoPath);
                            logo.ScaleToFit(300f, 150f); // Scale to double the size
                            logo.SetAbsolutePosition(document.PageSize.Width - document.RightMargin - 300f, document.PageSize.Height - 150f);
                            document.Add(logo);
                        }

                        document.Add(new Paragraph(" ")); // Add a blank line for spacing
                        document.Add(new Paragraph(" ")); // Add a blank line for spacing
                        document.Add(new Paragraph(" ")); // Add a blank line for spacing

                        // Retrieve patient ID
                        int patientId = reader.GetInt32(reader.GetOrdinal("PatientID"));

                        // Generate unique invoice ID
                        string invoiceId = GenerateInvoiceId(patientId, appointmentDate, appointmentTime);

                        // Add the invoice header
                        Paragraph header = new Paragraph("INVOICE", new Font(Font.FontFamily.HELVETICA, 30, Font.BOLD, BaseColor.BLACK)); // Increased font size
                        header.Alignment = Element.ALIGN_RIGHT; // Center the header
                        document.Add(header);

                        // Add the invoice details
                        PdfPTable infoTable = new PdfPTable(2);
                        infoTable.HorizontalAlignment = Element.ALIGN_RIGHT; // Center the table
                        infoTable.DefaultCell.Border = 0;
                        infoTable.TotalWidth = 200f;
                        infoTable.LockedWidth = true;
                        infoTable.SpacingAfter = 10f; // Reduce spacing after the table

                        PdfPCell cell = new PdfPCell(new Phrase("Invoice No.", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);
                        cell = new PdfPCell(new Phrase(invoiceId, new Font(Font.FontFamily.HELVETICA, 12)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);

                        cell = new PdfPCell(new Phrase("Date", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);
                        cell = new PdfPCell(new Phrase(DateTime.Now.ToString("dd/MM/yyyy"), new Font(Font.FontFamily.HELVETICA, 12)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);

                        cell = new PdfPCell(new Phrase("Due Date", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);
                        cell = new PdfPCell(new Phrase(((DateTime)reader["AppointmentDate"]).ToString("dd/MM/yyyy"), new Font(Font.FontFamily.HELVETICA, 12)));
                        cell.Border = 0;
                        cell.PaddingBottom = 5f; // Reduce padding
                        infoTable.AddCell(cell);

                        document.Add(new Paragraph(" ")); // Add a blank line for spacing

                        document.Add(infoTable);

                        // Add patient and appointment details
                        PdfPTable detailsTable = new PdfPTable(2);
                        detailsTable.HorizontalAlignment = Element.ALIGN_LEFT;
                        detailsTable.DefaultCell.Border = 0;
                        detailsTable.TotalWidth = 300f; // Adjust the width of the table
                        detailsTable.LockedWidth = true;
                        detailsTable.SpacingAfter = 5f; // Decrease spacing after the table
                        detailsTable.SpacingBefore = 5f; // Decrease spacing before the table

                        // Adjust cell padding to reduce space between columns
                        PdfPCell leftCell = new PdfPCell();
                        leftCell.Border = 0;
                        leftCell.PaddingRight = 10f; // Reduce padding between columns

                        PdfPCell rightCell = new PdfPCell();
                        rightCell.Border = 0;
                        rightCell.PaddingLeft = 10f; // Reduce padding between columns

                        leftCell.Phrase = new Phrase("Patient:", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
                        detailsTable.AddCell(leftCell);
                        rightCell.Phrase = new Phrase(reader["PatientName"].ToString(), new Font(Font.FontFamily.HELVETICA, 12));
                        detailsTable.AddCell(rightCell);

                        leftCell.Phrase = new Phrase("Hospital:", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
                        detailsTable.AddCell(leftCell);
                        rightCell.Phrase = new Phrase(reader["HospitalName"].ToString(), new Font(Font.FontFamily.HELVETICA, 12));
                        detailsTable.AddCell(rightCell);

                        leftCell.Phrase = new Phrase("Doctor:", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
                        detailsTable.AddCell(leftCell);
                        rightCell.Phrase = new Phrase(reader["DoctorName"].ToString(), new Font(Font.FontFamily.HELVETICA, 12));
                        detailsTable.AddCell(rightCell);

                        leftCell.Phrase = new Phrase("Appointment Date:", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
                        detailsTable.AddCell(leftCell);
                        rightCell.Phrase = new Phrase(((DateTime)reader["AppointmentDate"]).ToString("dd/MM/yyyy"), new Font(Font.FontFamily.HELVETICA, 12));
                        detailsTable.AddCell(rightCell);

                        leftCell.Phrase = new Phrase("Appointment Time:", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
                        detailsTable.AddCell(leftCell);
                        rightCell.Phrase = new Phrase(((TimeSpan)reader["AppointmentTime"]).ToString(@"hh\:mm"), new Font(Font.FontFamily.HELVETICA, 12));
                        detailsTable.AddCell(rightCell);

                        document.Add(new Paragraph(" ")); // Add a blank line for spacing

                        document.Add(detailsTable);

                        // Add the charges table
                        PdfPTable chargesTable = new PdfPTable(2);
                        chargesTable.HorizontalAlignment = Element.ALIGN_CENTER;
                        chargesTable.SpacingBefore = 10;
                        chargesTable.SpacingAfter = 10;
                        chargesTable.WidthPercentage = 80;
                        float[] widths = new float[] { 2f, 1f };
                        chargesTable.SetWidths(widths);

                        // Add top border to the first row
                        PdfPCell chargesCell = new PdfPCell(new Phrase("Description", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_LEFT;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.PaddingTop = 10f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER;
                        chargesCell.BorderWidthTop = 2f; // Set top border thickness
                        chargesCell.BorderWidthBottom = 2f; // Set bottom border thickness
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase("Amount", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.PaddingTop = 10f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.TOP_BORDER | PdfPCell.BOTTOM_BORDER;
                        chargesCell.BorderWidthTop = 2f; // Set top border thickness
                        chargesCell.BorderWidthBottom = 2f; // Set bottom border thickness
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase("Appointment Charges", new Font(Font.FontFamily.HELVETICA, 12)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_LEFT;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.PaddingTop = 10f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.BOTTOM_BORDER;
                        chargesCell.BorderWidthBottom = 2f; // Set bottom border thickness
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase(reader["Fees"].ToString(), new Font(Font.FontFamily.HELVETICA, 12)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.PaddingTop = 10f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.BOTTOM_BORDER;
                        chargesCell.BorderWidthBottom = 2f; // Set bottom border thickness
                        chargesTable.AddCell(chargesCell);

                        decimal fees = Convert.ToDecimal(reader["Fees"]);
                        decimal tax = fees * 0.05m;
                        decimal total = fees + tax;

                        chargesCell = new PdfPCell(new Phrase("Subtotal", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 20f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.NO_BORDER;
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase(fees.ToString(), new Font(Font.FontFamily.HELVETICA, 12)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 20f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.NO_BORDER;
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase("Tax(5%)", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 10f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.NO_BORDER;
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase(tax.ToString(), new Font(Font.FontFamily.HELVETICA, 12)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 10f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.NO_BORDER;
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase("Total", new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 20f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.TOP_BORDER;
                        chargesCell.BorderWidthTop = 2f; // Set top border thickness
                        chargesTable.AddCell(chargesCell);

                        chargesCell = new PdfPCell(new Phrase(total.ToString(), new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD)));
                        chargesCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                        chargesCell.PaddingTop = 20f;
                        chargesCell.PaddingBottom = 15f; // Increase padding for more spacing
                        chargesCell.Border = PdfPCell.TOP_BORDER;
                        chargesCell.BorderWidthTop = 2f; // Set top border thickness
                        chargesTable.AddCell(chargesCell);

                        document.Add(chargesTable);

                        // Add the footer image
                        string footerPath = Server.MapPath("~/Images/footer.png");
                        if (File.Exists(footerPath))
                        {
                            iTextSharp.text.Image footer = iTextSharp.text.Image.GetInstance(footerPath);
                            footer.ScaleAbsolute(document.PageSize.Width, 800f); // Scale to twice the current height and full width
                            footer.SetAbsolutePosition(0, 0);
                            document.Add(footer);
                        }

                        document.Close();

                        byte[] byteArray = ms.ToArray();
                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("Content-Disposition", $"attachment; filename=invoice({invoiceId}).pdf");
                        Response.OutputStream.Write(byteArray, 0, byteArray.Length);
                        Response.OutputStream.Flush();
                        Response.End();
                    }
                }

                connection.Close();
            }
        }


        private bool CheckIfReviewed(int appointmentId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT COUNT(*)
            FROM DoctorReviews dr
            WHERE dr.AppointmentID = @AppointmentID";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@AppointmentID", appointmentId);

                connection.Open();
                int reviewCount = (int)command.ExecuteScalar();
                connection.Close();

                return reviewCount > 0;
            }
        }





        private void LoadCancelledAppointments()
        {
            string email = Session["PatientEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT ca.AppointmentID, d.FullName AS DoctorName, h.HospitalName, ca.AppointmentDate, ca.AppointmentTime
                    FROM CancelledAppointments ca
                    JOIN Doctors d ON ca.DoctorID = d.DoctorID
                    JOIN Hospitals h ON ca.HospitalID = h.HospitalID
                    JOIN Patients p ON ca.PatientID = p.PatientID
                    WHERE p.Email = @Email AND ca.CancellationDate >= DATEADD(DAY, -1, GETDATE())
                    ORDER BY ca.CancellationDate DESC";

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
                    sb.AppendLine("<tr><th>Serial Number</th><th>Doctor Name</th><th>Hospital Name</th><th>Appointment Date</th><th>Appointment Time</th></tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["AppointmentID"]}</td>");
                        sb.AppendLine($"<td>{row["DoctorName"]}</td>");
                        sb.AppendLine($"<td>{row["HospitalName"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["AppointmentDate"]).ToString("yyyy-MM-dd")}</td>");
                        sb.AppendLine($"<td>{((TimeSpan)row["AppointmentTime"]).ToString(@"hh\:mm")}</td>");
                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltCancelledAppointmentsData.Text = sb.ToString();
                    lblMessage.Text = "Your appointment has been cancelled by the doctor. Please book a new one.";
                }
                else
                {
                    ltCancelledAppointmentsData.Text = "";
                    lblMessage.Text = "";
                }

                connection.Close();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                string email = Session["PatientEmail"].ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

                string fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                string filePath = Server.MapPath("~/uploads/") + fileName;
                fileUpload.SaveAs(filePath);

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO MedicalRecords (PatientID, FileName, FilePath, Description, UploadDate) VALUES ((SELECT PatientID FROM Patients WHERE Email = @Email), @FileName, @FilePath, @Description, @UploadDate)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@FileName", fileName);
                    command.Parameters.AddWithValue("@FilePath", filePath);
                    command.Parameters.AddWithValue("@Description", txtDescription.Text);
                    command.Parameters.AddWithValue("@UploadDate", DateTime.Now);

                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }

                LoadMedicalRecords();
            }
        }

        private void LoadMedicalRecords()
        {
            string email = Session["PatientEmail"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT ROW_NUMBER() OVER (ORDER BY UploadDate DESC) AS SerialNumber, FileName, FilePath, Description, UploadDate, RecordID
            FROM MedicalRecords
            WHERE PatientID = (SELECT PatientID FROM Patients WHERE Email = @Email)
            ORDER BY UploadDate DESC";

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
                    sb.AppendLine("<tr><th>Serial Number</th><th>File Name</th><th>Description</th><th>Upload Date</th><th>View</th><th>Delete</th></tr>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sb.AppendLine("<tr>");
                        sb.AppendLine($"<td>{row["SerialNumber"]}</td>");
                        sb.AppendLine($"<td>{row["FileName"]}</td>");
                        sb.AppendLine($"<td>{row["Description"]}</td>");
                        sb.AppendLine($"<td>{((DateTime)row["UploadDate"]).ToString("yyyy-MM-dd HH:mm:ss")}</td>");
                        sb.AppendLine($"<td><a href='/uploads/{row["FileName"]}' target='_blank'>View</a></td>");
                        sb.AppendLine($"<td><a href='PatientDashboard.aspx?deleteRecord=true&recordId={row["RecordID"]}'>Delete</a></td>");
                        sb.AppendLine("</tr>");
                    }

                    sb.AppendLine("</table>");
                    ltMedicalRecords.Text = sb.ToString();
                }
                else
                {
                    ltMedicalRecords.Text = "<p>No medical records found.</p>";
                }

                connection.Close();
            }
        }


        private void DeleteMedicalRecord(int recordId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM MedicalRecords WHERE RecordID = @RecordID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@RecordID", recordId);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }

            // Reload the medical records to reflect the deletion
            LoadMedicalRecords();
        }



        private void LoadHealthMetrics()
        {
            int patientId = GetPatientId();

            var glucoseData = GetHealthMetricsChartData(patientId, "blood_glucose");
            var glucoseJson = new JavaScriptSerializer().Serialize(glucoseData);
            ClientScript.RegisterStartupScript(this.GetType(), "renderGlucoseChart", $"renderChart('glucoseChart', {glucoseJson});", true);

            var pressureData = GetHealthMetricsChartData(patientId, "blood_pressure");
            var pressureJson = new JavaScriptSerializer().Serialize(pressureData);
            ClientScript.RegisterStartupScript(this.GetType(), "renderPressureChart", $"renderChart('pressureChart', {pressureJson});", true);

            var cholesterolData = GetHealthMetricsChartData(patientId, "cholesterol");
            var cholesterolJson = new JavaScriptSerializer().Serialize(cholesterolData);
            ClientScript.RegisterStartupScript(this.GetType(), "renderCholesterolChart", $"renderChart('cholesterolChart', {cholesterolJson});", true);
        }

        private object GetHealthMetricsChartData(int patientId, string metricType)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mysqlcon"].ConnectionString;

            var chartData = new
            {
                labels = new List<string>(),
                datasets = new List<object>()
            };

            var dataset = new
            {
                label = metricType.Replace('_', ' '),
                data = new List<float>(),
                borderColor = "rgba(75, 192, 192, 1)",
                borderWidth = 1
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT MetricValue, LogDate FROM HealthMetrics WHERE PatientID = @PatientID AND MetricType = @MetricType ORDER BY LogDate";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PatientID", patientId);
                    command.Parameters.AddWithValue("@MetricType", metricType);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            float metricValue = Convert.ToSingle(reader["MetricValue"]);
                            string logDate = reader.GetDateTime(1).ToString("yyyy-MM-dd HH:mm:ss");

                            if (!chartData.labels.Contains(logDate))
                            {
                                chartData.labels.Add(logDate);
                            }

                            dataset.data.Add(metricValue);
                        }
                    }
                }
            }

            chartData.datasets.Add(dataset);
            return chartData;
        }

        private int GetPatientId()
        {
            return 1; // Replace with actual logic to get the logged-in patient's ID
        }
    }
}
