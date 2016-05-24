## Plot2: Sums PM2.5 emissions from all sources and types for Baltimore City, using NEI data.
## Plot shows total PM2.5 emissions for 1999, 2002, 2005 and 2008

library(dplyr)
## Check if file is loaded

if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
  NEI <- tbl_df(NEI)
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
  SCC <- tbl_df(SCC)
}
## Filter for emissions data for Baltimore City, group variables by year
NEI_Baltimore <- filter(NEI, fips == "24510")
NEI_Baltimore <- group_by(NEI_Baltimore, year)

## create data frame of total emissions for Baltimore City by year
NEIBaltimore_year <- summarise(NEI_Baltimore,Emissions = sum(Emissions))

## Plot of Emissions data for Baltimore City
png("plot2.png")
barplot(height = NEIBaltimore_year$Emissions , names.arg = NEIBaltimore_year$year, xlab = "Year", ylab = "Total PM2.5 Emissions", main = "Baltimore City Total PM2.5 Emissions 1999 to 2008" )
dev.off()