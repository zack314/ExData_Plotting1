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

## vector of max of the sub_metering for each time:
max_submetering<-apply(data.frame(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3),1,max)

## Preparing the graphic device
png("plot4.png",  width = 480, height = 480, units = "px")

## Setting the layout
par(mfrow = c(2, 2))

## Plotting # 1
plot(data$FullDate, data$Global_active_power ,type="n",
     ylab = "Global Active Power",
     xlab = "")
lines(data$FullDate, data$Global_active_power)


## Plotting # 2
plot(data$FullDate, data$Voltage ,type="n",
     ylab = "Voltate",
     xlab = "datetime")
lines(data$FullDate, data$Voltage)


## Plotting # 3
plot(data$FullDate, max_submetering ,type="n",
     ylab = "Energy sub metering",
     xlab = "")
lines(data$FullDate, data$Sub_metering_1)
lines(data$FullDate, data$Sub_metering_2,col="red")
lines(data$FullDate, data$Sub_metering_3,col="blue")
legend("topright",bty = "n", lwd=2, col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

## Plotting # 4
plot(data$FullDate, data$Global_reactive_power ,type="n",
     ylab = "Global_reactive_power",
     xlab = "datetime")
lines(data$FullDate, data$Global_reactive_power)



## Savinf
dev.off()
