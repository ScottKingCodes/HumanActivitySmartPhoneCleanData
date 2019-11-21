# Code Book File - Scott King

The run_analysis.R script cleans the data and prepares it using the following 5 steps:

1. Load in all of the data

For this first step, I downloaded the files directly to my computer from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I set up my work space accordingly and the data contained in the UCI HAR Dataset

2. Read in the specific data and assign it to the assigned variables

activitylabels for the activity_labels.txt
features for the features.txt
subjecttrain for the subject_train.txt
subjecttest for the subject_test.txt
xtrain for the x_train.txt
xtest for the x_test.txt
ytrain for the y_train.txt
ytest for the y_test.txt

3. Merge the training and test set in subject, X, and Y to create one data set

To start, I made 3 separate tables:

I merged the subjecttrain and the subjecttest
I merged the xtrain and the xtest
I merged the ytrain and the ytest

Then I merged these three tables into 

MergedSubjectXY

4.  Extracted only the measurements on the mean and standard deviation for each measurement and stored it in the variable 

meanandstddata

5. Gave better descriptive and more detailed names to the variables such as

subject became SubjectNumber
code became Action
All variables that started with f replaced with Frequency
All variables that started with t replaced with Time
acc became Accelerometer
BodyBody became Body
Mag became Magnitude
Gyro became Gyroscope

6. From the data set above, I created a second, independent data set with the average of each variable for each activity and each subject and stored it in

averagevariable
