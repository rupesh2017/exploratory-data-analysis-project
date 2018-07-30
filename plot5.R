#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

onroad <- filter(SCC,Data.Category=="Onroad")
#nonroad may or may not be taken depending upon preference
nonroad <- filter(SCC,Data.Category=="Nonroad")
vehicles<-grep("Vehicles",nonroad$Short.Name)
tractors<-grep("Tractors",nonroad$Short.Name)

#SCC of all motor vehicles source
ID <-c(onroad$SCC,vehicles,tractors)

#SCC for ID row of SCC dataset
SCCID <-SCC[ID,]

#filter out data from NEI for baltimore city
baltimore <- filter(NEI,fips=="24510")

#intersect SCC to compute on these source only
vechicle_source<-intersect(SCCID$SCC,NEI$SCC)

#subset those vechicle source Id from NEI for ploting
mvs<-NEI[NEI$SCC %in% vechicle_source,]

emission<-tapply(mvs$Emissions,mvs$year,sum)
name <- names(emission)

png("plot5.png")
#plot between 
plot(name,emission,pch=19,xlab="year",main="Emissions from motor vehicle sources in Baltimore")

dev.off()




