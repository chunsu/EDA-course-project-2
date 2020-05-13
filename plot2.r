## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
plot2 <- function(){

library(dplyr)

## Read data
data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

## Select rows for Baltimore
Baltimore <- filter(data, fips == "24510")

## Group Baltimore data by year and generate year total
total <- summarise(group_by(Baltimore,year), Emissions = sum(Emissions))

## Generate the plot
png("Plot 2.png")
plot(total, type = "b", xaxt = "n", ylab = "Emissions (tons)", lwd=3, pch=19, col = "blue")
title(main = "PM2.5 Total Emissions in Baltimore")
axis(1, at=total$year, labels= total$year)
dev.off() 
}