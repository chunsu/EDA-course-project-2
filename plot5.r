## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
plot5 <- function(){

library(dplyr)
library(ggplot2)


SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
## when use "[mM]otor" as regular expression condition, the SCC list containing 'Surface Coating'
## and 'Motor Vehicle Fires', which are not exactly emissions from moter vehicle. Therefore, I narrowed 
## down with "Motorcycles" as condition, which upon examination list all the road emissions
SCC_index <- grep("Motorcycles.*", SCC$Short.Name)
SCC_list <- as.character(SCC$SCC[SCC_index])




data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
Bal_motor <- filter(data, SCC %in% SCC_list & fips == "24510")
Bal_motor_total <- summarise(group_by(Bal_motor,year), Emissions = sum(Emissions))

png("Plot 5.png")
myplot <- ggplot(Bal_motor_total, aes(year, Emissions)) +
		  geom_line() +
		  geom_point() +
		  ggtitle("Emissions from Motor Vehicle Sources in Baltimore") + 
		  theme(plot.title = element_text(hjust = 0.5)) +
		  labs(y = "Emissions (tons)") 
print(myplot)
dev.off() 
}