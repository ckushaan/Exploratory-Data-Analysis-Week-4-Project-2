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

# Plot5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

baltdata <- NEI[NEI$fips=="24510", ]
baltdata2 <- aggregate(Emissions ~ year+ type, baltdata, sum)


png("plot5.png")

plot5 <- ggplot(baltdata2, aes(factor(year), Emissions))
plot5 <- plot5 + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total Emissions')) +
    ggtitle('Baltimore Motor Vehicle PM[2.5] Emissions From 1999 to 2008')

print(plot5)

dev.off()

## clean the R environment
rm(list = ls())