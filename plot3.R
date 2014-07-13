## This creates a line plot with the submetering 1, 2, and 3 (kitchen, 
## laundry room, and electric water heater/air conditioner) in watt-hours
## of active energy versus time from the "Individual household electric 
## power consumption Data Set" from the UC Irvine Machine Learning Repository.

# Read in the data; since R will convert strings to factors, the column classes
# need to be assigned values. The separator in the file is a semicolon, 
# there is a header, and according to the instructions, NA values are 
# represented by "?".

hp <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = c("character", "character", "numeric", "numeric", 
                 "numeric", "numeric", "numeric", "numeric", "numeric"), 
                 na.strings = "?")

# Subset the dataset to get the wanted data (2007/02/01 and 2007/02/02)

hpsub <- subset(hp, hp$Date == "1/2/2007" | hp$Date == "2/2/2007")

# convert the date and time from strings to date and time types
# bind the results to the data set

hpsub$Date <- as.Date(hpsub$Date, "%d/%m/%Y")
datetime <- paste(hpsub$Date, hpsub$Time, sep = " ")
datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
hpsub <- cbind(datetime, hpsub)

# open the png device
# create the plot with the first submetering data
# add lines for the second and third submetering data
# create the legend in the top right corner
# close the device

png(file = "plot3.png")
plot(hpsub$datetime, hpsub$Sub_metering_1, col = "black", type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(hpsub$datetime, hpsub$Sub_metering_2, col = "red")
lines(hpsub$datetime, hpsub$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("sub_metering_1", "sub_metering_2", 
       "sub_metering_3"), lty = "solid", col = c("black", "red", "blue"))
dev.off()
