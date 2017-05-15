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

##Subsetting data with coal data from SCC file and merge with NEI file
CoalData  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
CoalData  <- SCC[CoalData, ]
MergeData <- merge(NEI, CoalData , by="SCC")

##Summing the total emissions per year
TotalEmissions <- tapply(MergeData$Emissions, MergeData$year, sum)

##Calling png function
png("./plot4.png")

##Plotting
plot(TotalEmissions, type = "o", main = "US Total emissions from coal sources per year ", xlab = "Year", ylab = "Total Emissions (ton)", pch = 19, col = "red", lty = 6)

##Closing png function
dev.off()

##restore default working directory
setwd(paste(wd))
