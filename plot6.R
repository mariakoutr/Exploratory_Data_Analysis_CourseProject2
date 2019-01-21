plot6<- function(){
        library(ggplot2)
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
        nei.veh.cal <- nei.veh[nei.veh$fips== "06037",]
        nei.veh.cal.tot <- aggregate(Emissions ~ year, data = nei.veh.cal, 
                                       sum, na.rm = TRUE)
        veh.tot.2<-rbind(nei.veh.balt.tot, nei.veh.cal.tot)
        city <- c(rep("Baltimore",4),rep("Los Angeles",4))
        veh.tot.2<-cbind(veh.tot.2,city)
        png("plot6.png")
        gg <- ggplot(veh.tot.2, aes(x=year, y= Emissions, color = city))
        gg<- gg+ geom_point() + geom_line() + 
                labs(title = "Total Annual PM2.5 Emissionsin Baltimore City, 
                     Maryland and Los Angeles county, Clifornia", x= "Year", 
                     y= "Total PM2.5 Emissions [Tons]")
        print(gg)
        dev.off()
}