#read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
#filter data for baltimore city 
Baltimore <-NEI %>% filter(fips=="24510")
emission <- tapply(Baltimore$Emissions,Baltimore$year,sum)
year<-names(emission)

#plot
png(file="plot2.png")
plot(year,emission,pch=19,main="Emission in Baltimore",ylab="total emission(in tons)")
dev.off()

#yes there was decrease in emission in Baltimore city 