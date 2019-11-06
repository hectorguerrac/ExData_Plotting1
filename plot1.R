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

# Plot 1
## Open file
png(file = "plot1.png", width = 480, height = 480, units = "px")
## Plot
hist(df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
## Close file
dev.off() 
