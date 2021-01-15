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

# Plot1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.


ems <- aggregate(Emissions ~ year, NEI, sum)

mycolours <- c("red", "blue", "purple", "green")

png("plot1.png")

barplot(height=ems$Emissions/1000,
        names.arg=ems$year,
        xlab="Year",
        ylab=expression('Aggregated Emission'),
        main=expression('Aggregated PM'[2.5]*' Emmissions by Year'),
        col = mycolours)

dev.off()

## clean the R environment
rm(list = ls())