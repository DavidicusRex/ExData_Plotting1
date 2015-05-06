power_con<-read.table(file.choose(),header=TRUE,sep=";")
## file name is "household_power_consumption.txt"

## convert date and time columns to one column
date_time<-paste(power_con$Date,power_con$Time)
date_time<-strptime(date_time,format="%d/%m/%Y %H:%M:%S")
power_con2<-cbind(date_time,power_con[,c(-1,-2)])

## reduce data to time being analyzed 
library(dplyr)
power_con3<-filter(power_con2,date_time>="2007-02-01 00:00:00",date_time<="2007-02-02 23:59:59")