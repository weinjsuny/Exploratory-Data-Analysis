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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?


library(ggplot2)

coalMatches  <- grep("coal", NEISCC$Short.Name, ignore.case=TRUE)

subsetNEISCC <- NEISCC[coalMatches, ]

data <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png('plot4.png')

g <- ggplot(data, aes(year, Emissions))

g <- g + geom_bar(stat="identity") +

xlab("year") +

ylab(expression('Total PM'[2.5]*" Emissions")) +

ggtitle('Total Emissions from coal sources from 1999 to 2008')

print(g)

dev.off()