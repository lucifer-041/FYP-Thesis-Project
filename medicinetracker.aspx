<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MedicineTracker.aspx.cs" Inherits="HealthHub.MedicineTracker" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medicine Tracker</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
    <style>
        body, html {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #004e70, #001b40);
            color: #fff;
            overflow-x: hidden;
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
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(0, 30, 60, 0.8); /* Adjusted background color for better contrast */
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        h1 {
            color: #fff;
            text-align: center;
            margin-bottom: 10px;
            font-size: 36px;
        }

        p {
            color: #ddd;
            text-align: center;
            font-size: 18px;
        }

        .form-control {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-sizing: border-box;
            background: rgba(255, 255, 255, 0.8);
            color: #000;
        }

            .form-control[readonly] {
                background: rgba(255, 255, 255, 0.5);
            }

        button {
            background-color: #3bb9ec;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
            font-size: 18px;
            font-weight: bold;
            padding: 15px 20px;
            margin-top: 20px;
            display: block;
            width: 100%;
        }

            button:hover {
                background-color: #1c87c9;
            }

        #SubmitButton, #UpdateButton{
            background-color: #3bb9ec;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
            font-size: 18px;
            font-weight: bold;
            padding: 15px 20px;
            margin-top: 20px;
            display: block;
            width: 100%;
        }

         #SubmitButton:hover, #UpdateButton:hover {
     background-color: #1c87c9;
 }


        .input-field {
            margin-bottom: 20px;
        }

            .input-field label {
                display: block;
                color: #fff;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .input-field div {
                display: flex;
                justify-content: space-around;
            }

                .input-field div .form-check {
                    display: flex;
                    align-items: center;
                }

        .form-check label {
            color: #fff;
            margin-left: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            color: #000;
            margin-top: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
        }

        table, th, td {
            border: 1px solid #001b40;
        }

        th, td {
            text-align: center;
            padding: 10px;
            font-weight: normal;
        }

        th {
            background-color: #004e70;
            color: white;
            font-weight: bold;
        }

        .IsTakenCheckBox {
            display: block;
            margin: auto;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h1 {
                font-size: 28px;
            }

            button {
                padding: 10px;
                font-size: 16px;
            }
        }
    </style>
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
                <li><a href="patientdashboard.aspx">Dashboard</a></li>
                <li><a href="patientlogin.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container">
            <h1>Medicine Tracker</h1>
            <p>Your health is our priority</p>
            <asp:TextBox ID="PatientName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox><br />
            <asp:TextBox ID="Email" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox><br />
            <asp:TextBox ID="MedicineName" runat="server" placeholder="Medicine name" CssClass="form-control"></asp:TextBox><br />
            <asp:TextBox ID="DosagesPerDay" runat="server" placeholder="Dosages per day" CssClass="form-control" TextMode="Number"></asp:TextBox><br />
            <div class="input-field">
                <asp:Label ID="Label9" runat="server" Text="Dose Times"></asp:Label>
                <div>
                    <div class="form-check">
                        <asp:CheckBox ID="chkMorning" runat="server" />
                        <label for="chkMorning">Morning</label>
                    </div>
                    <div class="form-check">
                        <asp:CheckBox ID="chkEvening" runat="server" />
                        <label for="chkEvening">Evening</label>
                    </div>
                    <div class="form-check">
                        <asp:CheckBox ID="chkNight" runat="server" />
                        <label for="chkNight">Night</label>
                    </div>
                </div>
            </div>
            <asp:TextBox ID="StartDate" runat="server" placeholder="Start Date" CssClass="form-control" TextMode="Date"></asp:TextBox><br />
            <asp:TextBox ID="EndDate" runat="server" placeholder="End Date" CssClass="form-control" TextMode="Date"></asp:TextBox><br />
            <asp:Button ID="SubmitButton" runat="server" Text="Add Medicine Schedule" OnClick="SubmitButton_Click" CssClass="btn btn-primary" />
            <h2>Track Your Medicine</h2>
            <asp:PlaceHolder ID="MedicineSchedulePlaceholder" runat="server"></asp:PlaceHolder>
            <asp:Button ID="UpdateButton" runat="server" Text="Update Status" OnClick="UpdateButton_Click" CssClass="btn btn-secondary" />
        </div>
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
</body>
<script type="text/javascript">
    function deleteMedicine(medicineId) {
        __doPostBack('DeleteMedicine', medicineId);
    }
</script>
</html>
