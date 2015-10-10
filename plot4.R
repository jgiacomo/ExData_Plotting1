# Objective:
# Read in the Individual Household Electric Power Consumption data set from the
# UCI Machine Learning Repository (as made available through the Coursera
# course). This data set contains one minute samples of electric power
# consumption of one household over a 4 year period. This script will read the
# data into a data frame and subset it to the two days of interest for the
# assignment. Generate the first plot in the assignment from this data.

library(readr)
library(dplyr)
library(lubridate)

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

# Convert the Date and Time fields to POSIXlt
elecPower$dateTime <- strptime(paste(elecPower$Date,
                                                 elecPower$Time),
                                        format = "%d/%m/%Y %H:%M:%S")

# Generate a plot which matches the one provided in the assignment using the
# individual household power consumption data.

# Render the plot as a png file
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))  # 2 x 2 matrix of plots by row

# plot [1,1]
plot(elecPower$dateTime, elecPower$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

# plot [1,2]
plot(elecPower$dateTime, elecPower$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

# plot [2,1]
plot(elecPower$dateTime, elecPower$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering", ylim=c(1,38))
par(new = TRUE)
plot(elecPower$dateTime, elecPower$Sub_metering_2, type="l", col="red",
     ann=FALSE, ylim=c(1,38))
par(new = TRUE)
plot(elecPower$dateTime, elecPower$Sub_metering_3, type="l", col="blue",
     ann=FALSE, ylim=c(1,38))
legend("topright", legend = names(elecPower)[7:9], lty = c(1,1,1),
       lwd = c(2.5,2.5,2.5), col = c("black", "red", "blue"), bty = "n")

# plot [2,2]
plot(elecPower$dateTime, elecPower$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
