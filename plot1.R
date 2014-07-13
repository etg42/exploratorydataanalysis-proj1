## This creates a histogram of the Global Active Power from the  
## "Individual household electric power consumption Data Set" 
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

# Open the png device, create the histogram, and close the device

png(file = "plot1.png")
hist(hpsub$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()