## Question - 5
## How have the emissions from motor vehicle sources changed from 1999-2008
## in Baltimore City?

# load the needed packages
library(dplyr)
library(ggplot2)

# Read the datasets
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# filter the dataset to only include the observations for
# Baltimore City, Maryland (fips = "24510") 
baltimore_nei <- filter(nei, fips == '24510')

# Get the SCC code strings for the sources that fall into
# motor vehicle sources category
scc_motor <- filter(scc, grepl("Motor", scc$Short.Name))
scc_motor_sourceCodes <- select(scc_motor,SCC)

## Filter the observations from baltimore_nei such that only SCC codes related 
## to motor vehicle sources are included
baltimore_nei_motor <- filter(baltimore_nei, baltimore_nei$SCC 
                              %in% scc_motor_sourceCodes$SCC)

# Group the dataset by year
baltimore_nei_motor_by_year <- group_by(baltimore_nei_motor, year)

#Calculate the total PM2.5 emissions for each year
baltimore_nei_motor_emissions_by_year<- summarise(
        baltimore_nei_motor_by_year, totalEmissions = sum(Emissions))

# Plot using the ggplot2
# Save the plot in plot5.png
g <- ggplot(baltimore_nei_motor_emissions_by_year, 
            aes(year,totalEmissions))
g + geom_point() + geom_smooth(method = "lm") +
        labs(title ="Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City during 1999-2008") +
        labs( y = "Total PM2.5 Emissions in tons")

ggsave(file = "plot5.png")


