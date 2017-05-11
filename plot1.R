## Download data:
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"data.zip",method="curl")
unzip("data.zip")

## Read data:
data<-read.csv("household_power_consumption.txt",sep=";",na.strings = "?",
              colClasses = c("character","character",rep("numeric",7)),stringsAsFactors = FALSE)
## Add a FullDate Column
data$FullDate<-strptime(with(data,paste(Date,Time)),format="%d/%m/%Y %H:%M:%S")

## Set start date/end date
startDate<-strptime("01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
endDate  <-strptime("02/02/2007 23:59:59",format="%d/%m/%Y %H:%M:%S")

## Select data from start-date to end-date
data<-data[ which(data$FullDate>=startDate & data$FullDate <= endDate), ]
rownames(data) <- 1:nrow(data)

## Preparing the graphic device
png("plot1.png",  width = 480, height = 480, units = "px")

## Plotting
hist(data$Global_active_power,col="red",
     main="Global Active Power",xlab = "Global Active Power (kilowatts)")
## Savinf
dev.off()
