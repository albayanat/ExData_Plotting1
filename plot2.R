## plot2.R
## The file "household_power_consumption.txt" is in the Working directory

cat("Construct plot2 \n")

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
png("plot2.png", width=480, height=480)

## Construct the plot

with(df_power, 
     plot(x = Time, y = Global_active_power, type ="l", xlab = "", ylab = " Global Active Power (kilowatt)"))

## Close the device

dev.off()

cat("plot2 saved into plot2.png \n End script plot2.R \n")