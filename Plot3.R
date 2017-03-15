#Course 4 Week 1 Project 
#Plot 3
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
dat$Sub_metering_1 <- as.numeric(levels(dat$Sub_metering_1))[dat$Sub_metering_1]
dat$Sub_metering_2 <- as.numeric(levels(dat$Sub_metering_2))[dat$Sub_metering_2]
dat$Sub_metering_3 <- as.numeric(levels(dat$Sub_metering_3))[dat$Sub_metering_2]
#
#Set margins
par(mfrow=c(1,1),mar=c(4,4,4,4))
#Plot
with(dat, plot(dateTime, Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub Metering"))
points(dat$dateTime, dat$Sub_metering_1, col = "black", type = "l")
points(dat$dateTime, dat$Sub_metering_2, col = "red", type = "l")
points(dat$dateTime, dat$Sub_metering_3, col = "blue", type = "l")
#Add legend and plot number
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
mtext("Plot 3", side =3, adj = 0, line = 2.5, cex =1, font =1) 
#Save to file
dev.copy(png, file = "plot3.png", width=480,height=480)
dev.off()