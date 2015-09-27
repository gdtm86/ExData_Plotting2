
## Question - 4
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999-2008?

# load the needed packages
library(dplyr)
library(ggplot2)

# Read the datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Get the SCC code strings for the sources that fall into
# coal combustion-related sources category
scc_coal <- filter(scc, grepl("Coal", scc$Short.Name))
scc_caol_sourceCodes <- select(scc_coal,SCC)

## Filter the observations from nei such that only SCC codes related to coal
## combustion-related sources are included
nei_coal_source <- filter(nei, nei$SCC %in% scc_caol_sourceCodes$SCC)

# Group the dataset by year
nei_coal_source_by_year <- group_by(nei_coal_source, year)

#Calculate the total PM2.5 emissions for each year
total_pm2.5_emissions_from_coal_by_year<- summarise(
        nei_coal_source_by_year, totalEmissions = sum(Emissions))

# Plot using the ggplot2
# Save the plot in plot4.png
g <- ggplot(total_pm2.5_emissions_from_coal_by_year, 
            aes(year,totalEmissions))
g + geom_point() + geom_smooth(method = "lm") + 
        labs(title ="PM2.5 Emissions from Coal Combusion-related Sources 1999-2008") +
        labs( y = "Total PM2.5 Emissions in tons")

ggsave(file = "plot4.png")


