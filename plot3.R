## Question 3:
## Of the four types of sources indicated by the type(point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999-2008 for Baltimore City? Which have seen increases 
# in emissions from 1999-2008? Use the ggplot2 plotting system to make a
# plot answer this question.

# load the needed packages
library(dplyr)
library(ggplot2)

# Read the datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# filter the dataset to only include the observations for
# Baltimore City, Maryland (fips = "24510") 
baltimore_nei <- filter(nei, fips == '24510')

# Group the dataset by year and source type
baltimore_nei_by_year_type <- group_by(baltimore_nei, year, type)

#Calculate the total PM2.5 emissions for each year and each source type
baltimore_total_pm2.5_emissions_by_year_type<- summarise(
        baltimore_nei_by_year_type, totalEmissions = sum(Emissions))

# Plot using the ggplot2
# Save the plot in plot3.png
g <- ggplot(baltimore_total_pm2.5_emissions_by_year_type, 
            aes(year,totalEmissions))
g + geom_point(aes(color = type), size = 4) + facet_grid( . ~ type) + 
        geom_smooth(method = "lm")
ggsave(file='plot3.png')

# Alternate way of plotting in ggplot2 using qplot
#qplot(year, totalEmissions, data = baltimore_total_pm2.5_emissions_by_year_type
#      , geom = c("point", "smooth"), method = "lm",
#      facets = . ~ type, aes(color=year), 
#      labs(title = "PM2.5 Emissions in Baltimore for years 1999-2008 for each 
#           source type",y ="Total PM2.5 Emissions in tons"))
