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


## Plot 4

png(filename="plot4.png", width=480, height=480)
# Override graphic parameters
par(mfrow=c(2,2))
with(good_data, {
      ## Top left plot
      plot(x=timestamp, y=Global_active_power,
           xlab="",
           ylab="Global Active Power",
           type="l")
      
      ## Top right plot
      plot(x=timestamp, y=Voltage, 
           xlab="datetime",
           ylab="Voltage",
           type="l")
      
      ## Bottom left plot
      plot(x=good_data$timestamp, y=good_data$Sub_metering_1,
           type="l",
           xlab="", 
           ylab="Energy sub metering")
      lines(x=good_data$timestamp, y=good_data$Sub_metering_2,
            type="l",
            col="red")
      lines(x=good_data$timestamp, y=good_data$Sub_metering_3,
            type="l",
            col="blue")
      legend("topright", lty=1, lwd=1, 
             col=c("black", "red", "blue"),
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             bty="n")
      
      ## Bottom right plot
      plot(x=timestamp, Global_reactive_power,
           xlab="datetime",
           ylab="Global_reactive_power",
           type="l")
      
})

dev.off()
