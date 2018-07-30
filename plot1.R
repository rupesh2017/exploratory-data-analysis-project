#read the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset the data of emission
emission <-tapply(NEI$Emissions,NEI$year,sum)

year<-names(emission)

#plot
png(file="plot1.png")
plot(year,emission,pch=19,ylab="Total PM2.5 Emission (in tons)")
title(main="Total PM2.5 emission in US")
dev.off()

#yes the total emission  from PM2.5 decreased in the United States from 1999 to 2008
