# Objective:
# Read in the Individual Household Electric Power Consumption data set from the
# UCI Machine Learning Repository (as made available through the Coursera
# course). This data set contains one minute samples of electric power
# consumption of one household over a 4 year period. This script will read the
# data into a data frame and subset it to the two days of interest for the
# assignment.

library(readr)
library(dplyr)

# If the data file isn't already preseent, download and unzip the data file and
# store as a data frame.
if(!file.exists("household_power_consumption.txt")){
    fileURL <- paste("https://d396qusza40orc.cloudfront.net/",
                     "exdata%2Fdata%2Fhousehold_power_consumption.zip",
                     sep = "")
    download.file(fileURL, "downloaded.zip", method="auto", mode="wb")
    unzip("downloaded.zip")
    file.remove("downloaded.zip")
}

# Create a data frame from the data file using the readr package. Missing values
# are coded as "?" and will be changed to NAs.
elecPower <- read_csv2("household_power_consumption.txt", na = "?")

# Subset the data frame to only the dates of interest for this assignment.
elecPower <- elecPower %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

