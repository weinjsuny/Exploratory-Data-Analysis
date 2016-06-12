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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
# vehicle sources in Los Angeles County, California (fips == "06037")
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

subsetNEI <- subset(NEI, (NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD")

data <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
data$fips[data$fips=="24510"] <- "Baltimore, MD"
data$fips[data$fips=="06037"] <- "Los Angeles, CA"


png('plot6.png', width = 1040, height=480)

g <- ggplot(data, aes(year, Emissions))

g<- g + facet_grid(. ~ fips)

g <- g + geom_bar(stat="identity") +

xlab("year") +

ylab(expression('Total PM'[2.5]*" Emissions")) +

ggtitle('Total Emissions from motor vehicle ON-ROAD in Baltimore City vs Los Angeles 1999-2008')

print(g)

dev.off()