## This creates a line plot of the Global Active Power by time with data 
## from the "Individual household electric power consumption Data Set" 
## from the UC Irvine Machine Learning Repository.

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

# Open the png device, create the plot, and close the device
# type = "l" creates a line plot

png(file = "plot2.png")
plot(hpsub$datetime, hpsub$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
