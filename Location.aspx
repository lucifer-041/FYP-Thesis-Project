<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Location.aspx.cs" Inherits="HealthHub.Location" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Find Nearby Doctors</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #004e70, #001b40);
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

        .main-container {
            margin: 20px auto 0 auto; /* Center align the container and adjust for the fixed header */
            padding: 20px;
            text-align: center;
            max-width: 1200px; /* Set a maximum width */
        }

        .heading {
            font-size: 32px;
            color: white;
            margin-top: 20px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .textbox, .dropdown {
            padding: 10px;
            margin: 10px 5px; /* Add some margin for spacing */
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            width: 100%;
            max-width: 300px; /* Set maximum width */
            font-size: 16px;
            display: inline-block; /* Ensure elements are inline */
        }

        .btn-primary {
            padding: 10px 20px;
            background-color: #3bb9ec;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            text-align: center;
            display: inline-block; /* Ensure button is inline */
        }

            .btn-primary:hover {
                background-color: #4DA8DA;
            }

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(45%, 1fr));
            gap: 20px;
            padding: 2rem;
        }

        .card {
            display: grid;
            grid-template-columns: auto 1fr auto;
            gap: 1rem;
            background-color: white;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border-radius: 18px;
        }

            .card img {
                max-width: 200px;
                height: 150px;
                object-fit: cover;
                border-radius: 18px;
            }

        .card-info {
            flex-grow: 1;
            padding: 0 1rem;
            text-align: left;
        }

            .card-info h3 {
                margin: 0;
                color: #333;
            }

            .card-info p {
                margin: 4px 0;
                color: #777;
            }

        .star-rating .star {
            color: #f1c40f;
            font-size: 20px;
        }

        .hospital-info {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            gap: 10px;
        }

        .hospital-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .fee {
            color: #333;
        }

        .hospital-box {
            background-color: #fff;
            border: 2px solid #001b40;
            padding: 10px;
            border-radius: 18px;
            width: calc(50% - 5px);
            text-align: center;
            font-size: 0.9em;
            color: black;
        }

        .btn-book {
            background-color: #3bb9ec;
            color: white;
            padding: 10px 20px;
            text-decoration: bold;
            border-radius: 12px;
            cursor: pointer;
            margin-left: auto;
            float: right;
            align-items: center;
            height: 20px;
            width: 130px;
            margin-top: 50px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
        }

            .btn-book:hover {
                background-color: #001b40;
            }
    </style>
</head>
<body>
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

    <div class="main-container">
        <h1 class="heading">Find Doctors Near You</h1>
        <form id="form1" runat="server">
            <div>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="textbox" placeholder="Enter your location (address or area)"></asp:TextBox>
                <asp:DropDownList ID="ddlSpecialization" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="Select Specialization" Value="" />
                    <asp:ListItem Text="Allergist/Immunologist" Value="Allergist/Immunologist" />
                    <asp:ListItem Text="Anesthesiologist" Value="Anesthesiologist" />
                    <asp:ListItem Text="Cardiologist" Value="Cardiologist" />
                    <asp:ListItem Text="Dentist" Value="Dentist" />
                    <asp:ListItem Text="Dermatologist" Value="Dermatologist" />
                    <asp:ListItem Text="Emergency Medicine Specialist" Value="Emergency Medicine Specialist" />
                    <asp:ListItem Text="Endocrinologist" Value="Endocrinologist" />
                    <asp:ListItem Text="Family Medicine Physician" Value="Family Medicine Physician" />
                    <asp:ListItem Text="Gastroenterologist" Value="Gastroenterologist" />
                    <asp:ListItem Text="General Physician" Value="General Physician" />
                    <asp:ListItem Text="Geriatrician" Value="Geriatrician" />
                    <asp:ListItem Text="Hematologist" Value="Hematologist" />
                    <asp:ListItem Text="Hepatologist" Value="Hepatologist" />
                    <asp:ListItem Text="Infectious Disease Specialist" Value="Infectious Disease Specialist" />
                    <asp:ListItem Text="Internist" Value="Internist" />
                    <asp:ListItem Text="Nephrologist" Value="Nephrologist" />
                    <asp:ListItem Text="Neurologist" Value="Neurologist" />
                    <asp:ListItem Text="Obstetrician and Gynecologist (OB-GYN)" Value="Obstetrician and Gynecologist (OB-GYN)" />
                    <asp:ListItem Text="Oncologist" Value="Oncologist" />
                    <asp:ListItem Text="Ophthalmologist" Value="Ophthalmologist" />
                    <asp:ListItem Text="Orthopedist/Orthopedic Surgeon" Value="Orthopedist/Orthopedic Surgeon" />
                    <asp:ListItem Text="Otolaryngologist (ENT specialist)" Value="Otolaryngologist (ENT specialist)" />
                    <asp:ListItem Text="Pathologist" Value="Pathologist" />
                    <asp:ListItem Text="Pediatrician" Value="Pediatrician" />
                    <asp:ListItem Text="Psychiatrist" Value="Psychiatrist" />
                    <asp:ListItem Text="Pulmonologist" Value="Pulmonologist" />
                    <asp:ListItem Text="Radiologist" Value="Radiologist" />
                    <asp:ListItem Text="Rheumatologist" Value="Rheumatologist" />
                    <asp:ListItem Text="Sleep Medicine Specialist" Value="Sleep Medicine Specialist" />
                    <asp:ListItem Text="Sports Medicine Specialist" Value="Sports Medicine Specialist" />
                    <asp:ListItem Text="Urologist" Value="Urologist" />
                </asp:DropDownList>
                <asp:Button ID="btnFindDoctors" runat="server" Text="Find Doctors" CssClass="btn-primary" OnClick="btnFindDoctors_Click" />
            </div>
            <div class="container">
                <asp:Repeater ID="rptDoctors" runat="server" OnItemDataBound="rptDoctors_ItemDataBound">
                    <ItemTemplate>
                        <div class="card">
                            <asp:Image ID="imgDoctor" runat="server" ImageUrl='<%# ResolveUrl("~/images/") + Eval("ProfileImage") %>' />
                            <div class="card-info">
                                <h3>
                                    <asp:HyperLink ID="lnkDoctorName" runat="server" NavigateUrl='<%# "DoctorProfile.aspx?DoctorID=" + Eval("DoctorID") %>' Text='<%# Eval("DoctorName") %>'></asp:HyperLink>
                                </h3>
                                <p>
                                    <asp:Literal ID="litSpecialization" runat="server" Text='<%# Eval("Specialization") %>'></asp:Literal>
                                </p>
                                <p>
                                    Experience:
                                    <asp:Literal ID="litYearsOfExperience" runat="server" Text='<%# Eval("Experience") %>'></asp:Literal>
                                    Years
                                </p>
                                <p class="star-rating">
                                    <asp:Literal ID="litAverageRating" runat="server"></asp:Literal>
                                </p>
                                <div class="hospital-info">
                                    <asp:Repeater ID="rptHospitals" runat="server">
                                        <ItemTemplate>
                                            <div class="hospital-box">
                                                <p class="hospital-name"><%# Eval("HospitalName") %></p>
                                                <p class="city">Location: <%# Eval("City") %></p>
                                                <p class="fee">Fee: <%# Eval("Fees") %></p>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <asp:HyperLink ID="lnkBookAppointment" runat="server" CssClass="btn-book" NavigateUrl='<%# "BookAppointment.aspx?AvailabilityID=" + Eval("AvailabilityID") %>'>Book Appointment</asp:HyperLink>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </form>
    </div>
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
                <h3>CONTACT US</h3>
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
</html>
