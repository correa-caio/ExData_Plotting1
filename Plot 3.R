# Read in the data
energydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Change the date from string to date format
energydata$Date <- as.Date(energydata$Date, format = "%d/%m/%Y")

# Subset the date interval
energydata2 <- subset(energydata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Merge date and time into a new column in the POSIXct format
energydata2 <- cbind(energydata2, DateTime = as.POSIXct(paste((energydata2$Date), energydata2$Time)))

# Create PNG file
png("plot3.png", width = 480, height = 480)

# Plot the data
with(energydata2, {
     plot(Sub_metering_1~DateTime, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~DateTime,col='Red')
     lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Turn off the device
dev.off()