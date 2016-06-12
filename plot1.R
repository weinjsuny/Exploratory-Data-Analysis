

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

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 

# for each of the years 1999, 2002, 2005, and 2008.




data <- aggregate(Emissions ~ year, NEI, sum))




png('plot1.png')

barplot(data$Emissions, names.arg=data$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

dev.off()
