# Getting-and-Cleaning-Data-Course-Project

This is the guide to explain how my implementation of run_analysis.R should be used to generate a tidy data set as required by the "Getting and Cleaning Data Course" Project.

## Raw Data
The raw data that must be used can be accessed at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You must unzip the raw data file in your R working directory. Note: do not change the directories where the different txt files are located. If you do so, my implamentation of run_analysis.R will not be able to locate the appropriated txt files in order to generate the correspondent tidy data set.

## Generating the tidy data set
You must copy the contents of the file run_analysis.R available in this repo and past it into RStudio or R Shell. I used R version 3.1.3 to develop my implementation of run_analysis.R

## The code book
The CodeBook.md file available in this repo provides the description of the variables, data, and transformations performed to clean up the raw data.

## The Pseudocode to change the raw data into the tidy data set
1. Read all necessary files[A] to create correspondent data sets
2. Rename columns of the data frames in order to appropriately labels the data sets with descriptive variable names[B]
3. Replace activities numbes by descriptive activity names[C]
4. Create ID column for the data frames
5. Merge train data frames by their ID's
6. Merge test data frames by their ID's
7. Merge the resulting data frames of steps 5 and 6
8. Extracts mean values for each measurement
9. Extracts standard deviation values for each measurement
10. Melt the data frames generated on steps 8 and 9 using as ID's the variables names 'ID','activity_labels' and 'subject' and as measure.vars the remaining variable names.
11. Create a data set with the average of each variable for each activity and each subject

[A]:train/X_train.txt, train/y_train.txt, train/subject_train.txt, test/X_test.txt,test/y_test.txt, features.txt, activity_labels.txt  
[2]:names for the variableas were extracted from features.txt, except for 'ID', 'activity_labels' and 'subject'  
[3]:WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING
