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

##Subsetting data
baltimore <- subset(NEI, fips == "24510")

##Summing emission data from Baltimore per year
TotalEmissions <- tapply(baltimore$Emissions, baltimore$year, sum)

##Calling png function
png("./plot2.png")

##Plotting
plot(TotalEmissions, type = "o", main = "Total PM2.5 Emissions per Year in Baltimore", xlab = "Year", ylab = "PM2.5 Emissions at Baltimore(ton)", pch = 19, col = "green", lty = 6)

##Closing png function
dev.off()

##restore default working directory
setwd(paste(wd))
