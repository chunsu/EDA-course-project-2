## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
## sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
plot6 <- function(){

library(dplyr)
library(ggplot2)


SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
## when use "[mM]otor" as regular expression condition, the SCC list containing 'Surface Coating'
## and 'Motor Vehicle Fires', which are not exactly emissions from moter vehicle. Therefore, I narrowed 
## down with "Motorcycles" as condition, which upon examination list all the road emissions
SCC_index <- grep("Motorcycles.*", SCC$Short.Name)
SCC_list <- as.character(SCC$SCC[SCC_index])




data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
Fips <- c("24510", "06037")
motor_data <- filter(data, SCC %in% SCC_list & fips %in% Fips)
motor_data$fips <- as.factor(motor_data$fips)
## Add a city variable to the data
motor_data$city <- recode(motor_data$fips, "24510" = "Baltimore City", "06037" = "Los Angeles County, California")
motor_total <- summarise(group_by(motor_data,year,city), Emissions = sum(Emissions))


png("Plot 6.png")

myplot <- ggplot(motor_total, aes(year, Emissions)) +
		  facet_grid(.~city) +
		  geom_line() +
		  geom_point() +
		  ggtitle("Emissions from Motor Vehicle Sources") + 
		  theme(plot.title = element_text(hjust = 0.5)) +
		  labs(y = "Emissions (tons)") 
print(myplot)
dev.off() 
}