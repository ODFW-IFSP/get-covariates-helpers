
# Creator: Megan Sabal (megan.c.sabal@odfw.oregon.gov)

# Template to download Snow Water Equivalent data
# from the USDA's National Resources Conservation Service


#...................................................................................................................
# Install and load packages

# Check if tidyverse is installed, install it if not, and then load it
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}

# Load libraries
library(tidyverse)


#...................................................................................................................
# Instructions

# Go to: https://wcc.sc.egov.usda.gov/reportGenerator/

# Fill out (on the website):
  # Select Stations; then click Add.
  # Select Columns; keep Element: "snow water equivalent", Depth: "none", 
    # Value Type: "Value", Function: "None" (unless want something different); then click Add.
  # Select Time Period and Layout; Choose date range, select Layout: Time Series, and Output Format: CSV.

# Click View Report at bottom right.

# Copy and paste the resulting URL and replace with the one here:
url <- "https://wcc.sc.egov.usda.gov/reportGenerator/view_csv/customMultiTimeSeriesGroupByStationReport/daily/start_of_period/442:OR:SNTL%257C444:UT:SNTL%257Cid=%2522%2522%257Cname/2017-01-10,2025-01-01/stationId,name,WTEQ::value?fitToScreen=false"

# Manually list the site or site(s) you chose.
sites <- c("Diamond_Lake", "Dills_Camp")


# Read data directly into R!
swe_dat <- read.table(url, header = TRUE, skip = 1, fill=TRUE, sep=",") %>% 
  as_tibble()

# SWE is in units: inches
# SWE definition: Depth of water that would theoretically result if the entire snowpack were melted instantaneously

# Rename column names
colnames(swe_dat) <- c("date", sites)

# Put date column into date format
swe_dat <- swe_dat %>% mutate(date = ymd(date)) %>% 
  mutate(month = month(date),
         day = day(date),
         year = year(date))

# Look at cleaned dataset
swe_dat


# Optional:

# Pivot to long format by site
swe_dat_long <- swe_dat %>% pivot_longer(cols = all_of(sites))


# Now you can use this data to summarize as you wish.



