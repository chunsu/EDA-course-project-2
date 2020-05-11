## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
plot1 <- function(){

library(dplyr)

## Read data
data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

## Sums up year total emission
total <- summarise(group_by(data, year), Emissions = sum(Emissions))

## Make png plot
png("Plot 1.png")
plot(total, type = "b", xaxt = "n", ylab = "Emissions (tons)", lwd=3, pch=19, col = "blue")
## Customize the x axis tick label
axis(1, at=total$year, labels= total$year)
title(main = "PM2.5 Total Emissions in the United States")
dev.off() 

}