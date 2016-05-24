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

## Merge NEI and SCC data frames
NEISCC <-  merge(NEI, SCC, by = "SCC")

## Subset data for coal type emissions
coalRows <- grepl("coal", NEISCC$Short.Name, ignore.case = TRUE)
coalNEISCC <- NEISCC[coalRows,]

## Group coal emissions for year
coalNEISCC <- group_by(coalNEISCC, year)
SumCoalNEISCC <- summarise(coalNEISCC, coalEmissions = sum(Emissions))

## Plot coal emissions data for each year
png("plot4.png")
barplot(height = SumCoalNEISCC$coalEmissions, names.arg = SumCoalNEISCC$year, xlab = "Year", ylab = "Total PM2.5 Emissions", main = "Total Coal Source PM2.5 Emissions 1999 to 2008" )
dev.off()