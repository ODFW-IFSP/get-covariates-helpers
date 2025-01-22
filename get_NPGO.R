# Creator: Megan Sabal (megan.c.sabal@odfw.oregon.gov)

# Template to download NPGO data
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

npgo_url <- "https://www.psl.noaa.gov/data/correlation/npgo.data"

# Read data directly into R!
npgo_dat <- read.table(npgo_url, header = FALSE, skip = 1, fill=TRUE)

# Add column names: year and months
colnames(npgo_dat) <- c("year", seq(1,12,by=1))

# Get in long format
npgo_dat <- npgo_dat %>% mutate(across(c(2:13), as.character)) %>% 
  filter(!is.na(as.numeric(year))) %>%              # drop trailing rows that are text and not data; will give warning ! NAs introduced by coercion (that's okay)
  pivot_longer(cols = c(2:13), names_to = "month", values_to = "npgo") %>% 
  mutate(across(everything(),  as.numeric)) %>%     # make values numeric
  filter(year > 1900) %>%                           # drop placeholder for next year (year = -99.9)
  filter(npgo > -98)                                # drop placeholder NPGO values for upcoming months (npgo = -99.9)

npgo_dat  # look at it; NPGO monthly values


# Summarizing options

# Summarize annually: mean
 # Could swap out other summary metrics: e.g., median
npgo_annual <- npgo_dat %>% group_by(year) %>% 
  summarize(npgo.A = mean(npgo)) %>% ungroup()

npgo_annual # look at it


# Summarize by season
  # Could change which months go in seasonal groups and/or names of seasons
  # Could change which summary metric: mean used here.
npgo_season <- npgo_dat %>% 
  mutate(season = ifelse(month %in% c(1,2,3), "JFM",                    # winter (Jan, Feb, Mar)
                         ifelse(month %in% c(4,5,6), "AMJ",             # spring (Apr, May, Jun)
                                ifelse(month %in% c(7,8,9), "JAS",      # summer (Jul, Aug, Sep)
                                       "OND")))) %>%                    # fall (Oct, Nov, Dec)
  group_by(year, season) %>% summarize(seasonal_npgo = mean(npgo)) %>%  # calculate seasonal mean
  pivot_wider(names_from = season, values_from = seasonal_npgo,
              names_prefix = "npgo_")

npgo_season # look at it
