#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
#find where coal source is available in data
nonpoint <- filter(SCC,Data.Category=="Nonpoint")
point <- filter(SCC,Data.Category=="Point")
a <- grep("Coal",point$SCC.Level.Three)
b <- grep("Coal",point$Short.Name)
d <- grep("Coal",point$EI.Sector)
e <- grep("Coal",point$SCC.Level.Four)
coalpoint <- c(a,b,d,e)

#subset the SCC data using the index
CID <- SCC[coalpoint,]

#intersect to get NEI data for analysis
CCS<-intersect(CID$SCC,NEI$SCC)

#subset NEI data using CCS
data <- NEI[NEI$SCC %in% CCS,]

#
temission <- tapply(data$Emissions,data$year,sum)
name<-names(temission)

png("plot4.png")

#plot
plot(name,temission,pch=19,xlab="Year",ylab="Total coal combusted source emission",main="Change in Coal Emission in America")

dev.off()

#emisssion have decreased over time