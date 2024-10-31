<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InfectiousDisease.aspx.cs" Inherits="HealthHub.InfectiousDisease" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Infectious Disease Specialist List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(45%, 1fr));
            gap: 20px;
            padding: 2rem;
        }

        .header {
            font-family: Arial, sans-serif; /* Example font */
            font-size: 28px; /* Example font-size */
            color: white; /* Example text color */
            margin-bottom: 20px; /* Spacing below the header */
            padding: 10px;
            margin: 10px;
            font-weight: bold;
        }

        .header-link {
            text-decoration: none;
            font-weight: bold; /* Make it bold */
            transition: color 0.3s ease; /* Smooth transition for color change */
            color: black;
        }

            .header-link:hover {
                color: #004e70; /* Darker shade on hover for emphasis */
                text-decoration: underline; /* Underline on hover for emphasis */
            }

        .card {
            display: grid;
            grid-template-columns: auto 1fr auto; /* Divide the card into three sections */
            gap: 1rem; /* Gap between image, content, and button */
            /* align-items: center; */
            background-color: white;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border-radius: 18px;
        }

            .card img {
                max-width: 200px; /* Ensure the image fills its container */
                height: 150px; /* Allow the height to adjust accordingly */
                object-fit: cover; /* Cover the area without stretching */
                border-radius: 18px;
            }

        .card-info h3 {
            margin: 0;
            color: #333;
        }

        .card-info p {
            margin: 4px 0;
            color: #777;
        }



        .hospital-info {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            gap: 10px; /* Ensures space between the boxes */
        }

        .hospital-name {
            font-weight: bold; /* Make hospital name bold */
            margin-bottom: 5px; /* Spacing between name and fee */
        }

        .fee {
            color: #333; /* Darker text for the fee */
        }

        .hospital-box {
            background-color: #fff;
            border: 2px solid #001b40;
            padding: 10px;
            border-radius: 18px;
            width: calc(50% - 5px); /* Adjust for the gap between boxes */
            text-align: center;
            font-size: 0.9em; /* Slightly smaller font size */
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
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4); /* Adjusted shadow properties */
        }

            .btn-book:hover {
                background-color: #001b40;
            }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr; /* Stack cards on smaller screens */
            }
        }

        .star-rating .star {
            color: #f1c40f; /* Gold color */
            font-size: 20px; /* Larger star size */
        }

        .filter-section {
            padding: 10px;
            border-radius: 16px;
            margin-bottom: 10px;
            justify-content: space-around;
            align-items: center;
            margin-top: 30px;
            margin-left: 20px;
        }

            .filter-section input,
            .filter-section select {
                padding: 10px;
                font-size: 16px;
                border-radius: 16px;
                margin-right: 10px;
            }

        #btnFilter {
            background-color: #3bb9ec;
            border-radius: 16px;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            padding: 10px
        }

            #btnFilter:hover {
                background-color: #001b40;
            }

        /* Additional styling for responsiveness */
        @media (max-width: 768px) {
            .filter-section {
                flex-direction: column;
                align-items: flex-start;
            }

                .filter-section input,
                .filter-section select,
                .filter-section button {
                    margin-bottom: 10px;
                    width: 100%;
                }
        }

        .btn-find-near-me, .btn-primary, #btnFilter {
            background-color: #3bb9ec;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            padding: 10px 20px;
            text-align: center;
            display: inline-block;
            transition: background-color 0.3s ease;
            margin-left: 10px;
        }

            .btn-find-near-me:hover, .btn-primary:hover, #btnFilter:hover {
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
            </ul>
        </nav>
    </header>

    <form id="form1" runat="server">
        <div class="filter-section">
            <asp:TextBox ID="txtMinExperience" runat="server" Placeholder="Min Experience"></asp:TextBox>
            <asp:TextBox ID="txtMinRating" runat="server" Placeholder="Min Rating"></asp:TextBox>
            <asp:DropDownList ID="ddlCity" runat="server"></asp:DropDownList>
            <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" OnClick="btnFilter_Click" />
            <asp:Button ID="btnFindNearby" runat="server" Text="Find Infectious Disease Specialists Near Me" CssClass="btn-find-near-me" OnClick="btnFindNearby_Click" />
        </div>
        <div id="doctorList" runat="server"></div>
        <div class="container" runat="server">
            <asp:Repeater ID="rptInfectiousDisease" runat="server" OnItemDataBound="rptInfectiousDisease_ItemDataBound">
                <ItemTemplate>
                    <div class="card">
                        <asp:Image ID="imgDoctor" runat="server" ImageUrl="pics/F-doc.jpg" />
                        <div class="card-info">
                            <h3>
                                <asp:HyperLink ID="lnkDoctorName" runat="server"></asp:HyperLink>
                            </h3>
                            <p>
                                <asp:Literal ID="litSpecialization" runat="server"></asp:Literal>
                            </p>
                            <p>
                                Experience:
                                <asp:Literal ID="litYearsOfExperience" runat="server"></asp:Literal>
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
                                            <p class="city">City: <%# Eval("City") %></p>
                                            <p class="fee">Fee: <%# Eval("Fees") %></p>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <asp:HyperLink ID="lnkBookAppointment" runat="server" CssClass="btn-book">Book Appointment</asp:HyperLink>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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
</html>
