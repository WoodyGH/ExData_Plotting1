library(dplyr)

#read raw data
FilePath = "/Users/Chungw/Documents/R/ExData_Plotting1/"
FileName = paste0(FilePath, "household_power_consumption.txt")
all_data <- read.table(FileName, header=TRUE, sep=";", na.string="?")

#subset data based on the date
sub_data <- subset(all_data, Date == "1/2/2007" | Date == "2/2/2007")

#convert date and time characters to POSIXct
sub_data <- sub_data %>% mutate(POSIX = as.POSIXct(strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))) 

#plot four line graphs
par(mfrow=c(2,2))
with(sub_data, plot(POSIX, Global_active_power, col="black", type="l", xlab="", ylab="Global Active Power", main=""))
with(sub_data, plot(POSIX, Voltage, col="black", type="l", xlab=""))
with(sub_data, plot(POSIX, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering", main=""))
lines(sub_data$POSIX, sub_data$Sub_metering_2, col="red")
lines(sub_data$POSIX, sub_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), cex=0.5)
with(sub_data, plot(POSIX, Global_reactive_power, col="black", type="l", xlab="", ylab="Global_reactive_power", main=""))

dev.copy(png, paste0(FilePath,"plot4.png"))
dev.off()

