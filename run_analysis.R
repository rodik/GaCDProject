## Main script
library(plyr)
library(stats)

# load all data files 
x_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",header=FALSE)
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
x_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",header=FALSE)
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
activity_labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",header=FALSE)
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",header=FALSE)

# Merge train and test data frames
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

# set column names on lookup tables
colnames(features) <- c("FeatureID","FeatureName")
colnames(activity_labels) <- c("ActivityID","ActivityName")
colnames(y_merged) <- c("ActivityID")
colnames(subject_merged) <- c("subject")

# find only mean and std features
pat <- "*(mean|std)\\(\\)*"
msFeats <- grep(pat,features$FeatureName,value=FALSE)

# create data set with filtered columns
tidy <- x_merged[,msFeats]
# set column names to feature names
colnames(tidy) <- as.character(features[msFeats,"FeatureName"])

# add columns to tidy dataset
tidy$subject <- subject_merged
tidy$activity <- join(y_merged, activity_labels,type="inner")[,"ActivityName"]

#return tidy dataset
tidy[,c(67,68,1:66)]