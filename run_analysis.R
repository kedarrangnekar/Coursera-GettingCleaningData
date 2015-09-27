library(plyr)
library(dplyr)
library(reshape2)

setwd("E:\\3_DATA SCIENCE SPECIALISATION\\GETTING AND CLEANING DATA\\Assignments\\Week3\\wearable")

#### File Download ####
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = url , destfile="E:/3_DATA SCIENCE SPECIALISATION/GETTING AND CLEANING DATA/Assignments/Week3/wearable.zip")

#### File Loading ####

#### Traning DataSet #####

activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep ="\t")
activity_train$id <-  rownames(activity_train)
activity_train <- rename(activity_train, activity=V1)


subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep ="\t")
subject_train$id <-  rownames(subject_train)
subject_train <- rename(subject_train, subject=V1)


data_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "")
data_train$id <-  rownames(data_train)


train_dflist <- list(subject_train,activity_train,data_train)
merged_train <- join_all(train_dflist)

merged_train$dataset <- "training"

#### Test DataSet ####

activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep ="\t")
activity_test$id <-  rownames(activity_test)
activity_test <- rename(activity_test, activity=V1)


subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep ="\t")
subject_test$id <-  rownames(subject_test)
subject_test <- rename(subject_test, subject=V1)

data_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep ="")
data_test$id <-  rownames(data_test)


tst_dflist <- list(subject_test,activity_test,data_test)
merged_test <- join_all(tst_dflist)

merged_test$dataset <- "test"

#### Merging Training and Test Datasets ####

merged_data <- rbind(merged_train,merged_test)

#### FeatureNames Data ####

features_data <- read.table("./UCI HAR Dataset/features.txt", sep = "", colClasses = c("character"), col.names = c("varno","varname"))

#### Assigning column names to data ####
features <-  features_data[,2]

features <- t(features)

features <- cbind("subject","id","activity", features,"dataset")

colnames(merged_data) <- features

#### Identifying column indices of means and standard deviations ####
meancol <- grep("mean()",colnames(merged_data),fixed = TRUE, value = FALSE)
stdcol <- grep("std()",colnames(merged_data),fixed = TRUE, value = FALSE)
basecol <- c(1,2,3,565)

#### New DataSet with selected (mean,std) columns
data <- merged_data[,c(basecol,meancol,stdcol)]
colnames(data)
#### Loading Activity Labels Master #### 
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep ="", col.names = c("actid", "activity_name"), colClasses = c("character"))

#### Merging Data with Activity Master ####
data <- merge(data,actlabels,by.x = "activity",by.y = "actid", all.x = TRUE)
str(data)
#### Reordering the columns ####
data <- data[,c(3,2,1,71,4,5:70)]
data$subject <- as.character(data$subject)
data$activity <- as.character(data$activity)


#### Melting DataSet ####

dataMelt <- melt(data,id=c("id","subject","activity_name"), measure.vars = c(6:71))
head(dataMelt)

#### Recasting DataSet into Tidy-Data ####
TidyData <- dcast(dataMelt,subject+activity_name~variable,mean)
