#Course 4 Week 1 Project 
#Plot 2
#Prepare R Studio
remove(list=ls())
library(curl)
getwd()
setwd("H:")
getwd()
if(!file.exists("./dataC3W4Q")){dir.create("./dataC3W4Q")}
file = "./household_power_consumption.txt"
#Import Data
all_dat <- read.table(file, header = TRUE, sep = ";")
#Explore raw data
names(all_dat); head(all_dat); tail(all_dat); str(all_dat)
#
#Convert Date and Time into dateTime
#lower case y is for 2-digit year, upper case Y is for 4-digit year
all_dat$Date <-as.Date(all_dat$Date, format = "%d/%m/%Y")
head(all_dat); tail(all_dat)
#subset all_data and select only those on 2/1/2007 and 2/2/2007
dat <- subset(all_dat, Date > "2007-01-31" & Date < "2007-02-03")
head(dat); tail(dat)
dat$new_time <-paste(dat$Date, dat$Time)
dat$dateTime <-c()
dat$dateTime <- strptime(dat$new_time, "%Y-%m-%d %H:%M:%S")
#Convert y-variables from factor to numeric
dat$Global_active_power <- as.numeric(levels(dat$Global_active_power))[dat$Global_active_power]
#
#Set Margins
par(mfrow=c(1,1),mar=c(4,4,4,4))
#Plot
with(dat, plot(dateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab=" "))
#Add Plot number
mtext("Plot 2", side =3, adj = 0, line = 2.5, cex =1, font =1) 
#Save to file
dev.curl()
dev.copy(png, file = "plot2.png")
dev.off()
#