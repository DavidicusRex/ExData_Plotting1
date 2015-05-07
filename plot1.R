
power_con<-read.table(file.choose(),header=TRUE,sep=";")
## file name is "household_power_consumption.txt"

## convert date and time columns to one column
date_time<-paste(power_con$Date,power_con$Time)
date_time<-strptime(date_time,format="%d/%m/%Y %H:%M:%S")
power_con2<-cbind(date_time,power_con[,c(-1,-2)])

## reduce data to time being analyzed 
library(dplyr)
power_con3<-filter(power_con2,date_time>="2007-02-01 00:00:00",date_time<="2007-02-02 23:59:59")

## check for missing data
apply(power_con3,2,function(x)any(x=="?"))

## changing variable to numberic
power_con3$Global_active_power<-as.numeric(power_con3$Global_active_power)

##Create Histogram
with(power_con3,hist(Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red"))

## Save as .png
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()

