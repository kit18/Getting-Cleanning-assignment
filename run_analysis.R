# Getting and cleanning data - course project

# Download the data

if(!file.exists(".data")){
        dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", method = "curl")

# unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#list.files("./data/UCI HAR Dataset") and change working directory to simplify the code.
setwd("./data/UCI HAR Dataset")

# Read the data from the test and training folder # list.files("./test")
x_test = read.table("test/x_test.txt")
y_test = read.table("test/y_test.txt")
subject_test = read.table("test/subject_test.txt")

x_train = read.table("train/x_train.txt")
y_train = read.table("train/y_train.txt")
subject_train = read.table("train/subject_train.txt")

# Merges the training and test sets to create one data set

data_x = rbind(x_train,x_test)
data_y = rbind(y_train,y_test)
data_subject = rbind(subject_train,subject_test)

# Renames the variables
names(data_subject) = c("subject")
names(data_y) = c("activity")
features_names = read.table("features.txt")
names(data_x) = features_names$V2
alldata = cbind(data_subject,data_y,data_x)

# Extract the measurements on the mean and standard deviation for each measurement
# get the columns with mean() or std() in their names
features_names_meanorstd = features_names$V2[grep("mean\\(\\)|std\\(\\)",features_names$V2)]
variables_extract = c("subject","activity",as.character(features_names_meanorstd))
alldata = subset(alldata,select=variables_extract)

# Uses descriptive activity names to name the activities in the data set
activity_labels = read.table("activity_labels.txt")

alldata[,2] = activity_labels[alldata[,2],2]

# Appropriately labels the data set with descriptive variable names.
names(alldata) = gsub("^t","time", names(alldata))
names(alldata) = gsub("^f","frequency", names(alldata))
names(alldata) = gsub("Acc","Accelerometer", names(alldata))
names(alldata) = gsub("Gyro","Gyroscope", names(alldata))
names(alldata) = gsub("Mag","Magnitude", names(alldata))
names(alldata) = gsub("BodyBody","Body", names(alldata))

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
finaldata = aggregate(.~subject + activity, alldata, mean)
finaldata = finaldata[order(finaldata$subject),]
write.table(finaldata,file="tidydata.txt",row.name=FALSE)

