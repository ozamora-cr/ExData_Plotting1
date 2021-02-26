
library(tidyverse)

# read data
data <- read_delim("./dataw1/household_power_consumption.txt"
                   ,delim =";"
                   ,na="?"
                   ,col_types =cols(
                     Date =col_date(format ="%d/%m/%Y")
                     ,Time =col_time(format ="%H:%M:%S")
                     ,Global_active_power =col_double()
                     ,Global_reactive_power =col_number()
                     ,Voltage =col_number()
                     ,Global_intensity =col_number()
                     ,Sub_metering_1 =col_number()
                     ,Sub_metering_2 =col_number()
                     ,Sub_metering_3 =col_number()
                   )
                   ,locale=locale(decimal_mark = ".")
                ) %>%
                mutate(datetime=strptime(paste(Date,Time),format="%Y-%m-%d %H:%M:%S")) %>%
                filter(Date >= "2007/02/01" & Date <= "2007/02/02")


# save plot 4

png("plot4.png",width=480, height=480)
par(mfrow =c(2,2), mar=c(4,4,1,1))
with(data,{
  plot(datetime,Global_active_power,type ="l",xlab="",ylab="Global Active Power")
  plot(datetime,Voltage,type ="l")
  
  plot(datetime,Sub_metering_1,type ="l",xlab="",ylab="Energy sub metering")
  lines(data$datetime,data$Sub_metering_2, col="red")
  lines(data$datetime,data$Sub_metering_3, col="blue")
  legend("topright",lty=1:1,cex=0.5,col=c("black","red","blue"),legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  with(data,plot(datetime,Global_reactive_power,type ="l"))
}
)
dev.off()

