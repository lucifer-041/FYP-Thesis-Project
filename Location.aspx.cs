using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using HealthHub.Services;

namespace HealthHub
{
    public partial class Location : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string specialization = Request.QueryString["specialization"];
                if (!string.IsNullOrEmpty(specialization))
                {
                    ddlSpecialization.SelectedValue = specialization;
                }
            }
        }

        protected void btnFindDoctors_Click(object sender, EventArgs e)
        {
            string location = txtLocation.Text.Trim();
            string specialization = ddlSpecialization.SelectedValue;

            if (!string.IsNullOrEmpty(location) && !string.IsNullOrEmpty(specialization))
            {
                var locationService = new LocationService();
                var coordinates = locationService.GetCoordinates(location);
                if (coordinates != null)
                {
                    List<DoctorHospitalInfo> nearbyDoctors = locationService.GetNearbyDoctors(coordinates.Item1, coordinates.Item2, 10, specialization); // radius in km
                    rptDoctors.DataSource = nearbyDoctors;
                    rptDoctors.DataBind();
                }
                else
                {
                    // Handle geocoding failure
                    rptDoctors.DataSource = null;
                    rptDoctors.DataBind();
                }
            }
        }

        private string GenerateStarRatingHtml(double averageRating)
        {
            int fullStars = (int)averageRating;
            bool halfStar = averageRating % 1 >= 0.5;

            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < fullStars; i++)
            {
                sb.Append("<span class='star'>&#9733;</span>");
            }

            if (halfStar)
            {
                sb.Append("<span class='star'>&#9733;</span>");
            }

            for (int i = fullStars + (halfStar ? 1 : 0); i < 5; i++)
            {
                sb.Append("<span class='star'>&#9734;</span>");
            }

            return sb.ToString();
        }

        protected void rptDoctors_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var doctor = (DoctorHospitalInfo)e.Item.DataItem;
                var imgDoctor = (Image)e.Item.FindControl("imgDoctor");

                // Assuming that the ProfileImage field contains only the image file name
                imgDoctor.ImageUrl = ResolveUrl("") + doctor.ProfileImage;

                var rptHospitals = (Repeater)e.Item.FindControl("rptHospitals");

                var uniqueHospitals = new List<HospitalInfo>();
                var hospitalNames = new HashSet<string>();

                foreach (var hospital in doctor.Hospitals)
                {
                    if (!hospitalNames.Contains(hospital.HospitalName))
                    {
                        uniqueHospitals.Add(hospital);
                        hospitalNames.Add(hospital.HospitalName);
                    }
                }

                rptHospitals.DataSource = uniqueHospitals;
                rptHospitals.DataBind();

                var litAverageRating = (Literal)e.Item.FindControl("litAverageRating");
                double averageRating = doctor.AverageRating;
                litAverageRating.Text = GenerateStarRatingHtml(averageRating);
            }
        }
    }
}


