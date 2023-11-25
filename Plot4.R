
data_path <- "C:\\Users\\Dell\\Desktop\\couersera\\Project1\\household_power_consumption.txt"
power_data <- read.table(data_path, header = TRUE, sep = ";", na.strings = "?")


str(power_data)
head(power_data)
names(power_data)

# Combine Date and Time columns into a single datetime column
datetime_str <- paste(power_data$Date, power_data$Time)
# Convert the combined datetime string to a POSIXct object
power_data$DateTime <- as.POSIXct(datetime_str, format = "%d/%m/%Y %H:%M:%S")

# Now you can remove the original Date and Time columns
power_data <- power_data[, !(names(power_data) %in% c("Date", "Time"))]

# Display the updated structure of the data
str(power_data)



# Extracting the needed data
power_data <- subset(power_data, DateTime >= "2007-02-01" & DateTime <= "2007-02-02")
head(power_data)
str(power_data)


# Saving
png("Plot4.png", width = 480, height = 480)

## Split the device into four plotting regions
par(mfcol = c(2, 2))


## Create the 'Global Active Power' vs 'Time' plot
plot(x = power_data$DateTime, y = power_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Create the 'Energy sub metering' vs 'Time' plot
plot(x = power_data$DateTime, y = power_data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(x = power_data$DateTime, y = power_data$Sub_metering_1)
lines(x = power_data$DateTime, y = power_data$Sub_metering_2, col = "red")
lines(x = power_data$DateTime, y = power_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")

## Create the 'Voltage' vs 'Time' plot
plot(x = power_data$DateTime, y = power_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Create the 'Global_reactive_power' vs 'Time' plot
plot(x = power_data$DateTime, y = power_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")



dev.off()
