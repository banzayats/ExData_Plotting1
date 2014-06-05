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
y <- plotdata$Global_active_power
#
# Set locale to english
Sys.setlocale("LC_TIME", "English") 
#
# Make a plot
png("plot2.png")
plot(x, y, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()