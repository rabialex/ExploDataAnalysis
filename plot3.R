## Plot3: Sums PM2.5 emissions by type for Baltimore City, using NEI data.
## Plot shows total PM2.5 emissions for 1999, 2002, 2005 and 2008
## Compares total emissions based on type of emission

library(dplyr)
library(ggplot2)

## Check if file is loaded
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
  NEI <- tbl_df(NEI)
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
  SCC <- tbl_df(SCC)
}

## Extract Baltimore Data
NEIbaltimore <- filter(NEI, fips == "24510")

## Group Baltimore Data by type and year
NEIbaltimore_typeyear <- group_by(NEIbaltimore, type, year)

EmissionsDF <- summarise(NEIbaltimore_typeyear, Emissions = sum(Emissions))

## Plot of total emissions by type
png("plot3.png")
g <- ggplot(data = EmissionsDF, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") + ylab("Total PM2.5 Emissions") +ggtitle("Baltimore City Total PM2.5 Emissions by Type 1999 to 2008")
print(g)
dev.off()



