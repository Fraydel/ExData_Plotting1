## Week 1 

# This line is here so the x axis labels appear in English
# Thanks to Community TA Jaap Dubbeldam in forum post 
# https://class.coursera.org/exdata-007/forum/thread?thread_id=34
Sys.setlocale("LC_TIME", "English")

## Get data set 

dataset <- read.csv("./household_power_consumption.txt", header=T, sep=";",
                    na.strings="?", nrows=2075259, check.names=F, 
                    stringsAsFactors=FALSE)


str(dataset)
# Date is a character variable, so:
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
# And now...
class(dataset$Date)


# To subset only the data we need, we can do:
good_data <- subset(dataset, Date>="2007-02-01" & Date<="2007-02-02")

# Now that we have the desired data, we can remove the original dataset
# from the global environment with ?rm
rm(dataset)

timestamp <- paste(as.Date(good_data$Date), good_data$Time)

## Plot 2

# Create new full timestamp variable 
timestamp <- paste(as.Date(good_data$Date), good_data$Time)
good_data$timestamp <- as.POSIXct(timestamp)

png(filename="plot2.png", width=480, height=480)

plot(x=good_data$timestamp, y=good_data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()