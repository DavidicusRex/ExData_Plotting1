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

## changing variables to numeric
power_con3$Global_active_power<-as.character(power_con3$Global_active_power)
power_con3$Global_active_power<-as.numeric(power_con3$Global_active_power)
power_con3$Sub_metering_1<-as.character(power_con3$Sub_metering_1)
power_con3$Sub_metering_1<-as.numeric(power_con3$Sub_metering_1)
power_con3$Sub_metering_2<-as.character(power_con3$Sub_metering_2)
power_con3$Sub_metering_2<-as.numeric(power_con3$Sub_metering_2)
power_con3$Sub_metering_3<-as.character(power_con3$Sub_metering_3)
power_con3$Sub_metering_3<-as.numeric(power_con3$Sub_metering_3)
power_con3$Voltage<-as.character(power_con3$Voltage)
power_con3$Voltage<-as.numeric(power_con3$Voltage)
power_con3$Global_reactive_power<-as.character(power_con3$Global_reactive_power)
power_con3$Global_reactive_power<-as.numeric(power_con3$Global_reactive_power)

##Create Plot -- NOTE, I PUT THE LEGEND IN THE TOP FOR CLARITY'S SAKE
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
with(power_con3,plot(date_time,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(power_con3,plot(date_time,Voltage,type="l",xlab="datetime"))
with(power_con3,plot(date_time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(power_con3,points(date_time,Sub_metering_2,type="l",col="red"))
with(power_con3,points(date_time,Sub_metering_3,type="l",col="blue"))
legend("top",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.5,bty="n")
with(power_con3,plot(date_time,Global_reactive_power,type="l",xlab="datetime"))

## Save as .png
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()

