#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(dplyr)
library(gridExtra)
library(ggplot2)

onroad <- filter(SCC,Data.Category=="Onroad")
#nonroad may or may not be taken depending upon preference
nonroad <- filter(SCC,Data.Category=="Nonroad")
vehicles<-grep("Vehicles",nonroad$Short.Name)
tractors<-grep("Tractors",nonroad$Short.Name)

#SCC of all motor vehicles source
ID <-c(onroad$SCC,vehicles,tractors)

#SCC for ID row of SCC dataset
SCCID <-SCC[ID,]

#filter out data from NEI for baltimore and Los Angeles
target <- c("06037","24510")
data<-filter(NEI,fips %in% target)

#seperate data based on fips and year
filter_data<-tapply(data$Emissions,list(data$year,data$fips),sum)

#convert data to dataframe
dfdata <- as.data.frame(filter_data)

#add year column and rename column name
dfdata$year <- c("1999","2002","2005","2008")
names(dfdata) <- c("Los_Angeles","Baltimore","year")

png("plot6.png")

#range
rng <-range(dfdata$Los_Angeles,dfdata$Baltimore)

#plot
plot(dfdata$year,dfdata$Baltimore,pch=19,col="red",ylim = rng,xlab = "year",ylab="motor vechicle emission (in tons)",main = "Emission in Baltimore and Los Angeles ")

points(dfdata$year,dfdata$Los_Angeles,pch=8,col="blue")

legend("topright",c("Baltimore","Los Angeles"),pch=c(19,8),col=c("red","blue"))


dev.off()