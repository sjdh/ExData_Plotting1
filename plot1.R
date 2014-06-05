#Read in the whole file
all = read.table("household_power_consumption.txt", sep=';', header=TRUE)

#Subsetting - select dates  2007-02-01 and 2007-02-02
power = all[((all$Date == "2/2/2007" | all$Date == "1/2/2007")), ]

#Convert columns to the right types
power$Date = as.Date(power$Date, format="%d/%m/%Y")
power$DateTime = as.POSIXct(paste(power$Date, power$Time), format="%Y-%m-%d %H:%M:%S")
power$Global_active_power = as.numeric(as.character(power[, "Global_active_power"]))
power$Sub_metering_1 = as.numeric(as.character(power[, "Sub_metering_1"]))
power$Sub_metering_2 = as.numeric(as.character(power[, "Sub_metering_2"]))
power$Sub_metering_3 = as.numeric(as.character(power[, "Sub_metering_3"]))
power$Voltage = as.numeric(as.character(power[, "Voltage"]))

#
hist(power$Global_active_power, col='red', main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, "plot1.png")
dev.off()
