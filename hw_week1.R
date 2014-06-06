## Q1
setwd("~/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/getdata/")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "acs2006idaho.csv", method = "curl")
acs2006idago <- read.csv("acs2006idaho.csv", header = T)
table(acs2006idaho[, c("TYPE", "VAL")])


## Q3
#install.packages("xlsx")
library(xlsx)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
download.file(fileURL, destfile = "natgas_ap.xlsx", method = "curl")
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("natgas_ap.xlsx", 
                 sheetIndex = 1, 
                 header = TRUE, 
                 colIndex = colIndex, 
                 rowIndex = rowIndex)
sum(dat$Zip * dat$Ext, na.rm = TRUE)


## Q4
#install.packages("XML")
library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
acs2008idaho <- xmlTreeParse(fileURL, useInternal = TRUE)
rootNode <- xmlRoot(acs2008idaho)
table(xpathSApply(rootNode, "//zipcode", xmlValue))


## Q5
#install.packages("data.table")
library(data.table)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DT <- fread(fileURL, sep = ",")
names(DT)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
#system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT$pwgtp15,by=DT$SEX))
