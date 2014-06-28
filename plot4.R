# Load dataset from url to tempfile
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
#
# Load date from unzipped file
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?")
unlink(temp)
#
# Format date
data$Date <- as.Date(data$Date,"%d/%m/%Y")
#
# Subset and prepare data for plot
plotdata <- subset(data, Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))
x <- strptime(sprintf("%s %s", plotdata$Date, plotdata$Time), format="%Y-%m-%d %H:%M:%S")
y1 <- plotdata$Sub_metering_1
y2 <- plotdata$Sub_metering_2
y3 <- plotdata$Sub_metering_3
# Get the range for the x and y axis 
xrange <- range(x) 
yrange <- range(y1, y2, y3) 
#
# Set locale to english
Sys.setlocale("LC_TIME", "English") 
#
# Make a plot
png("plot4.png")
par(mfrow = c(2, 2))
with(plotdata, {
	plot(x, Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
	plot(x, Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
	plot(xrange, yrange, type="n", xlab="", ylab="Energy sub metering")
	lines(x, y1, type="l", col="black")
	lines(x, y2, type="l", col="red")
	lines(x, y3, type="l", col="blue")
	legend("topright", lty=1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
	plot(x, Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()