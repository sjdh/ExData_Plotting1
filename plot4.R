###################################################################
#### Exploratory Data Analysis - Coursera - Project 1 - Plot 4 ####
###################################################################

## Check if the working directory exists and create it if necessary
dir = '/home/sjoerd/Dropbox/computer_projects/R/coursera/ExData_Plotting1'
if (!file.exists(dir)) {
  dir.create(dir)
}
setwd(dir)


## Check if the raw data exists and download and extract it if necessary
## Delete the compressed data
if(!file.exists("household_power_consumption.txt")) {
  if (!file.exists("data.zip")) {
    print("Downloading raw data, please wait as it may take a while depending on your connection... :)")
    fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl, destfile = "./data.zip", method = "curl")
  }
  print("Unzipping the raw data, please wait...")
  unzip("data.zip")
}
unlink("data.zip")

## Read in the entries with two specific dates from the raw data
#install.packages("sqldf")
library(sqldf)
power <- read.csv.sql(dataset, sql = 'select * from file where Date="1/2/2007" OR Date="2/2/2007"', colClasses=c("character", "character", rep("numeric",7)), sep=";")


## Convert date and time
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power$DateTime = as.POSIXct(paste(power$Date, power$Time), format="%Y-%m-%d %H:%M:%S")

## Generate the fourth plot
par(mfrow = c(2,2))
plot(power$DateTime , power$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(power$DateTime , power$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(power$DateTime , power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metring")
lines(power$DateTime , power$Sub_metering_2, type="l", ylab="Global Active Power (kilowatts)", col="red")
lines(power$DateTime , power$Sub_metering_3, type="l", ylab="Global Active Power (kilowatts)", col="blue")
legend("topright", pch = 1, col=c("black", "blue", "red"), legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
plot(power$DateTime , power$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
par(mfrow = c(1,1))
dev.copy(png, "plot4.png")
dev.off()

