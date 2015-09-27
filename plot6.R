
## Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == '06037'
## .). Which city has seen greater changes over time in motor vehicle emissions?

# load the needed packages
library(dplyr)
library(ggplot2)

# Read the datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# filter the dataset to only include the observations for
# Baltimore City, Maryland (fips = "24510") and Los Angeles County, 
# California (fips == '06037')
baltimore_losangeles_nei <- filter(nei, fips == '24510' | fips == '06037')

# Get the SCC code strings for the sources that fall into
# coal combustion-related sources category
scc_motor <- filter(scc, grepl("Motor", scc$Short.Name))
scc_motor_sourceCodes <- select(scc_motor,SCC)

## Filter the observations from baltimore_losangeles_nei such that only SCC 
## codes related to motor vehicle sources are included
la_ba_nei_motor <- filter(baltimore_losangeles_nei, 
                              baltimore_losangeles_nei$SCC 
                              %in% scc_motor_sourceCodes$SCC)


# Group the dataset by year
LA_BA_nei_motor_by_year_fips <- group_by(la_ba_nei_motor, year,fips)

#Calculate the total PM2.5 emissions for each year
LA_BA_nei_motor_emissions_by_year_fips<- summarise(
        LA_BA_nei_motor_by_year_fips, totalEmissions = sum(Emissions))

# Plot using the ggplot2
# Save the plot in plot6.png
g <- ggplot(LA_BA_nei_motor_emissions_by_year_fips, 
            aes(year,totalEmissions))
g + geom_point() + geom_smooth(method = "lm") +
        labs(title ="Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City and Los Angeles during 1999-2008") +
        labs( y = "Total PM2.5 Emissions in tons") + facet_grid( . ~ fips)

ggsave(file = "plot6.png")

