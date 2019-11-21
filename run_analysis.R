## run_analysis.R that does the following:
##
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## This also uses the dplyr library


library(dplyr)

#Get the activity labels and features tables
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("code","functions"))

#Get the subject tables
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
#merge the subject tables together
mergedsubject <- rbind(subjecttrain, subjecttest)

#Get the x test and x train data
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
#merge the x tables together
mergedX <- rbind(xtrain, xtest)

#Get the y test and y train tables
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
#merge the y tables together
mergedY <- rbind(ytrain, ytest)

#Merge the subject, y and x tables together to make one data set
MergedSubjectXY <- cbind(mergedsubject, mergedX, mergedY)

#Extract only the measurements on the mean and standard deviation for each measurement
meanandstddata <- MergedSubjectXY %>% select(subject, code, contains("mean"), contains("std"))

meanandstddata$code <- activitylabels[meanandstddata$code, 2]

#Gives better descriptive and more detailed names to the variables
names(meanandstddata)[1] = "SubjectNumber"
names(meanandstddata)[2] = "Action"
names(meanandstddata)<-gsub("Acc", "Accelerometer", names(meanandstddata))
names(meanandstddata)<-gsub("BodyBody", "Body", names(meanandstddata))
names(meanandstddata)<-gsub("Gyro", "Gyroscope", names(meanandstddata))
names(meanandstddata)<-gsub("Mag", "Magnitude", names(meanandstddata))
names(meanandstddata)<-gsub("^f", "Frequency", names(meanandstddata))
names(meanandstddata)<-gsub("^t", "Time", names(meanandstddata))
names(meanandstddata)<-gsub("tBody", "TimeBody", names(meanandstddata))
names(meanandstddata)<-gsub("-freq()", "Frequency", names(meanandstddata), ignore.case = TRUE)
names(meanandstddata)<-gsub("-mean()", "Mean", names(meanandstddata), ignore.case = TRUE)
names(meanandstddata)<-gsub("-std()", "StandardDeviation", names(meanandstddata), ignore.case = TRUE)
names(meanandstddata)<-gsub("angle", "Angle", names(meanandstddata))
names(meanandstddata)<-gsub("gravity", "Gravity", names(meanandstddata))


#Average of each variable for each activity and each subject
averagevariable <- meanandstddata %>%
    group_by(SubjectNumber, Action) %>%
    summarise_all(funs(mean))