#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(gridExtra)
#filter Baltimore city data
Baltimore <-NEI %>% filter(fips=="24510")
temission<-tapply(Baltimore$Emissions,list(Baltimore$year,Baltimore$type),sum)
temission <- as.data.frame(temission)
temission$Year <- c("1999","2002","2005","2008")
names(temission)<- make.names(names(temission))

#plot
png("plot3.png")
a<-qplot(year,NON.ROAD,data=temission)
b<-qplot(year,NONPOINT,data=temission)
c<-qplot(year,ON.ROAD,data=temission)
d<-qplot(year,POINT,data=temission)
grid.arrange(a,b,c,d,top="Emission from 4 source of Baltimore")
dev.off()

#there was increase in emission from point source in Baltimore city