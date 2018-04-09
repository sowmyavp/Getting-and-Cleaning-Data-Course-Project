# Getting-and-Cleaning-Data-Course-Project

**The purpose of this project** is to demonstrate your how to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

**Raw data for the project** was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**The script run_analysis.R performs the following process to clean up the data and create tidy data set:**
1. Read all the files into individual data tables.
2. Merged the training and the test sets to create one data set.
3. Extracted only the measurements on the mean and standard deviation for each measurement.
4. Used descriptive activity names to name the activities in the data set
5. Appropriately labeled the data set with descriptive variable names.
6. From the data set in step 4, createed a second, independent tidy data set with the average of each variable for each activity and each subject.

Final tidy data set is stored as **Tidy_data.txt**
