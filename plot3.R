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

# Plot3 - Of the four types of sources indicated by the \color{red}{\verb|type|}type
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases
# in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

baltdata <- NEI[NEI$fips=="24510", ]
baltdata2 <- aggregate(Emissions ~ year+ type, baltdata, sum)


png("plot3.png", width = 1000, height = 700)

plot3 <- ggplot(data = baltdata2, aes(x = factor(year), y = Emissions, fill = type, colore = "black")) +
    geom_bar(stat = "identity") + facet_grid(. ~ type) + 
    xlab("Year") + ylab(expression('PM'[2.5]*' Emission')) +
    ggtitle("Baltimore Emissions by Source Type") 
print(plot3)

dev.off()

## clean the R environment
rm(list = ls())