library(dplyr)

## Check if file is loaded
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
  NEI <- tbl_df(NEI)
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
  SCC <- tble_df(SCC)
}

motorNEI <- filter(NEI,fips == "24510", type == "ON-ROAD")
motorNEI <- group_by(motorNEI, year)

motorNEIsum <- summarise(motorNEI, Emissions = sum(Emissions))

png("plot5.png")
barplot(height = motorNEIsum$Emissions, names.arg = motorNEIsum$year, xlab = "Year", ylab = "Total PM2.5 Emissions", main = "Baltimore City Total Motor Vehicle PM2.5 Emissions 1999 to 2008" )
dev.off()