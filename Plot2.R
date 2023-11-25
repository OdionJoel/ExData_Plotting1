
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
png("Plot2.png", width = 480, height = 480)

# Plot the line chartss
plot(x = power_data$DateTime, y = power_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")



dev.off()
