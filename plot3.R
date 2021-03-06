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
png(filename='plot3.png',width=480,height=480,units = "px")

# Plot the frequency of Global Active power
with(plotdata, {
  plot(Time, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l")
  lines(Time, Sub_metering_2,col="red")
  lines(Time, Sub_metering_3,col="blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
})

#close device
dev.off()

