## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
plot3 <- function(){

library(dplyr)
library(ggplot2)
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
Baltimore <- filter(data, fips == "24510")
total <- summarise(group_by(data,year,type),Emissions = sum(Emissions))

png("Plot 3.png")
myplot <- qplot(year, Emissions, data = total, color = factor(type), geom="line")
print(myplot)
dev.off() 
}