# This code file includes code for reading the data so that the plot can be fully reproduced.
# Make a connection to the household_power_consumption.txt file read the relevant data for the first 2 days of Feb 2007

# set file
hpc <- file("household_power_consumption.txt")

#get the required data for 1st & 2nd Feb 2007.
plotdata <- read.table(text = grep("^[1,2]/2/2007", readLines(hpc), value = TRUE), sep = ";" , na.strings = "?"
                       , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
                       , header=TRUE)

# Paste together date and time and convert date column to type Date
plotdata$Time <- strptime(paste(plotdata$Date, plotdata$Time), "%d/%m/%Y %H:%M:%S")
plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")

#***************************** PLOT***********************************#
# open png device
png(filename='plot4.png',width=480,height=480,units = "px")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(plotdata, {
  plot(Time, Global_active_power, type="l", xlab="",ylab="Global Active Power")
  plot(Time, Voltage, type="l", ylab="Voltage",xlab="datetime")
  plot(Time, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
  lines(Time, Sub_metering_2,col="red")
  lines(Time, Sub_metering_3,col="blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(Time, Global_reactive_power, type="l", xlab="datetime")
})

#close device
dev.off()