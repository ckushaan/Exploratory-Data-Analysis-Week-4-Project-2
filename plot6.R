## load libraries
library(dplyr)
library(ggplot2)

# download data and unzip the file to local dir if it doesn't exists

if (!file.exists("FNEI_data.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.zip")
}

if (!file.exists("summarySCC_PM25.rds") &
    !file.exists("dSource_Classification_Code.rds")) {
    unzip("FNEI_data.zip")
}

# read files and assign to an object
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

baltFips <- summarise(group_by(filter(NEI, NEI$fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
laFips <- summarise(group_by(filter(NEI, NEI$fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltFips$County <- "Baltimore City, MD"
laFips$County <- "Los Angeles County, CA"

baltLaEmissions <- rbind(baltFips, laFips)


png("plot6.png")

plot6 <- ggplot(baltLaEmissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
    geom_bar(stat="identity") + 
    facet_grid(.~County) +
    ylab(expression("total PM"[2.5]*" emissions in tons")) + 
    xlab("year") +
    ggtitle(expression("Baltimore City vs Los Angeles County Motor vehicle emission in tons"))+
    geom_label(aes(fill = County),colour = "white", fontface = "bold")

print(plot6)

dev.off()

## clean the R environment
rm(list = ls())