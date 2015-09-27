setwd("E:\\3_DATA SCIENCE SPECIALISATION\\GETTING AND CLEANING DATA\\Assignments\\Week3")

#### File Download #####
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = url , destfile="./wearable.zip")

### Unzipping Files and storing in a folder "wearable ####


source(run_analysis.R)
