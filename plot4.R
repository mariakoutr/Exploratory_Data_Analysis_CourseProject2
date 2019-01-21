plot4<- function(){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "pm25.zip", method = "curl")
        unzip("pm25.zip")
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
                scc.coal.comb <- SCC[grep("[Cc]oal", SCC$EI.Sector),]
        nei.coal <- subset(NEI, NEI$SCC %in% scc.coal.comb$SCC)
        nei.coal.tot <- aggregate(Emissions ~ year, data = nei.coal,sum, na.rm = TRUE )
        png("plot4.png")
        plot(nei.coal.tot$year, nei.coal.tot$Emissions, type = "o", pch = 19, 
             main = "Total emissions from coal combustion-related sources in US", 
             xlab = "Year", ylab = "PM2.5 Emissions [Tons]")
        dev.off()
}