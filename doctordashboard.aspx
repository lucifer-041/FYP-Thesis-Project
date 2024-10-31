<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoctorDashboard.aspx.cs" Inherits="Healthhub.DoctorDashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <style>
        body {
            background-image: linear-gradient(to right, #004e70, #001b40);
        }

        header {
            background-color: white;
            color: black;
            padding: 10px 0;
            height: 60px; /* Set a fixed height for the header */
            box-sizing: border-box; /* Ensure padding and border are included in the element's total width and height */
        }

        nav {
            display: flex;
            justify-content: space-around;
            align-items: center;
            font-weight: bold;
            height: 100%; /* Ensure nav takes the full height of the header */
        }


        .logo img {
            height: 45px; /* Set a fixed height for the logo */
            width: auto; /* Ensure the logo maintains its aspect ratio */
        }

        .nav-links {
            list-style: none;
        }

            .nav-links li {
                display: inline;
                margin-left: 20px;
            }

            .nav-links a {
                color: #3bb9ec;
                text-decoration: none;
                font-size: 18px;
            }

                .nav-links a:hover {
                    color: #001b40;
                }

        .dropdown {
            position: relative;
            display: block;
        }

        .dropbtn {
            color: white;
            padding: 16px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            text-align: left;
            width: 100%;
            box-sizing: border-box;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 250px;
            overflow-y: auto;
            max-height: 300px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

                .dropdown-content a:hover {
                    background-color: #ddd;
                }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown-heading {
            margin-top: 15px;
            padding: 16px;
            color: black;
            font-size: 16px;
        }

        .dropdown-content::-webkit-scrollbar {
            width: 10px;
        }

        .dropdown-content::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .dropdown-content::-webkit-scrollbar-thumb {
            border-radius: 10px;
            border: 3px solid #f1f1f1;
        }

        .dropdown-content {
            scrollbar-width: thick;
            scrollbar-color: #888 #f1f1f1;
        }

        .dropdown-content {
            -ms-overflow-style: -ms-autohiding-scrollbar;
        }

        /* Footer styles */
        footer {
            background-color: #ffffff;
            color: #001b40;
            padding: 40px 0;
            font-size: 14px;
        }

        .footer-container {
            width: 100%;
            max-width: 1500px; /* Adjust to make it wider */
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            padding: 0 20px; /* Add padding for equal margins */
            gap: 100px; /* Double the gap between sections */
        }

        .footer-column {
            margin-bottom: 20px;
        }

        .company-column {
            width: 30%;
        }

        .company-links-column {
            width: 15%;
        }

        .specializations-column {
            width: 60%; /* Increase width for specializations */
        }

        .contacts-column {
            width: 20%;
        }

        .footer-column h3 {
            margin-bottom: 15px;
            font-size: 16px;
        }

        .footer-column ul {
            list-style: none;
            padding: 0;
        }

            .footer-column ul li {
                margin-bottom: 10px;
            }

                .footer-column ul li a {
                    color: #161515;
                    text-decoration: none;
                    line-height: 1.8;
                    transition: color 0.3s; /* Add transition for hover effect */
                }

                    .footer-column ul li a:hover {
                        color: #007bff; /* Change color on hover */
                    }

        .footer-column p {
            color: #161515;
            line-height: 2;
        }

        .footer-specializations {
            display: flex;
            justify-content: space-between;
        }

            .footer-specializations ul {
                flex: 1;
                margin: 0 10px;
            }

        .footer-socials {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

            .footer-socials a {
                color: #ffffff;
                font-size: 20px;
                margin-right: 10px;
                width: 40px;
                height: 40px;
                background-color: #001b40;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                text-decoration: none;
                transition: background-color 0.3s; /* Add transition for hover effect */
            }

                .footer-socials a:hover {
                    background-color: #007bff; /* Change background color on hover */
                }

        .footer-logo {
            width: 150px;
            margin-bottom: 15px;
        }

        .footer-benefits {
            display: flex;
            justify-content: space-between;
            padding: 20px 50px;
            background-color: #f0f0f0;
            text-align: center;
            margin-top: 30px; /* Increase margin between sections */
        }

        .benefit-item {
            flex: 1;
            margin: 0 20px;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

            .benefit-item i {
                font-size: 40px;
                margin-bottom: 10px;
                display: block;
            }

        .footer-rights {
            padding: 20px 50px;
            background-color: #f0f0f0;
            text-align: center;
            margin-top: 10px;
        }

            .footer-rights p {
                margin: 0;
            }

        .contacts-column p i {
            margin-right: 10px;
        }

        .contacts-column p {
            display: flex;
            align-items: center;
            line-height: 1.5;
        }

        @media screen and (max-width: 600px) {
            .footer-container {
                flex-direction: column;
                text-align: center;
            }

            .footer-column,
            .footer-socials {
                margin-bottom: 20px;
            }

            .footer-specializations {
                flex-direction: column;
            }

            .footer-benefits {
                flex-direction: column;
                padding: 20px;
            }

            .benefit-item {
                margin-bottom: 20px;
            }
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            padding: 0 20px;
            align-items: start;
        }

            .container > div {
                background-color: white;
                color: black;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                position: relative;
                height: auto;
            }

        .overview, .upcoming-appointments, .confirmed-appointments, .previous-appointments {
            height: auto;
            text-align: center;
        }

        .contact-card, .upcoming-appointments, .confirmed-appointments, .previous-appointments {
            min-height: 500px;
            height: 500px;
        }

        .contact-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .patient-records {
            grid-column: span 2;
            margin-bottom: 20px;
        }

        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
            text-align: left;
        }

        .top-right-link {
            background-color: #3bb9ec;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
        }

            .top-right-link:hover {
                background-color: #001b40;
            }

        .section-heading {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .section-content {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .contact-details {
            text-align: left;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

            .contact-details p {
                display: flex;
                align-items: center;
            }

            .contact-details i {
                margin-right: 10px;
            }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            color: white;
            cursor: pointer;
        }

        .btn-confirm {
            background-color: #28a745;
        }

            .btn-confirm:hover {
                background-color: #218838;
            }

        .btn-reject {
            background-color: #dc3545;
        }

            .btn-reject:hover {
                background-color: #c82333;
            }
    </style>
</head>
<body class="text-white font-sans">
    <header>
        <nav>
            <a href="Home.aspx" class="logo">
                <img src="pics/logo.jpeg" alt="HealthHub Connect"></a>
            <ul class="nav-links">
                <li><a href="Home.aspx">Home</a></li>
                <li class="dropdown">
                    <a href="javascript:void(0)" class="dropbtn">Doctors</a>
                    <div class="dropdown-content">
                        <div class="dropdown-heading"><b>Find Doctors By Specialty</b></div>
                        <a href="Allergist.aspx">Allergist/Immunologist</a>
                        <a href="Anesthesiologist.aspx">Anesthesiologist</a>
                        <a href="Cardiologist.aspx">Cardiologist</a>
                        <a href="Dentist.aspx">Dentist</a>
                        <a href="Dermatologist.aspx">Dermatologist</a>
                        <a href="EmergencyMedicine.aspx">Emergency Medicine Specialist</a>
                        <a href="Endocrinologist.aspx">Endocrinologist</a>
                        <a href="FamilyMedicine.aspx">Family Medicine Physician</a>
                        <a href="Gastroenterologist.aspx">Gastroenterologist</a>
                        <a href="GeneralPhysician.aspx">General Physician</a>
                        <a href="Geriatrician.aspx">Geriatrician</a>
                        <a href="Hematologist.aspx">Hematologist</a>
                        <a href="Hepatologist.aspx">Hepatologist</a>
                        <a href="InfectiousDisease.aspx">Infectious Disease Specialist</a>
                        <a href="Internist.aspx">Internist</a>
                        <a href="Nephrologist.aspx">Nephrologist</a>
                        <a href="Neurologist.aspx">Neurologist</a>
                        <a href="ObstetricianGynecologist.aspx">Obstetrician and Gynecologist (OB-GYN)</a>
                        <a href="Oncologist.aspx">Oncologist</a>
                        <a href="Ophthalmologist.aspx">Ophthalmologist</a>
                        <a href="Orthopedist.aspx">Orthopedist/Orthopedic Surgeon</a>
                        <a href="Otolaryngologist.aspx">Otolaryngologist (ENT specialist)</a>
                        <a href="Pathologist.aspx">Pathologist</a>
                        <a href="Pediatrician.aspx">Pediatrician</a>
                        <a href="Psychiatrist.aspx">Psychiatrist</a>
                        <a href="Pulmonologist.aspx">Pulmonologist</a>
                        <a href="Radiologist.aspx">Radiologist</a>
                        <a href="Rheumatologist.aspx">Rheumatologist</a>
                        <a href="SleepMed.aspx">Sleep Medicine Specialist</a>
                        <a href="SportsMed.aspx">Sports Medicine Specialist</a>
                        <a href="Urologist.aspx">Urologist</a>
                    </div>
                </li>
                <li><a href="doctordashboard.aspx">Dashboard</a></li>
                <li><a href="doctorlogin.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>

    <form id="form1" runat="server">
        <div class="p-4">
            <h1 class="text-2xl font-bold">Good Day, Dr.
                <asp:Label ID="lblDoctorName" runat="server" /></h1>
            <p>Have a Nice Day!</p>
        </div>

        <div class="container">
            <!-- My Profile and My Availabilities side by side -->
            <div class="contact-card">
                <div class="section-content">
                    <div>
                        <div class="section-heading">My Profile</div>
                        <center>
                            <asp:Image ID="imgProfile" runat="server" CssClass="w-32 h-32 rounded-full mx-auto mb-4" /></center>
                        <h1 class="text-xl font-semibold text-center">Dr.
                            <asp:Label ID="lblDoctorNameHeader" runat="server" /></h1>
                        <div class="contact-details">
                            <p>
                                <i class="material-icons align-middle">email</i> <span class="value align-middle">
                                    <asp:Label ID="lblEmail" runat="server" /></span>
                            </p>
                            <p>
                                <i class="material-icons align-middle">business_center</i> <span class="value align-middle">
                                    <asp:Label ID="lblSpecialization" runat="server" /></span>
                            </p>
                            <p>
                                <i class="material-icons align-middle">work</i> <span class="value align-middle">Years of Experience:
                                <asp:Label ID="lblExperience" runat="server" /></span>
                            </p>
                        </div>
                    </div>
                    <div class="button-container">
                        <a href="editdoctorprofile.aspx" class="top-right-link">Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="upcoming-appointments">
                <div class="section-content">
                    <div>
                        <div class="section-heading">Hospital Data</div>
                        <div class="table-container">
                            <asp:Literal ID="ltAvailabilityData" runat="server" />
                        </div>
                    </div>
                    <div class="button-container">
                        <a href="doctoravailability.aspx" class="top-right-link">My Availabilities</a>
                    </div>


                </div>
            </div>

            <!-- Upcoming and Previous Appointments side by side -->
            <div class="confirmed-appointments">
                <div class="section-content">
                    <div>
                        <div class="section-heading">Upcoming Appointments</div>
                        <div class="table-container">
                            <asp:Literal ID="ltConfirmedAppointments" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="previous-appointments">
                <div class="section-content">
                    <div>
                        <div class="section-heading">Previous Appointments</div>
                        <div class="table-container">
                            <asp:Literal ID="ltPreviousAppointments" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- My Appointments -->
            <div class="patient-records">
                <div class="section-content">
                    <div class="section-heading">My Appointments</div>
                    <div class="table-container">
                        <asp:Literal ID="ltAppointmentData" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfStatusMessage" runat="server" />
    </form>

    <footer>
        <div class="footer-container">
            <div class="footer-column company-column">
                <img src="pics/logo.jpeg" alt="HealthHub Connect Logo" class="footer-logo">
                <p>HealthHub Connect is a healthcare management platform that streamlines connections between patients and providers. Features include appointment scheduling, medicine tracking, medical history management, and location-based hospital recommendations. Experience efficient, personalized healthcare with HealthHub Connect.</p>
            </div>
            <div class="footer-column company-links-column">
                <h3>COMPANY</h3>
                <ul>
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="doctorsignup.aspx">Join as Doctor</a></li>
                    <li><a href="patientsignup.aspx">Join as Patient</a></li>
                    <li><a href="PrivacyPolicy.aspx">Privacy Policy</a></li>
                    <li><a href="ComplaintForm.aspx">Complaints</a></li>
                </ul>
            </div>
            <div class="footer-column specializations-column">
                <h3 style="text-align: center;">SPECIALIZATIONS</h3>
                <div class="footer-specializations">
                    <ul>
                        <li><a href="Allergist.aspx">Allergist/Immunologist</a></li>
                        <li><a href="Anesthesiologist.aspx">Anesthesiologist</a></li>
                        <li><a href="Cardiologist.aspx">Cardiologist</a></li>
                        <li><a href="Dentist.aspx">Dentist</a></li>
                        <li><a href="Dermatologist.aspx">Dermatologist</a></li>
                        <li><a href="EmergencyMedicine.aspx">Emergency Medicine Specialist</a></li>
                        <li><a href="Endocrinologist.aspx">Endocrinologist</a></li>
                        <li><a href="FamilyMedicine.aspx">Family Medicine Physician</a></li>
                        <li><a href="Gastroenterologist.aspx">Gastroenterologist</a></li>
                        <li><a href="GeneralPhysician.aspx">General Physician</a></li>
                        <li><a href="Geriatrician.aspx">Geriatrician</a></li>

                    </ul>
                    <ul>
                        <li><a href="Hematologist.aspx">Hematologist</a></li>
                        <li><a href="Hepatologist.aspx">Hepatologist</a></li>
                        <li><a href="InfectiousDisease.aspx">Infectious Disease Specialist</a></li>
                        <li><a href="Internist.aspx">Internist</a></li>
                        <li><a href="Nephrologist.aspx">Nephrologist</a></li>
                        <li><a href="Neurologist.aspx">Neurologist</a></li>
                        <li><a href="ObstetricianGynecologist.aspx">Obstetrician and Gynecologist (OB-GYN)</a></li>
                        <li><a href="Oncologist.aspx">Oncologist</a></li>
                        <li><a href="Ophthalmologist.aspx">Ophthalmologist</a></li>
                        <li><a href="Orthopedist.aspx">Orthopedist/Orthopedic Surgeon</a></li>
                    </ul>
                    <ul>
                        <li><a href="Otolaryngologist.aspx">Otolaryngologist (ENT specialist)</a></li>
                        <li><a href="Pathologist.aspx">Pathologist</a></li>
                        <li><a href="Pediatrician.aspx">Pediatrician</a></li>
                        <li><a href="Psychiatrist.aspx">Psychiatrist</a></li>
                        <li><a href="Pulmonologist.aspx">Pulmonologist</a></li>
                        <li><a href="Radiologist.aspx">Radiologist</a></li>
                        <li><a href="Rheumatologist.aspx">Rheumatologist</a></li>
                        <li><a href="SleepMed.aspx">Sleep Medicine Specialist</a></li>
                        <li><a href="SportsMed.aspx">Sports Medicine Specialist</a></li>
                        <li><a href="Urologist.aspx">Urologist</a></li>

                    </ul>
                </div>
            </div>
            <div class="footer-column contacts-column">
                <h3>CONTACTS</h3>
                <p><i class="fas fa-envelope"></i>connecthealthhub@outlook.com</p>

                <div class="footer-socials">
                    <a href="https://www.facebook.com/sample"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.instagram.com/sample"><i class="fab fa-instagram"></i></a>

                </div>
            </div>
        </div>
        <div class="footer-benefits">
            <div class="benefit-item">
                <i class="fas fa-user-md"></i>
                <p>
                    <strong>Trusted Healthcare Providers</strong><br>
                    Verified & experienced doctors
                </p>
            </div>
            <div class="benefit-item">
                <i class="fas fa-thumbs-up"></i>
                <p>
                    <strong>Personalized Recommendations</strong><br>
                    Find the best-suited doctors
                </p>
            </div>
            <div class="benefit-item">
                <i class="fas fa-pills"></i>
                <p>
                    <strong>Medication Reminders</strong><br>
                    Never miss a dose again
                </p>
            </div>
        </div>
        <div class="footer-rights">
            <p>© HealthHub Connect. All rights reserved</p>
        </div>
    </footer>

    <script>
        window.onload = function () {
            var statusMessage = document.getElementById('<%= hfStatusMessage.ClientID %>').value;
            if (statusMessage) {
                alert(statusMessage);
            }
        }
    </script>
</body>
</html>
