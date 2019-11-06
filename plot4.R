# Download zip file

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,
              destfile='Household_power_consumption.zip',
              method="wininet", # for Windows 
              mode="wb") 
unzip(zipfile = "Household_power_consumption.zip") # unpack the files into subdirectories 

# Read txt file

df <- read.table("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE, skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")), nrows = 2880, sep = ";")

names(df) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# Plot 4
## Open file
png(file = "plot4.png", width = 480, height = 480, units = "px")
## Set English language
Sys.setlocale("LC_ALL", "English")
## Set 4 figures arranged in 2 rows and 2 columns 
par(mfrow=c(2,2))
## Plot
# 1,1
with(df, plot(df$datetime, Global_active_power, type= "l", xlab = "", ylab="Global Active Power (kilowatts)"))
# 1,2
with(df, plot(df$datetime, Voltage, type= "l", xlab = "datetime", ylab="Voltage"))
# 2,1
with(df, plot(df$datetime, df$Sub_metering_1, type= "l", xlab = "", ylab="Energy sub metering"))
with(df, points(df$datetime, df$Sub_metering_2, type= "l", col = "red"))
with(df, points(df$datetime, df$Sub_metering_3, type= "l", col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
# 2,2
with(df, plot(df$datetime, Global_reactive_power, type= "l", xlab = "datetime", ylab="Global_reactive_power"))
## Close file
dev.off()