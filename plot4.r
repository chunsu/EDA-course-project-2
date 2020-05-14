## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008
plot4 <- function(){

library(dplyr)
library(ggplot2)

SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
## extract SCC items contain phrase of "comb"(combustion) and "coal"
SCC_index <- grep("Comb.*[cC]oal", SCC$Short.Name)
SCC_list <- as.character(SCC$SCC[SCC_index])

data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
coal_data <- filter(data, SCC %in% SCC_list)
coal_total <- summarise(group_by(coal_data,year), Emissions = sum(Emissions))

png("Plot 4.png")
##myplot <- qplot(year, Emissions, data = coal_total, geom="line")
myplot <- ggplot(coal_total, aes(year, Emissions)) + 
		  geom_line() + 
		  geom_point() + 
		  ggtitle("Emissions from Coal Combustion Sources in United States") + 
		  theme(plot.title = element_text(hjust = 0.5)) +
		  labs(y = "Emissions (tons)") +
		  scale_y_continuous(labels = function(x) format(x, scientific = TRUE))

print(myplot)
dev.off() 
}