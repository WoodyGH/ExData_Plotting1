library(dplyr)

#read raw data
FilePath = "/Users/Chungw/Documents/R/ExData_Plotting1/"
FileName = paste0(FilePath, "household_power_consumption.txt")
all_data <- read.table(FileName, header=TRUE, sep=";", na.string="?")

#subset data based on the date
sub_data <- subset(all_data, Date == "1/2/2007" | Date == "2/2/2007")

#convert date and time characters to POSIXct
sub_data <- sub_data %>% mutate(POSIX = as.POSIXct(strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))) 

#plot line graph of global active power
with(sub_data, plot(POSIX, Global_active_power, col="black", type="l", xlab="", ylab="Global Active Power (kilowatts)", main=""))
dev.copy(png, paste0(FilePath,"plot2.png"))
dev.off()

