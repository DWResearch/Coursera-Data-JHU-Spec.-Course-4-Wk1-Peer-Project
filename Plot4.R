#Course 4 Week 1 Project 
#Plot 4
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
dat$Sub_metering_1 <- as.numeric(levels(dat$Sub_metering_1))[dat$Sub_metering_1]
dat$Sub_metering_2 <- as.numeric(levels(dat$Sub_metering_2))[dat$Sub_metering_2]
dat$Sub_metering_3 <- as.numeric(levels(dat$Sub_metering_3))[dat$Sub_metering_2]
dat$Voltage <- as.numeric(levels(dat$Voltage))[dat$Voltage]
#
#Plot 1
#title("Plot 1")
par(mfrow=c(1,1),mar=c(4,4,4,4))
#Convert Global_active_power from factor to numeric
#
par(mfrow=c(2,2),mar=c(4,4,4,4))
#Plot upper left--first row, first column
with(dat, plot(dateTime, Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab=" "))
#Add Plot number
mtext("Plot 4", side =3, adj = 0, line = 2, cex =1, font =1) 
#Plot upper right--first row, second column
with(dat, plot(dateTime, dat$Voltage, type="l"))
#Plot lower left--Second row, first column
with(dat, plot(dateTime, Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub Metering"))
points(dat$dateTime, dat$Sub_metering_1, col = "black", type = "l")
points(dat$dateTime, dat$Sub_metering_2, col = "red", type = "l")
points(dat$dateTime, dat$Sub_metering_3, col = "blue", type = "l")
#Add legend and plot number
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
#Plot lower right--Second row, second column
dat$Global_reactive_power <- as.numeric(levels(dat$Global_reactive_power))[dat$Global_reactive_power]
with(dat, plot(dateTime, dat$Global_reactive_power, type ="l"))
dev.curl()
dev.copy(png, file = "plot4.png")
dev.off()
