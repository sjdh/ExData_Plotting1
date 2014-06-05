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

#
plot(power$DateTime , power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metring")
lines(power$DateTime , power$Sub_metering_2, type="l", ylab="Global Active Power (kilowatts)", col="red")
lines(power$DateTime , power$Sub_metering_3, type="l", ylab="Global Active Power (kilowatts)", col="blue")
legend("topright", pch = 1, col=c("black", "blue", "red"), legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
dev.copy(png, "plot3.png")
dev.off()


