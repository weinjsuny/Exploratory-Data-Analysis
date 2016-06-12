setwd("/Users/junwen/Documents/Coursera/Data Sciences/Exploratory Data Analysis")

if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/projectData.zip")
unzip("./data/projectData.zip", exdir = "./data")

if(!exists("NEI")){

  NEI <- readRDS("./data/summarySCC_PM25.rds")

}

if(!exists("SCC")){

  SCC <- readRDS("./data/Source_Classification_Code.rds")

}

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City?
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

subNEI <- subset(NEI, NEI$fips == "24510")

data <- aggregate(Emissions ~ year + type, subNEI, sum)


png('plot3.png')

g <- ggplot(data, aes(year, Emissions, color = type))

g <- g + geom_line() +

xlab("year") +

ylab(expression('Total PM'[2.5]*" Emissions")) +

ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')

print(g)

dev.off()