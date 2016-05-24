## Plot1: Sums PM2.5 emissions from all sources and types, using NEI data.
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

## Group Variables by the Year 
NEI_year <- group_by(NEI, year)
## Create data frame Emissions sums by year
EmissionTotal_year <- summarise(NEI_year,Emissions = sum(Emissions))

## Plot Emission Sums by Year
png("plot1.png")
barplot(height = EmissionTotal_year$Emissions, names.arg = EmissionTotal_year$year, xlab = "Year", ylab = "Total PM2.5 Emissions", main = "Total PM2.5 Emissions 1999 to 2008" )
dev.off()