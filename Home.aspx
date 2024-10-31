<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HealthHub.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HealthHub Connect - Home</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Find a Doctor</h2>
            <asp:Label ID="lblSymptoms" runat="server" Text="Select your symptoms:"></asp:Label><br />
            <asp:ListBox ID="lstSymptoms" runat="server" SelectionMode="Multiple"></asp:ListBox><br />
            <asp:Button ID="btnFindDoctors" runat="server" Text="Find Doctors" OnClick="btnFindDoctors_Click" /><br /><br />
            <asp:GridView ID="gvDoctors" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Doctor Name" />
                    <asp:BoundField DataField="Specialization" HeaderText="Specialization" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="YearsOfExperience" HeaderText="Experience" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
