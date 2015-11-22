---
title: "Getting and Cleaning Data Course Project"
author: "Kit"

---

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

##Study design and data processing
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

R script called run_analysis.R will process the data in 5 steps. 
1. Get the data, and then merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Collection of the raw data
Description of how the data was collected.

Download the file using below command.

if(!file.exists(".data")){
        dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", method = "curl")

Unzip the file afterwards.

##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file 

#### Step 1: Get the data, and then merges the training and the test sets to create one data set.

Download the file through R, using rbin and cbin to merges the file. 
Renames the variable according to the provided documents "feature.txt"

#### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

"Scan" through the entire "feature.txt" file and left only the variable name contained "mean" & "std"
Prepare a list of the pre-selected features' colunmn names to subset the entire data frame. 

#### Step 3: Uses descriptive activity names to name the activities in the data set

Adopt the activity_label.txt and renames the corresponding part of the data set.

#### Step 4: Appropriately labels the data set with descriptive variable names. 

Rename/labels the data set with the aids of gsub function.

#### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Apply library(plyr); and then aggregate the data and calculate the means according to the subject and activity. 
Using "order" funtion to make the data more visible. 


