## Check for required packages and install them if necessary, then load them
if (!require("ggplot2")) {
	install.packages("ggplot2")}
library(ggplot2)

##Check if files exist in the folder "EDAasignement2" in default working directory, otherwise create the folder, download and unzip the dataset in folder dataset
if(!file.exists("./EDAassignement2")) {
	dir.create("./EDAassignement2")}
if(!file.exists("./EDAassignement2/exdata%2Fdata%2FNEI_data.zip")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
	download.file(fileUrl, destfile="EDAassignement2/exdata%2Fdata%2FNEI_data.zip")}
if(!file.exists(".EDAassignement2/dataset")) {
	unzip(zipfile="./EDAassignement2/exdata%2Fdata%2FNEI_data.zip", exdir="./EDAassignement2/dataset")}

##set working directory to dataset directory
wd <- getwd() ## store current directory path for reset it at the end of the script
setwd("./EDAassignement2/dataset")

##Then read and store the various files used for the assignement
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subsetting Baltimore and vehicle data
Baltimore <- subset(NEI, fips == "24510" & type=="ON-ROAD")
Baltimore <- aggregate(Baltimore[c("Emissions")], list(type = Baltimore$type, year = Baltimore$year, zip = Baltimore$fips), sum)

##Calling png function
png("./plot5.png")

##Plotting
qplot(year, Emissions, data = Baltimore, geom = c("point", "line"), ylab = "Total PM2.5 Emissions (ton)", xlab = "Year", main = "Total PM2.5 Emissions from vehicles in Baltimore per year")

##Closing png function
dev.off()

##restore default working directory
setwd(paste(wd))
