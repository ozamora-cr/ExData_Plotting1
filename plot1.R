
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

# plot 1
hist(data$Global_active_power, main ="Global Active Power",xlab= "Global Active Power (kilowatts)",col ="Red")

# save plot 1
png("plot1.png",width=480, height=480)
hist(data$Global_active_power, main ="Global Active Power",xlab= "Global Active Power (kilowatts)",col ="Red")
dev.off()
