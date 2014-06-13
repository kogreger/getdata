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
# load gdp dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp.csv")
gdp <- read.csv("gdp.csv", skip = 5, header = F)
#remove unnecessary columns
keep = c(1, 2, 4, 5)
gdp <- gdp[keep]
# provide meaningful column names
names(gdp) <- c("code", "rank", "name", "gdp")
# remove rows with non-numeric rank (remove factor first)
gdp$rank <- as.character(gdp$rank)
gdp <- gdp[grep("^([0-9]+)$", gdp$rank), ]
gdp$rank <- as.numeric(gdp$rank)

# load education dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "education.csv")
edu <- read.csv("education.csv")

#merge two data frames
df <- merge(gdp, edu, by.x = "code", by.y = "CountryCode")
nrow(df)

#sort resulting data frame
library(plyr)
df <- arrange(df, desc(rank))
df[13, c("rank", "name")]
tail(df, 2)


## Q4
tapply(df$rank, df$Income.Group, mean)


## Q5
#install.packages("Hmisc")
library(Hmisc)
df$group <- cut2(df$rank, g = 5)
xtabs( ~ group + Income.Group, data = df)