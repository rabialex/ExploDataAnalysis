library(dplyr)
library(ggplot2)

## Check if file is loaded
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
  NEI <- tbl_df(NEI)
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
  SCC <- tble_df(SCC)
}

BaltimoreMotorNEI <- filter(NEI, fips == "24510", type == "ON-ROAD")
LAMotorNEI <- filter(NEI, fips == "06037", type == "ON-ROAD")

BaltimoreMotorNEI <- group_by(BaltimoreMotorNEI, year)
LAMotorNEI <- group_by(LAMotorNEI, year)

BaltimoreMotorSum <- summarise(BaltimoreMotorNEI, Emissions = sum(Emissions))
LAmotorSum <- summarise(LAMotorNEI, Emissions = sum(Emissions))

BaltimoreMotorSum$city <- "Baltimore City"
LAmotorSum$city <- "Los Angeles"

motorSumEmissions <- rbind(BaltimoreMotorSum,LAmotorSum)

png("plot6.png")

g <- ggplot(motorSumEmissions, aes(x = factor(year), Emissions)) 
g <- g + geom_bar(stat = "identity") + facet_grid(.~city) + xlab("Year")+ylab("Emissions")+ggtitle("Total Motor Vehicle Emissions Baltimore City vs Los Angeles 1999-2008")

print(g)
dev.off()