# Read in the data
energydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Format the date
energydata$Date <- as.Date(energydata$Date, format = "%d/%m/%Y")

# Subset the date interval
energydata2 <- subset(energydata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create PNG file
png("plot1.png", width = 480, height = 480)

# Plot the data
hist(energydata2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active power (kilowatts)")

# Turn off the device
dev.off()
