plot2<- function(){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "pm25.zip", method = "curl")
        unzip("pm25.zip")
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        totbyyearbalt <- NEI[NEI$fips == "24510",]
        totbyyearbalt <- aggregate(Emissions ~ year, data = totbyyearbalt, sum)
        png("plot2.png")
        plot(totbyyearbalt$year, totbyyearbalt$Emissions, type = "o", 
             main = "Total PM2.5 Emissions by Year in Baltimore, Maryland", 
             xlab = "Year", ylab = "Total PM2.5 Emissions [Tons]", pch=19)
        dev.off()
}