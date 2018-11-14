## plot3.R
## The file "household_power_consumption.txt" is in the Working directory

cat("Construct plot3 \n")

if(!"sqldf" %in% rownames(installed.packages())) {install.packages("sqldf")}
library(sqldf)

## Read and load data only for 1st and 2nd Feb 2007

df_power<-read.csv.sql(file="household_power_consumption.txt", 
                       sql = " select * from file where Date in (\"1/2/2007\",\"2/2/2007\")", 
                       sep =";",  stringsAsFactors = FALSE) 

closeAllConnections()

## No NA values found with this check:  sum(df_power == "%?%")

## Convert Time variable using strptime

df_power$Time <- strptime(paste(df_power$Date, df_power$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

## Open png file
png("plot3.png", width=480, height=480)

## Construct the plot

with(df_power, plot( x = Time, y = Sub_metering_1, type = "l", xlab ="", ylab= "Energy Sub metering"))
with(df_power, lines( x = Time, y = Sub_metering_2,col ="red"))
with(df_power, lines( x = Time, y = Sub_metering_3,col ="blue"))
legend( x="topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
## Close the device

dev.off()

cat("plot3 saved into plot3.png \n End script plot3.R \n")