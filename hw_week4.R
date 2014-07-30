## Q1
# load acs dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "acs2006idaho_microdata.csv")
acs <- read.csv("acs2006idaho_microdata.csv")
names(acs)
strsplit(names(acs), split = "wgtp")[[123]]


## Q2
library(stringr)
# load gdp dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp.csv")
# read only first 190 entries (actual country data) and relevant columns
gdp <- read.csv("gdp.csv", header = FALSE, 
                skip = 5, na.strings = c("", ".."))[1:190, c(1, 2, 4, 5)]
names(gdp) <- c("code", "rank", "name", "gdp")
head(gdp)
gdp$gdp <- as.numeric(str_trim(gsub(",", "", gdp$gdp)))
mean(gdp$gdp, na.rm = TRUE)


## Q3
grep("United$", gdp$name)
grep("^United", gdp$name)
grep("*United", gdp$name)


## Q4
# load gdp dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp.csv")
# read only first 190 entries (actual country data) and relevant columns
gdp <- read.csv("gdp.csv", header = FALSE, 
                skip = 5, na.strings = c("", ".."))[1:190, c(1, 2, 4, 5)]
names(gdp) <- c("code", "rank", "name", "gdp")

# load education dataset
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "education.csv")
edu <- read.csv("education.csv", stringsAsFactors = FALSE)

# merge two data frames
data <- merge(gdp, edu, by.x = "code", by.y = "CountryCode")

length(grep("^Fiscal year end: June", data$Special.Notes))


## Q5
#install.packages("lubridate")
#install.packages("quantmod")
library(lubridate)
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn) 

# convert temporal data to dates
sampleTimes <- as.Date(as.character(sampleTimes), "%Y-%m-%d")

sum(year(sampleTimes) == 2012)
sum(year(sampleTimes) == 2012 & wday(sampleTimes) == 2)