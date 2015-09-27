## Question 2:
## Have total emissions from PM2.5 decreased in Baltomore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make

# load the needed packages
library(dplyr)

# Read the datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# filter the dataset to only include the observations for
# Baltimore City, Maryland (fips = "24510") 
baltimore_nei <- filter(nei, fips == '24510')

# # Group the dataset by year
baltimore_nei_by_year <- group_by(baltimore_nei, year)

#Calculate the total PM2.5 emissions for each year
baltimore_total_pm2.5_emissions_by_year<- summarise(baltimore_nei_by_year, totalEmissions = sum(Emissions))

#Plot the barplot on the screen to visualize
barplot(baltimore_total_pm2.5_emissions_by_year$totalEmissions, 
        names = baltimore_total_pm2.5_emissions_by_year$year,
        main = "PM2.5 Emissions in Baltimore City, Maryland for years 1999-2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions in tons",
        col = "light green",
        border = "red")

#Save the plot in plot2.png
# save the image as a PNG file with a width of 480 pixels and a height of 480 pixels.
# name of the image is plot2.png

png("plot2.png",
    width = 480,
    height = 480
)

barplot(baltimore_total_pm2.5_emissions_by_year$totalEmissions, 
        names = baltimore_total_pm2.5_emissions_by_year$year,
        main = "PM2.5 Emissions in Baltimore City, Maryland for years 1999-2008",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions in tons",
        col = "light green",
        border = "red")

dev.off()
