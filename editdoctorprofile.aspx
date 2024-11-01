﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditDoctorProfile.aspx.cs" Inherits="HealthHub.EditDoctorProfile" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor Profile</title>
    <link rel="stylesheet" href="css/editprofiledoc.css">
    <style>
         body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #004e70, #001b40);
            color: white;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 600px;
            width: 90%;
            margin: 20px auto;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #004e70;
        }
        .profile-form {
            display: flex;
            flex-direction: column;
        }
        .profile-picture {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .profile-img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }
        .upload-btn {
            margin-top: 10px;
        }
        .upload-instruction {
            font-size: 0.8em;
            color: #666;
            margin-top: 10px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
        }
        .form-group label {
            margin-bottom: 5px;
            color: #333;
        }
        .form-control {
            width: 99%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-save,
        .dashboard-button {
            background: #3bb9ec;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            align-self: center;
            margin-top: 10px;
            text-align: center;
            display: inline-block;
            text-decoration: none; /* Make the button look like a regular button */
        }
        .btn-save:hover,
        .dashboard-button:hover {
            background: #001b40;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
       /* Styles for the Hospitals and Fees section */
        .hospitals-fees-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

.hospitals-fees-table th,
.hospitals-fees-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
    color: #333; /* Ensures text is dark */
    background-color: #fff; /* Ensures background is white */
}

.hospitals-fees-table th {
    background-color: #f2f2f2;
    color: #333; /* Ensures header text is dark */
}

.hospitals-fees-table td input {
    width: 100%;
    box-sizing: border-box;
    color: #333; /* Ensures input text is dark */
    background-color: #fff; /* Ensures input background is white */
}

 .fees-input-wrapper {
    display: flex;
    align-items: center;
}
.fees-input-wrapper span {
    margin-right: 5px;
    color: #333; /* Ensure the text color is dark */
}

    
    </style>
    <script>

        function validateFees() {
            let valid = true;
            const feesInputs = document.querySelectorAll('.hospitals-fees-table input[type="text"]');
            feesInputs.forEach(input => {
                if (input.value.trim() === '') {
                    valid = false;
                    input.style.borderColor = 'red';  // Highlight the empty field
                } else {
                    input.style.borderColor = '';  // Reset the border color
                }
            });
            if (!valid) {
                document.getElementById('errorMessage').innerText = 'Please fill in all the fees before saving.';
            }
            return valid;
        }

        function showAlert(message) {
            alert(message);
        }
    </script>
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

               <li><a href="doctordashboard.aspx">Dashboard</a></li>
 <li><a href="doctorlogin.aspx">Logout</a></li>

          </ul>
      </nav>
  </header>
    <div class="container">
        <h2>Edit Profile</h2>
        <form id="editProfileForm" runat="server" class="profile-form">
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
            <div class="profile-picture">
                <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" />
                <asp:FileUpload ID="fuProfileImage" runat="server" CssClass="upload-btn" Style=" margin-left:165px;" />
                <asp:Button ID="btnUploadImage" runat="server" Text="Upload Image" CssClass="upload-btn" OnClick="btnUploadImage_Click" />
                <label class="upload-instruction">At least 800x800 px recommended. JPG or PNG is allowed</label>
            </div>
            <div class="form-group">
                <label for="txtFullName">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtPhone">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtSpecialization">Specialization</label>
                <asp:TextBox ID="txtSpecialization" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtMedicalLicenseNumber">Medical License Number</label>
                <asp:TextBox ID="txtMedicalLicenseNumber" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtYearsOfExperience">Years of Experience</label>
                <asp:TextBox ID="txtYearsOfExperience" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtBio">Bio</label>
                <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>

            <div class="form-group">
    <label for="txtEducation">Education</label>
    <asp:TextBox ID="txtEducation" runat="server" CssClass="form-control"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvEducation" runat="server" ControlToValidate="txtEducation" ErrorMessage="Education is required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
</div>
<div class="form-group">
    <label for="txtSpecializations">Specializations</label>
    <asp:TextBox ID="txtSpecializations" runat="server" CssClass="form-control"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvSpecializations" runat="server" ControlToValidate="txtSpecializations" ErrorMessage="Specializations are required." CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
</div>

            <div class="form-group">
                <asp:Button ID="btnUpdate" runat="server" Text="Save changes" CssClass="btn-save" OnClick="btnUpdate_Click" />
            </div>

            <div class="form-group">
                <asp:Repeater ID="rptHospitals" runat="server">
                    <HeaderTemplate>
                        <table class="hospitals-fees-table">
                            <tr>
                                <th>Hospitals</th>
                                <th>Fees</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td><%# Eval("HospitalName") %></td>
                                <td>
                                    <div class="fees-input-wrapper">
                                        <span>Rs.</span>
                                        <asp:TextBox ID="txtFees" runat="server" Text='<%# Eval("Fees") %>' CssClass="form-control" />
                                        <asp:HiddenField ID="hfDoctorID" runat="server" Value='<%# Eval("DoctorID") %>' />
                                        <asp:HiddenField ID="hfHospitalID" runat="server" Value='<%# Eval("HospitalID") %>' />
                                    </div>
                                </td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="form-group">
                <span id="errorMessage" class="error-message" style="color: red;"></span>
                <asp:Button ID="btnSaveFees" runat="server" Text="Save Fees" CssClass="btn-save" OnClientClick="return validateFees();" OnClick="btnSaveFees_Click" />
            </div>


            <asp:LinkButton ID="btnDashboard" runat="server" CssClass="dashboard-button" PostBackUrl="doctordashboard.aspx">Go to Doctor Dashboard</asp:LinkButton>
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
