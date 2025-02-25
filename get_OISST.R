# Creator: Megan Sabal (megan.c.sabal@odfw.oregon.gov)

# Template to download PDO data
# from NOAA


#...................................................................................................................
# Install and load packages

# Check if tidyverse is installed, install it if not, and then load it
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}

# Load libraries
library(tidyverse)

# Increase timeout limit for downloading large https files
options(timeout = 3600)  # 1 hr (in seconds)


#...................................................................................................................
# Instructions


# SST ----

# Description: NOAA High-resolution Blended Analysis of Daily SST and Ice
# SST info available: https://psl.noaa.gov/data/gridded/data.noaa.oisst.v2.highres.html
# Spatial coverage: 0.25 degree latitude x 0.25 degree longitude global grid (1440x720).

# Cite:
# Huang, B., C. Liu, V. Banzon, E. Freeman, G. Graham, B. Hankins, T. Smith, and H.-M. Zhang, 2021: Improvements of the Daily Optimum Interpolation Sea Surface Temperature (DOISST) Version 2.1. J. Climate, 34, 2923-2939, DOI 10.1175/JCLI-D-20-0166.1 (V2.1).
# Reynolds, Richard W., Thomas M. Smith, Chunying Liu, Dudley B. Chelton, Kenneth S. Casey, Michael G. Schlax, 2007: Daily High-Resolution-Blended Analyses for Sea Surface Temperature. J. Climate, 20, 5473-5496 https://doi.org/10.1175/2007JCLI1824.1.


# Download all relevant sst files

# What years do we need data for?
years <- c(1981:2025) # If ever re-run for the entire dataset.


#SST file names to download
files <- str_c("sst.day.mean.",years,".nc")

#Download SST data: mean for selected years. This will take a while! 
lapply(files, function(filenames){
  download.file(str_c("https://downloads.psl.noaa.gov/Datasets/noaa.oisst.v2.highres/",filenames), 
                destfile =  str_c("P:/REDD/Personal/Sabal/Temporary/Covariate_storage/", filenames), mode = "wb")
})





