## The following lines download the data from the internet, read the dataset as a table, and subset for the desired days.
library("downloader")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileURL, dest = "ElectricalConsumption.zip", mode = "wb")
unzip("ElectricalConsumption.zip", exdir = "./")
dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
dataset1 <- dataset[(dataset$Date %in% c("1/2/2007", "2/2/2007")), ]

## The variable along the x-axis is time (2880 seconds over two days).  This code does some reformatting to make the date/time usable.
dataset2 <- within(dataset1, DateTime <- paste(Date,Time,sep=','))
d <- strptime(dataset2$DateTime, format="%d/%m/%Y, %H:%M:%S")

## We need the metering columns in a numeric format (they comes as a factor)
meter1 <- as.numeric(levels(dataset2$Sub_metering_1))[dataset2$Sub_metering_1]
meter2 <- as.numeric(levels(dataset2$Sub_metering_2))[dataset2$Sub_metering_2]
meter3 <- dataset2$Sub_metering_3 ## For whatever reason this came as numeric.

## We create the plot by adding each of the three lines one at a time, and then add a legend.
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(d, dataset2$Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub metering")
lines(d, meter1, col = "black")
lines(d, meter2, col = "red")
lines(d, meter3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
dev.off()
