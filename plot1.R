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
# Subsetting 
plotdata <- subset(data, Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))
#
# Make a plot
png("plot1.png")
hist(plotdata$Global_active_power, breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()