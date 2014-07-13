## This creates four line plots representing global active power versus time 
## (Plot 1), voltage used versus time, energy submetering versus time (Plot 3),
## and global reactive power versus time with data from the "Individual 
## household electric power consumption Data Set" from the UC Irvine Machine 
## Learning Repository..

# Read in the data; since R will convert strings to factors, the column classes
# need to be assigned values. The separator in the file is a semicolon, 
# there is a header, and according to the instructions, NA values are 
# represented by "?".

hp <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"), 
                 na.strings = "?")

# Subset the dataset to get the wanted data (2007/02/01 and 2007/02/02)
# bind the results to the data set

hpsub <- subset(hp, hp$Date == "1/2/2007" | hp$Date == "2/2/2007")
hpsub$Date <- as.Date(hpsub$Date, "%d/%m/%Y")
datetime <- paste(hpsub$Date, hpsub$Time, sep = " ")
datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
hpsub <- cbind(datetime, hpsub)

# open the png device
png(file = "plot4.png")

#set the number of plots (four plots left to right by row)
par(mfrow = c(2, 2))

# create the plots

plot(hpsub$datetime, hpsub$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

plot(hpsub$datetime, hpsub$Voltage, xlab = "datetime", 
     ylab = "Voltage", type = "l")
plot(hpsub$datetime, hpsub$Sub_metering_1, col = "black", type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(hpsub$datetime, hpsub$Sub_metering_2, col = "red")
lines(hpsub$datetime, hpsub$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("sub_metering_1", "sub_metering_2", 
       "sub_metering_3"), lty = "solid", col = c("black", "red", "blue"), 
       bty = "n")

plot(hpsub$datetime, hpsub$Global_reactive_power, xlab = "datetime",
     ylab = "Global_reactive_power", type = "l")

# close the device
dev.off()