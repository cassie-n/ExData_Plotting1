## The following lines download the data from the internet, read the dataset as a table, and subset for the desired days.
library("downloader")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileURL, dest = "ElectricalConsumption.zip", mode = "wb")
unzip("ElectricalConsumption.zip", exdir = "./")
dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
dataset1 <- dataset[(dataset$Date %in% c("1/2/2007", "2/2/2007")), ]

## We need the global_active_power column in a numeric format (it comes as a factor)
data_global <- as.numeric(levels(dataset1$Global_active_power))[dataset1$Global_active_power]

## We open the png file, create the histogram, and then close it.
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data_global, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()