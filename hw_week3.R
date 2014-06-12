## Q1
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "acs2006idaho_microdata.csv")
acs <- read.csv("acs2006idaho_microdata.csv")
agricultureLogical <- ifelse(acs$ACR == 3 & acs$AGS == 6, TRUE, FALSE)
sum(agricultureLogical, na.rm = TRUE)
head(which(agricultureLogical), 3)

## Q2
#install.packages("jpeg")
library(jpeg)
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", 
              destfile = "getdata_jeff.jpeg")
jeffJpeg <- readJPEG("getdata_jeff.jpeg", native = TRUE)
quantile(jeffJpeg, c(0.3, 0.8))

## Q3
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp.csv")
gdp <- read.csv("gdp.csv", skip = 5, header = F)
keep = c(1, 2, 4, 5)
gdp <- gdp[keep]
names(gdp) <- c("code", "rank", "name", "gdp")
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "education.csv")
edu <- read.csv("education.csv")
df <- merge(gdp, edu, by.x = "code", by.y = "CountryCode")
# not done yet