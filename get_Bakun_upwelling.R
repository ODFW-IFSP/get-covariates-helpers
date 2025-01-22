# Creator: Megan Sabal (megan.c.sabal@odfw.oregon.gov)

# Template to download Bakun upwelling index
# from NOAA


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

up_url <- "https://oceanwatch.pfeg.noaa.gov/products/PFELData/upwell/monthly/upindex.mon"

# Read data directly into R!
up_dat <- read.table(up_url, header = FALSE, skip = 3, fill=TRUE)  # download data but skip top description and column names

colnames(up_dat) <- c("lat", "lon", "year", seq(1,12,by=1))  # add column names

# Clean and into long format
up_dat <- up_dat %>% tibble() %>% 
  mutate(across(c(3:15), as.numeric)) %>%  # make sure appropriate columns are numeric
  pivot_longer(cols = c(4:15), names_to = "month", values_to = "upwell") %>%  # put in long format
  mutate(month = as.numeric(month))        # change month column to numeric

up_dat # look at it



# Options for summarizing

# See available sites by latitude
levels(as.factor(up_dat$lat)) 

# Choose certain sites
  # Alter this with what sites you want
choose_lats <- c("36N", "39N")


# Annual mean for select sites combined
  # Can alter summary metric from mean to others e.g., median
up_annual <- up_dat %>% filter(lat == all_of(choose_lats)) %>%  # get only certain sites by latitude
  group_by(year) %>% summarize(mean_upwell = mean(upwell)) %>% ungroup()

up_annual # look at it


# Seasonal means for select sites combined
  # Can alter summary metric from mean to others e.g., median
up_season <- up_dat %>% filter(lat == all_of(choose_lats)) %>%  # get only certain sites by latitude
  mutate(season = ifelse(month %in% c(1,2,3), "JFM",                    # winter (Jan, Feb, Mar)
                         ifelse(month %in% c(4,5,6), "AMJ",             # spring (Apr, May, Jun)
                                ifelse(month %in% c(7,8,9), "JAS",      # summer (Jul, Aug, Sep)
                                       "OND")))) %>%                    # fall (Oct, Nov, Dec)
  group_by(year, season) %>% summarize(seasonal_upwell = mean(upwell)) %>%  # calculate seasonal mean
  pivot_wider(names_from = season, values_from = seasonal_upwell,
              names_prefix = "upwell_") %>% ungroup()

up_season # look at it


