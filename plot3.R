# plot3.R
# Liz Ferguson 
# 20150712
# plot 3  - line graph Energy sub metering
#
# read in the data file
# download the zip file from the url address
temp<-tempfile()
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")
# unzip the file
unzip(temp)
unlink(temp)
# set classes to convert the date
setClass('myHPCdate')
setAs("character","myHPCdate", function(from) as.Date(from, format="%d/%m/%Y") )
setClass('myHPCtime')
setAs("character","myHPCtime", function(from) strptime(from, format="%H:%M:%S") )
# create data frame from the txt file, sep is a semicolon and colClasses the first column as a Date
v_dframe<-read.csv("./household_power_consumption.txt", header=TRUE, sep=";"
                   , colClasses = c("myHPCdate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings="?")
v_plotframe<-v_dframe[v_dframe$Date %in% c(as.Date("2007-02-01","%Y-%m-%d"),as.Date("2007-02-02","%Y-%m-%d")), ]
#for this one I needed DateTime... 
v_plotframe$DateTime <- strptime(paste(v_plotframe$Date, v_plotframe$Time),"%Y-%m-%d %H:%M:%S")
# can't do the dev.copy - it cuts off the legend in the png
png("plot3.png", width=480, height=480)
# create plot 3 line graph
plot(v_plotframe$DateTime, v_plotframe$Sub_metering_1, type="n", xlab="",ylab="Energy sub metering")
lines(v_plotframe$DateTime,v_plotframe$Sub_metering_1,col="black")
lines(v_plotframe$DateTime,v_plotframe$Sub_metering_2,col="red")
lines(v_plotframe$DateTime,v_plotframe$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
# png the plot
#dev.copy(png,file="plot3.png")
dev.off()


