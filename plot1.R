plot1<- function(){
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "pm25.zip", method = "curl")
unzip("pm25.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
totbyyear <- aggregate(Emissions ~ year, data = NEI, sum)
png("plot1.png")
plot(totbyyear$year, totbyyear$Emissions, type = "o",
     main = "Total PM2.5 Emission by Year", xlab = "Year",
     ylab = "Total PM2.5 Emissions [Tons]", pch=19)
dev.off()
}