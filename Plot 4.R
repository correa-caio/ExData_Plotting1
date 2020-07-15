# Read in the data
energydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Change the date from string to date format
energydata$Date <- as.Date(energydata$Date, format = "%d/%m/%Y")

# Subset the date interval
energydata2 <- subset(energydata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Merge date and time into a new column in the POSIXct format
energydata2 <- cbind(energydata2, DateTime = as.POSIXct(paste((energydata2$Date), energydata2$Time)))

# Create PNG file
png("plot4.png", width = 480, height = 480)

# Set the layout and margins
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#Plot the data
with(energydata2, plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

with(energydata2, plot(Voltage ~ DateTime, type = "l", ylab = "Voltage (volt)", xlab = ""))

with(energydata2, {
     plot(Sub_metering_1~DateTime, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~DateTime,col='Red')
     lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(energydata2$Global_reactive_power ~ energydata2$DateTime, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab = "")

# Turn off the device
dev.off()