plot3<- function(){
        library(ggplot2)
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "pm25.zip", method = "curl")
        unzip("pm25.zip")
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        totbyyearbalt <- NEI[NEI$fips == "24510",]
        totbyyearbalt2 <- aggregate(Emissions ~ year+type, 
                                    data = totbyyearbalt, sum, na.rm =TRUE)
        png("plot3.png")
        g<- qplot(year, Emissions, data = totbyyearbalt2, facets = .~type)
        g<- g+ xlab("Year") + ylab("Total PM2.5 Emissions [Tons]") + 
                ggtitle("Total Annual PM2.5 Emissions in Baltimore, Maryland by type")
        print(g)
        dev.off()
}
        