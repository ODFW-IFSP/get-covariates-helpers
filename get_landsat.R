
# Get all Landsat data


# Install necessary packages if not already installed
#install.packages("devtools")
devtools::install_github("ropensci/getlandsat")

# Load the library
library(getlandsat)
library(tidyverse)

# # Authenticate your USGS Earth Explorer account (you need to create one on their website)
# #usgs_auth(username = "megan.sabal", password = "getlandsatnow")
# 
# # Search for a specific Landsat scene (e.g., by location, date, and cloud cover)
# results <- landsat_search(
#   lon = -122.3, lat = 37.5,      # Example coordinates (replace with your region)
#   start = "2017-06-01", end = "2017-06-30", 
#   max_cloud = 10,                # Max cloud cover in percentage
#   satellite = "Landsat 8"        # You can change to other Landsat satellites
# )
# 
# # View the search results
# print(results)
# 
# # Download a specific scene
# download_landsat(results[1, "id"], destdir = "path_to_download_directory")


# Try another way?

scenes <- lsat_list(
  lon = -122.3, lat = 37.5,  # Replace with your coordinates
  start_date = "2017-06-01", end_date = "2017-06-30",
  max_cloud = 10
)

# Possibly this coudl work but if i check the actual webpage: https://landsatlook.usgs.gov/
# It says "Temporarily down for maintenence".

