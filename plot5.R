plot5<- function(){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "pm25.zip", method = "curl")
        unzip("pm25.zip")
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        scc.veh <- SCC[grep("vehicle",SCC$SCC.Level.Two, ignore.case = TRUE),]
        nei.veh <- subset(NEI, NEI$SCC %in% scc.veh$SCC)
        nei.veh.balt<- nei.veh[nei.veh$fips=="24510",]
        nei.veh.balt.tot <- aggregate(Emissions ~ year, 
                                        data = nei.veh.balt, sum, na.rm = TRUE)
        png("plot5.png")
        plot(nei.veh.balt.tot$year, nei.veh.balt.tot$Emissions, type = "o", 
             pch= 19, main = "Annual PM2.5 Emissions from motor vehicle sources, Baltimore City", 
             xlab = "Year", ylab = "PM2.5 Emissions [Tons]")
        dev.off()
}