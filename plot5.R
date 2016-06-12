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

# merge two data sets
if(!exists("NEISCC")){
	NEISCC <- merge(NEI, SCC, by="SCC")
}

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)

subsetNEI <- subset(NEI, NEI$fips=="24510" & NEI$type=="ON-ROAD")

data <- aggregate(Emissions ~ year, subsetNEI, sum)

png('plot5.png')

g <- ggplot(data, aes(year, Emissions))

g <- g + geom_bar(stat="identity") +

xlab("year") +

ylab(expression('Total PM'[2.5]*" Emissions")) +

ggtitle('Total Emissions from motor vehicle ON-ROAD in Baltimore City, Maryland from 1999 to 2008')

print(g)

dev.off()