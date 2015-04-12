
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

## We need the global_active_power column in a numeric format (it comes as a factor)
data_global <- as.numeric(levels(dataset1$Global_active_power))[dataset1$Global_active_power]

## We create a png file and plot.
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(d, data_global, type = "n", xlab = " ", ylab = "Global Active Power (kilowatts)")
lines(d, data_global)
dev.off()