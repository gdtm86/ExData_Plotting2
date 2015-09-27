# Read the datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Question1 
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 2008

# load the needed packages
library(dplyr)

# Group the dataset by year
NEI_by_year <- group_by(NEI, year)

#Calculate the total PM2.5 emissions for each year
Total_Emissions_by_year <- summarise(NEI_by_year, totalEmissions = sum(Emissions))

#Plot the barplot on the screen to visualize
barplot(Total_Emissions_by_year$totalEmissions, 
        names = Total_Emissions_by_year$year,
        main = "Total PM2.5 Emissions for years 1999, 2002, 2005, 2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions in tons",
        col = "light green",
        border = "red")

#Save the plot in plot1.png
# save the image as a PNG file with a width of 480 pixels and a height of 480 pixels.
# name of the image is plot1.png

png("plot1.png",
    width = 480,
    height = 480
)

barplot(Total_Emissions_by_year$totalEmissions, 
        names = Total_Emissions_by_year$year,
        main = "Total PM2.5 Emissions for years 1999, 2002, 2005, 2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions",
        col = "light green",
        border = "red")

dev.off()

