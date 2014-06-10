## Q1 (run in R base application)
#install.packages("httr")
library(httr)
#oauth_endpoints("github")
myapp <- oauth_app("github", key = <key>, secret = <secret>)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/users/jtleek/repos",
           config(token = github_token))
stop_for_status(req)
content(req)

## Q2
#install.packages("sqldf")
library(sqldf)
acs <- read.csv("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

## Q3
sqldf("select distinct AGEP from acs") == unique(acs$AGEP)

## Q4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

## Q5
report <- read.fwf("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
                   c(-1., 9, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3, -5, 4, -1, 3),
                   header = F,
                   skip = 4)
head(report)
sum(report[4])