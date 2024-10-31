<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="patientlogin.aspx.cs" Inherits="Healthhub.patientlogin" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">


    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
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

        .container {
            display: flex;
            min-height: 100vh;
        }

        .left-section {
            background: linear-gradient(to right, #004e70, #001b40);
            color: #fff;
            flex-basis: 45%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .right-section {
            background-color: #fff;
            flex-basis: 55%;
            padding: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .signup-form {
            max-width: 400px;
            width: 100%;
        }

        .input-field {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        .input-field label {
            margin-bottom: 5px;
        }

        .input-field input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .terms {
            margin-bottom: 20px;
        }

        .terms label {
            margin-left: 5px;
        }

        .button {
            padding: 15px;
            width: 100%;
            background-color: #08CBDF;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #001B40;
        }

        .alternative,
        .signin {
            text-align: center;
            margin: 20px 0;
        }

        .signin a {
            color: #625FFA;
            text-decoration: none;
        }

        .left-section img {
            max-width: 100%;
            height: auto;
            display: block;
            margin-top: 20px;
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
        <a href="Home.aspx" class="logo"><img src="pics/logo.jpeg" alt="HealthHub Connect"></a>
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
            <li><a href="patientsignup.aspx">Join as patient</a></li>
            <li><a href="patientlogin.aspx">Login</a></li>
        </ul>
    </nav>
</header>
    <div class="container">
        <div class="left-section">
            <h1 style="text-align:center">Welcome Back to the HealthHub Experience.</h1>
            <img src="pics/Untitled design (1).png" alt="Illustration">
        </div>
        <div class="right-section">
            <form class="login-form" runat="server">
                <h2>Log In</h2>
                <br /> <br />
                <div class="input-field">
                    <label for="login-email">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" TextMode="Email" ClientIDMode="Static" />
                </div>
                <div class="input-field">
                    <label for="login-password">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" ClientIDMode="Static" />
                </div>
                <asp:Label ID="lblMessage" runat="server" CssClass="error-message" />
                <asp:Button ID="btnLogin" runat="server" CssClass="button" Text="Log In" OnClick="btnLogin_Click" ClientIDMode="Static" />
                <br /> <br />  <p><a href="ForgotPasswordPatient.aspx">Forgot Password?</a></p> <!-- Add Forgot Password link here -->
                <p class="alternative">Or Log In With</p>
                <div class="social-media">
                    <!-- Icons for social media -->
                </div>

                <p class="signup-link">Don't have an account? <a href="patientsignup.aspx">Sign Up</a></p>
            </form>
        </div>
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
            <p><i class="fas fa-envelope"></i> connecthealthhub@outlook.com</p>
            
            <div class="footer-socials">
                <a href="https://www.facebook.com/sample"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.instagram.com/sample"><i class="fab fa-instagram"></i></a>
               
            </div>
        </div>
    </div>
    <div class="footer-benefits">
        <div class="benefit-item">
            <i class="fas fa-user-md"></i>
            <p><strong>Trusted Healthcare Providers</strong><br>Verified & experienced doctors</p>
        </div>
        <div class="benefit-item">
            <i class="fas fa-thumbs-up"></i>
            <p><strong>Personalized Recommendations</strong><br>Find the best-suited doctors</p>
        </div>
        <div class="benefit-item">
            <i class="fas fa-pills"></i>
            <p><strong>Medication Reminders</strong><br>Never miss a dose again</p>
        </div>
    </div>
    <div class="footer-rights">
        <p>© HealthHub Connect. All rights reserved</p>
    </div>
</footer>
</body>
</html>
                              s