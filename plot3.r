## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
plot3 <- function(){

library(dplyr)
library(ggplot2)

# Read data
data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
# Select rows for Baltimore
Baltimore <- filter(data, fips == "24510")
# Group data by both year and type
total <- summarise(group_by(data,year,type),Emissions = sum(Emissions))
# Make plot
png("Plot 3.png")
##myplot <- qplot(year, Emissions, data = total, color = factor(type), geom="line")
myplot <- ggplot(total, aes(year, Emissions, color = type)) + 
			geom_line() + 
			geom_point() + 
			ggtitle("PM2.5 Emissions in Baltimore by types") + 
			theme(plot.title = element_text(hjust = 0.5)) +
			labs(y = "Emissions (tons)")
print(myplot)
dev.off() 
}