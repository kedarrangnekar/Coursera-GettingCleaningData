setwd("D:/1_DATA SCIENCE SPECIALISATION/4_Exploratory_Data_Analysis_Mar15/Week01/Assignments")

# Reading Data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
data$Date_Mod <- as.Date(data$Date, "%d/%m/%Y")

# Subsetting Data
data_sub <- data[data$Date_Mod >= "2007-02-01" & data$Date_Mod <= "2007-02-02",]

# Histogram for Global Active Power
png(filename = "plot1.png", width = 480, height = 480)
hist(data_sub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()