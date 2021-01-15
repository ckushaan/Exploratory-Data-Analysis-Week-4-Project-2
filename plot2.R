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

# Plot2 - Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == “24510”) from 1999 to 2008? Use the base plotting system to make a plot answering this question.


baltdata <- NEI[NEI$fips=="24510", ]
baltYrEmm <- aggregate(Emissions ~ year, baltdata, sum)

mycolours <- c("red", "blue", "purple", "green")

png("plot2.png")

barplot(height=baltYrEmm$Emissions/1000,
        names.arg=baltYrEmm$year,
        xlab="Year",
        ylab=expression('Aggregated Emission'),
        main=expression('Baltimore Aggregated PM'[2.5]*' Emmissions by Year'),
        col = mycolours)

dev.off()

## clean the R environment
rm(list = ls())