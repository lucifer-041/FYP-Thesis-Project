<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HealthHub.Home" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HealthHub Connect - Home</title>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
     <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #004e70, #001b40);
            color: #fff;
            margin: 0px;
            padding: 0px;
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
    color: #3bb9ec; /* Adjusted to match other nav links */
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    text-align: left;
    width: 100%;
    box-sizing: border-box;
    position: relative; /* Added this line */
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 150px; /* Adjust the width as needed */
    overflow-y: auto;
    max-height: 300px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    left: 0; /* Ensure the dropdown is aligned with the parent */
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
            margin-right:20px;
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

        

        #mainContent {
            position: relative;
            width: calc(100% - 40px);
            height: 60vh;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-radius: 10px;
            background: rgba(0, 0, 0, 0.5);
            background-image: url('pics/bg.png');
            background-size: cover;
            background-position: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);

        }

        .slide {
            display: none;
            text-align: left;
            width: 70%;
        }

            .slide h1 {
                font-size: 3em;
                margin: 0.5em 0;
            }

            .slide p {
                font-size: 1.5em;
                margin: 1em 0;
            }

            .slide img {
                width: 300px;
                height: auto;
                margin: 1em 0;
                position: absolute;
                right: 50px;
                top: 60%;
                transform: translateY(-50%);
                border-radius: 10px;
            }

        .content-section {
            text-align: center;
            margin: 50px 0;
        }

            .content-section h2 {
                font-size: 2.5em;
                margin-bottom: 20px;
            }

            .content-section .symptom-selector {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 40px;
            }

        .symptom-selector select {
        }

        .symptom-selector select {
            flex: 1;
            max-width: 350px; /* Increased max width */
        }

        #btnFindDoctors {
            background-color: #00a8e8;
            color: #fff;
            cursor: pointer;
            padding: 15px 20px;
            font-size: 1.2em;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
        }

        .symptom-selector .select2-container--default .select2-selection--multiple {
            border: none;
            border-radius: 5px;
            display: flex;
            flex-wrap: wrap; /* Allows the selections to wrap within the container */
            align-items: center;
            padding: 5px 10px;
            min-height: 55px; /* Set a minimum height to match the button size */
        }

            .symptom-selector .select2-container--default .select2-selection--multiple .select2-selection__choice {
                background-color: #004e70; /* Selected option background */
                color: #fff; /* Selected option text color */
                font-size: 16px; /* Increase font size */
                padding: 5px 10px;
                margin: 2px;
                border-radius: 5px;
            }

            .symptom-selector .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
                color: #fff; /* Remove button color */
            }

        .select2-dropdown {
            background-color: #fff; /* Dropdown background */
            color: #000; /* Dropdown text color */
        }

        .select2-results__option {
            color: #000; /* Dropdown option text color */
        }

        .select2-container .select2-selection--multiple .select2-selection__choice {
            background-color: #004e70; /* Adjust background color */
            color: #fff; /* Adjust text color */
            font-size: 16px; /* Increase font size */
            padding: 5px 10px;
            margin: 2px;
            border-radius: 5px;
        }

        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            color: #fff; /* Adjust remove button color */
        }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {
                color: #fff; /* Adjust hover color */
                background-color: #003350; /* Adjust hover background */
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:focus {
                color: #fff; /* Adjust focus color */
                background-color: #003350; /* Adjust focus background */
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:active {
                color: #fff; /* Adjust active color */
                background-color: #003350; /* Adjust active background */
            }

        .symptom-selector .select2-container--default .select2-selection--multiple {
            border: none;
            border-radius: 5px;
            display: flex;
            flex-wrap: wrap; /* Allows the selections to wrap within the container */
            align-items: center;
            padding: 5px 10px;
            min-height: 55px; /* Set a minimum height to match the button size */
            width: 100%; /* Ensures the container takes the available width */
            box-sizing: border-box; /* Ensure padding and border are included in the element's total width and height */
        }

        .symptom-selector .select2-selection__rendered {
            display: flex;
            flex-wrap: wrap;
        }

        .symptom-selector .select2-selection__choice {
            background-color: #004e70; /* Selected option background */
            color: #fff; /* Selected option text color */
            font-size: 16px; /* Increase font size */
            padding: 5px 10px;
            margin: 2px;
            border-radius: 5px;
        }

        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #004e70; /* Adjust background color */
            color: #fff; /* Adjust text color */
            font-size: 16px; /* Increase font size */
            padding: 5px 10px;
            margin: 2px;
            border-radius: 5px;
        }

        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            color: #fff; /* Adjust remove button color */
        }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {
                color: #fff; /* Adjust hover color */
                background-color: #003350; /* Adjust hover background */
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:focus {
                color: #fff; /* Adjust focus color */
                background-color: #003350; /* Adjust focus background */
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:active {
                color: #fff; /* Adjust active color */
                background-color: #003350; /* Adjust active background */
            }

        .select2-dropdown {
            background-color: #fff; /* Adjust dropdown background color */
            color: #000; /* Adjust dropdown text color */
        }

        .select2-results__option {
            color: #000; /* Adjust dropdown option text color */
        }

        .how-it-works {
            display: flex;
            justify-content: space-around;
            margin-top: 40px;
        }

            .how-it-works .step {
                flex: 1;
                max-width: 300px;
                padding: 20px;
                text-align: center;
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0.1);
                margin: 0 5px;
            }

                .how-it-works .step img {
                    width: 150px;
                    height: auto;
                    margin-bottom: 20px;
                }

                .how-it-works .step h3 {
                    font-size: 1.8em;
                    margin-bottom: 10px;
                }

                .how-it-works .step p {
                    font-size: 1em;
                }

        .specializations {
            text-align: center;
            margin: 50px 0;
        }

            .specializations .heading-container {
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                width: 100%;
                margin-bottom: 30px;
            }

            .specializations h2 {
                font-size: 2.5em;
                margin: 0;
                flex: 1;
            }

        .view-more {
            font-size: 1.2em;
            color: #00a8e8;
            cursor: pointer;
            position: absolute;
            right: 0;
            margin-right: 20px;
        }







        .specializations .specialization-list {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .specializations .specialization {
            text-align: center;
            flex: 1 1 100px;
            cursor: pointer;
        }

            .specializations .specialization img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                margin-bottom: 5px;
            }

        .specializations a {
            color: #fff;
            text-decoration: none;
            font-size: 1.2em;
            display: block;
        }

        .find-doctors-section {
            text-align: center;
            margin: 50px 0;
        }

            .find-doctors-section h2 {
                font-size: 2.5em;
                margin-bottom: 20px;
            }

            .find-doctors-section button {
                padding: 15px 20px;
                font-size: 1.2em;
                background-color: #00a8e8;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script>
        $(document).ready(function () {
            let currentIndex = 0;
            const slides = $('.slide');
            const totalSlides = slides.length;

            function showSlide(index) {
                slides.hide();
                slides.eq(index).show();
            }

            function nextSlide() {
                currentIndex = (currentIndex + 1) % totalSlides;
                showSlide(currentIndex);
            }

            setInterval(nextSlide, 2000); // Change slide every 2 seconds

            showSlide(currentIndex);

            // Initialize Select2 for symptom selection
            $('#<%= lstSymptoms.ClientID %>').select2({
                placeholder: "Select your symptoms",
                allowClear: true,
                width: 'resolve' // Ensures the Select2 component takes the available width
            });

            // Show and hide more specializations
            $(".specialization").slice(7).hide();
            $(".view-more").click(function () {
                if ($(this).text() === "View More") {
                    $(".specialization").show();
                    $(this).text("View Less");
                } else {
                    $(".specialization").slice(7).hide();
                    $(this).text("View More");
                }
            });
        });

        function validateSymptomSelection() {
            var selectedSymptoms = $('#<%= lstSymptoms.ClientID %>').val();
            if (selectedSymptoms.length < 1) {
                alert("Please select at least 1 symptom.");
                return false;
            } else if (selectedSymptoms.length > 5) {
                alert("You can select a maximum of 5 symptoms.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

   <header>
    <nav>
        <a href="Home.aspx" class="logo">
            <img src="pics/logo.jpeg" alt="HealthHub Connect">
        </a>
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
            <li><a href="patientsignup.aspx">Join as Patient</a></li>
            <li><a href="doctorsignup.aspx">Join as Doctor</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Login</a>
                <div class="dropdown-content">
                    <a href="patientlogin.aspx">Patient</a>
                    <a href="doctorlogin.aspx">Doctor</a>
                    <a href="AdminLogin.aspx">Admin</a>
                </div>
            </li>
        </ul>
    </nav>
</header>


    <form id="form1" runat="server" onsubmit="return validateSymptomSelection();">
        <div id="mainContent">
            <div class="slide">
                <h1>Find a Doctor And Book An Appointment</h1>
                <p>Effortlessly find a doctor and book an appointment at your convenience with Health Hub Connect. Ensure timely medical consultations for all your health needs.</p>
                <img src="pics/appointment.png" alt="Book An Appointment" />
            </div>
            <div class="slide">
                <h1>Get Recommendations</h1>
                <p>Receive personalized doctor recommendations based on your symptoms. Connect with the best healthcare providers in your area.</p>
                <img src="pics/recommend.png" alt="Get Recommendations" />
            </div>
            <div class="slide">
                <h1>Track Your Medicines</h1>
                <p>Keep track of your medication schedule with our intuitive tracking system. Receive timely reminders to ensure you never miss a dose.</p>
                <img src="pics/medicine.png" alt="Track Your Medicines" />
            </div>
            <div class="slide">
                <h1>Find Doctors Near You</h1>
                <p>Locate doctors near you with ease. Use our integrated location feature to find the best medical care in your vicinity.</p>
                <img src="pics/find.png" alt="Find Doctors Near You" />
            </div>
        </div>

        <div class="content-section">
            <h2>Confused? Let Us Make Some Recommendations For You</h2>
            <div class="symptom-selector">
                <asp:ListBox ID="lstSymptoms" runat="server" SelectionMode="Multiple" CssClass="js-example-basic-multiple"></asp:ListBox>
                <asp:Button ID="btnFindDoctors" runat="server" Text="Find Doctors" OnClick="btnFindDoctors_Click" />
            </div>
        </div>

        <div class="content-section">
            <h2>How it Works</h2>
            <div class="how-it-works">
                <div class="step">
                    <img src="pics/37.png" alt="Enter Symptoms" />
                    <h3>Enter Symptoms</h3>
                    <p>Describe your health issues by selecting symptoms from the list. This helps us understand your condition and provide accurate doctor recommendations.</p>
                </div>
                <div class="step">
                    <img src="pics/38.png" alt="Find Doctors" />
                    <h3>Find Doctors</h3>
                    <p>Get personalized recommendations for the best doctors in your area based on your symptoms. Choose from a list of highly qualified specialists.</p>
                </div>
                <div class="step">
                    <img src="pics/39.png" alt="Book Appointment" />
                    <h3>Book Appointment</h3>
                    <p>Schedule an appointment with your chosen doctor at a convenient time. Our easy-to-use booking system ensures you get timely medical consultations.</p>
                </div>
            </div>
        </div>


        <div class="specializations">
            <div class="heading-container">
                <h2>Consult Best Doctors Online</h2>
                <div class="view-more">View More</div>
            </div>
            <div class="specialization-list">
                <div class="specialization" onclick="window.location.href='Allergist.aspx'">
                    <img src="pics/allergist.png" alt="Allergist" />
                    <a href="Allergist.aspx">Allergist/Immunologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Anesthesiologist.aspx'">
                    <img src="pics/anesthesiologist.png" alt="Anesthesiologist" />
                    <a href="Anesthesiologist.aspx">Anesthesiologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Cardiologist.aspx'">
                    <img src="pics/cardiologist.png" alt="Cardiologist" />
                    <a href="Cardiologist.aspx">Cardiologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Dentist.aspx'">
                    <img src="pics/dentist.png" alt="Dentist" />
                    <a href="Dentist.aspx">Dentist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Dermatologist.aspx'">
                    <img src="pics/derma.png" alt="Dermatologist" />
                    <a href="Dermatologist.aspx">Dermatologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='EmergencyMedicine.aspx'">
                    <img src="pics/emergency.png" alt="Emergency Medicine Specialist" />
                    <a href="EmergencyMedicine.aspx">Emergency Medicine Specialist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Endocrinologist.aspx'">
                    <img src="pics/endo.png" alt="Endocrinologist" />
                    <a href="Endocrinologist.aspx">Endocrinologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='FamilyMedicine.aspx'">
                    <img src="pics/familymed.png" alt="Family Medicine Physician" />
                    <a href="FamilyMedicine.aspx">Family Medicine Physician</a>
                </div>
                <div class="specialization" onclick="window.location.href='Gastroenterologist.aspx'">
                    <img src="pics/gastro.png" alt="Gastroenterologist" />
                    <a href="Gastroenterologist.aspx">Gastroenterologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='GeneralPhysician.aspx'">
                    <img src="pics/general.png" alt="General Physician" />
                    <a href="GeneralPhysician.aspx">General Physician</a>
                </div>
                <div class="specialization" onclick="window.location.href='Geriatrician.aspx'">
                    <img src="pics/geriatrician.png" alt="Geriatrician" />
                    <a href="Geriatrician.aspx">Geriatrician</a>
                </div>
                <div class="specialization" onclick="window.location.href='Hematologist.aspx'">
                    <img src="pics/hematologist.png" alt="Hematologist" />
                    <a href="Hematologist.aspx">Hematologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Hepatologist.aspx'">
                    <img src="pics/hepatologist.png" alt="Hepatologist" />
                    <a href="Hepatologist.aspx">Hepatologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='InfectiousDisease.aspx'">
                    <img src="pics/infectious.png" alt="Infectious Disease Specialist" />
                    <a href="InfectiousDisease.aspx">Infectious Disease Specialist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Internist.aspx'">
                    <img src="pics/internist.png" alt="Internist" />
                    <a href="Internist.aspx">Internist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Nephrologist.aspx'">
                    <img src="pics/nephrologist.png" alt="Nephrologist" />
                    <a href="Nephrologist.aspx">Nephrologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Neurologist.aspx'">
                    <img src="pics/neurologist.png" alt="Neurologist" />
                    <a href="Neurologist.aspx">Neurologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='ObstetricianGynecologist.aspx'">
                    <img src="pics/obgyn.png" alt="OB-GYN" />
                    <a href="ObstetricianGynecologist.aspx">Obstetrician and Gynecologist (OB-GYN)</a>
                </div>
                <div class="specialization" onclick="window.location.href='Oncologist.aspx'">
                    <img src="pics/oncologist.png" alt="Oncologist" />
                    <a href="Oncologist.aspx">Oncologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Ophthalmologist.aspx'">
                    <img src="pics/ophthalmologist.png" alt="Ophthalmologist" />
                    <a href="Ophthalmologist.aspx">Ophthalmologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Orthopedist.aspx'">
                    <img src="pics/orthopedist.png" alt="Orthopedist" />
                    <a href="Orthopedist.aspx">Orthopedist/Orthopedic Surgeon</a>
                </div>
                <div class="specialization" onclick="window.location.href='Otolaryngologist.aspx'">
                    <img src="pics/ent.png" alt="ENT specialist" />
                    <a href="Otolaryngologist.aspx">Otolaryngologist (ENT specialist)</a>
                </div>
                <div class="specialization" onclick="window.location.href='Pathologist.aspx'">
                    <img src="pics/pathologist.png" alt="Pathologist" />
                    <a href="Pathologist.aspx">Pathologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Pediatrician.aspx'">
                    <img src="pics/pediatrician.png" alt="Pediatrician" />
                    <a href="Pediatrician.aspx">Pediatrician</a>
                </div>
                <div class="specialization" onclick="window.location.href='Psychiatrist.aspx'">
                    <img src="pics/psychiatrist.png" alt="Psychiatrist" />
                    <a href="Psychiatrist.aspx">Psychiatrist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Pulmonologist.aspx'">
                    <img src="pics/pulmonologist.png" alt="Pulmonologist" />
                    <a href="Pulmonologist.aspx">Pulmonologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Radiologist.aspx'">
                    <img src="pics/radiologist.png" alt="Radiologist" />
                    <a href="Radiologist.aspx">Radiologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Rheumatologist.aspx'">
                    <img src="pics/rheumatologist.png" alt="Rheumatologist" />
                    <a href="Rheumatologist.aspx">Rheumatologist</a>
                </div>
                <div class="specialization" onclick="window.location.href='SleepMed.aspx'">
                    <img src="pics/sleepmed.png" alt="Sleep Medicine Specialist" />
                    <a href="SleepMed.aspx">Sleep Medicine Specialist</a>
                </div>
                <div class="specialization" onclick="window.location.href='SportsMed.aspx'">
                    <img src="pics/sportsmed.png" alt="Sports Medicine Specialist" />
                    <a href="SportsMed.aspx">Sports Medicine Specialist</a>
                </div>
                <div class="specialization" onclick="window.location.href='Urologist.aspx'">
                    <img src="pics/urologist.png" alt="Urologist" />
                    <a href="Urologist.aspx">Urologist</a>
                </div>
            </div>
        </div>

        <div class="find-doctors-section">
            <h2>Find Doctors Near You</h2>
            <button type="button" onclick="window.location.href='Location.aspx'">Find Doctors</button>
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

