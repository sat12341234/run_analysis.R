library (data.table)
library(dplyr)

#Set working directory
getwd()
setwd("/_Training/_Coursera/DataScience/3-Getting and Cleaning Data/Week4/Assignment")

#Download dataset for assignment
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datafile <- "dataset.zip"
download.file(url, datafile)

#I manually unzipped the data in the above folder

#read features so we can use it in column names for other data
features <- read.table("./UCI HAR Dataset/features.txt")
# assign proper column names
names(features) <- c('feature_id', 'feature_name')
str(features)

# Read subject_test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read X Data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names=features[,2])
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names=file_features[,2])

# Read y Data
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names="activity")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names="activity")

# Read subject Data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Combine train and test data
x_combined <- rbind(x_train, x_test)
str(x_combined)
y_combined <- rbind(y_train, y_test)
str(y_combined)
subject_combined <- rbind(subject_train, subject_test)
str(subject_combined)
names(subject_combined) <- "Subject"
str(subject_combined)

# Read activities.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
#changes to proper column names
names(activity_labels) <- c('activity_id', 'activity_name')
str(activity_labels)

str(y_combined)
for (i in 1:nrow(activity_labels)) {
  code <- as.numeric(activity_labels[i, 1])
  name <- as.character(activity_labels[i, 2])
  y_combined[y_combined$activity == code, ] <- name
}
str(y_combined)

#select columns with mean and std in their name
filtered_features <- grep("?mean\\()*|?std\\()?", features$feature_name)
filtered_features
length(filtered_features)

x_filtered <- x_combined[, filtered_features]
str(x_filtered)

x_combined_activities <- cbind(y_combined, x_combined)
mean_std_activities <- cbind(y_combined, x_filtered)
str(x_combined_activities)
str(mean_std_activities)

#calculate the average of each variable for each activity and each subject
average_values <- aggregate(x_combined,list(activity=y_combined[,1], subject=subject_combined[,1]), mean)
str(average_values)
length(x_combined)
length(average_values)

# wrtie the data to the directory.
write.table(average_values, "UCI-HAR-dataset-AVG-tidy.txt", row.name=FALSE)

# I am not sure if we only want to save only average data in tify dataset. 
# Combine by column now for tidy data
#tidyData <- cbind(subject_combined, y_combined, x_combined)
#str(tidyData)

