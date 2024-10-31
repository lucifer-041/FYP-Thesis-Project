<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrivacyPolicy.aspx.cs" Inherits="HealthHub.PrivacyPolicy" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Privacy Policy - HealthHub Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-image: linear-gradient(to right, #004e70, #001b40);
            color: #fff;
            margin: 0;
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

        .outer-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            width: 100%;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            color: #333;
        }

        h1, h2 {
            color: #000;
        }

        p {
            margin-bottom: 20px;
            color: #000;
        }

        strong {
            color: #000;
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
        <div class="outer-container">
            <div class="container">
                <h1>Privacy Policy</h1>

                <p>Welcome to HealthHub Connect. Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website [URL], use our services, or engage with us in other ways. Please read this policy carefully to understand our practices regarding your personal data and how we will treat it.</p>

                <h2>Information We Collect</h2>
                <p>
                    <strong>Personal Information:</strong> We may collect personal information that you voluntarily provide to us when using our services, such as your name, email address, phone number, and any other information you provide.
                </p>
                <p>
                    <strong>Health Information:</strong> If you are a patient using HealthHub Connect, we may collect health-related information that you provide, including medical history, medications, and other relevant health details.
                </p>
                <p>
                    <strong>Usage Data:</strong> We may automatically collect certain information about your device and usage patterns when you interact with our website or services, including IP address, browser type, pages visited, and access times.
                </p>

                <h2>How We Use Your Information</h2>
                <p>
                    <strong>To Provide Services:</strong> We use your information to operate, maintain, and provide you with the features and functionality of HealthHub Connect.
                </p>
                <p>
                    <strong>To Communicate:</strong> We may use your contact information to communicate with you about your appointments, updates to our services, and promotional offers.
                </p>
                <p>
                    <strong>To Improve Services:</strong> We analyze usage data to improve our services, troubleshoot issues, and optimize performance.
                </p>

                <h2>Sharing Your Information</h2>
                <p>
                    <strong>With Your Consent:</strong> We may share your information with third parties when you explicitly consent to the sharing.
                </p>
                <p>
                    <strong>Service Providers:</strong> We may engage third-party service providers to assist with services such as hosting, data analysis, and customer support.
                </p>
                <p>
                    <strong>Legal Compliance:</strong> We may disclose your information when required by law or to protect our rights and safety.
                </p>

                <h2>Security of Your Information</h2>
                <p>We implement appropriate technical and organizational measures to protect your personal data from unauthorized access, use, or disclosure.</p>

                <h2>Your Choices and Rights</h2>
                <p>You have the right to access, correct, or delete your personal information. You may also opt-out of receiving promotional communications from us.</p>

                <h2>Changes to This Privacy Policy</h2>
                <p>We may update this Privacy Policy periodically to reflect changes in our practices and legal requirements. We will notify you of any material changes by posting the updated policy on our website.</p>

                <h2>Contact Us</h2>
                <p>If you have any questions about this Privacy Policy or our data practices, please contact us at <strong>connecthealthhub@outlook.com</strong>.</p>
            </div>
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
                <p><strong>Trusted Healthcare Providers</strong><br>
                    Verified & experienced doctors</p>
            </div>
            <div class="benefit-item">
                <i class="fas fa-thumbs-up"></i>
                <p><strong>Personalized Recommendations</strong><br>
                    Find the best-suited doctors</p>
            </div>
            <div class="benefit-item">
                <i class="fas fa-pills"></i>
                <p><strong>Medication Reminders</strong><br>
                    Never miss a dose again</p>
            </div>
        </div>
        <div class="footer-rights">
            <p>© HealthHub Connect. All rights reserved</p>
        </div>
    </footer>

</body>
</html>
