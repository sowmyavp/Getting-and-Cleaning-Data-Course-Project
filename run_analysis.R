# Reading all the files into individual data tables
activitylabels <- read.table("activity_labels.txt", header = FALSE)
features <- read.table("features.txt")
subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
Xtrain <- read.table("train/X_train.txt", header = FALSE)
Ytrain <- read.table("train/y_train.txt", header = FALSE)
subjectTest <- read.table("test/subject_test.txt", header = FALSE)
Ytest <- read.table("test/y_test.txt", header = FALSE)
Xtest <- read.table("test/X_test.txt", header = FALSE)

# Mergng the training and the test sets to create one data set
subject_merged <- rbind(subjectTrain, subjectTest)
X_merged <- rbind(Xtrain, Xtest)
y_merged <- rbind(Ytrain, Ytest)
colnames(X_merged) <- t(features[2]) 
colnames(subject_merged) <- "Subject"
colnames(y_merged) <- "activity_id"
completedata <- cbind(X_merged, y_merged, subject_merged)

# Extracting only the measurements on the mean and standard deviation for each measurement
extracted_data <- completedata[grep(".*Mean.*|.*Std.*|Subject|activity_id", names(completedata), ignore.case=TRUE)]

# Using descriptive activity names to name the activities in the data set
colnames(activitylabels) <- c("activity_id", "activity")
extracted_data <-  merge(extracted_data, activitylabels, by = "activity_id", all = TRUE)
extracted_data <- extracted_data[, -1]

# Appropriately labeling the data set with descriptive variable names
names(extracted_data)<-gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data)<-gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data)<-gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data)<-gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data)<-gsub("^t", "Time", names(extracted_data))
names(extracted_data)<-gsub("^f", "Frequency", names(extracted_data))
names(extracted_data)<-gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data)<-gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-std()", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("angle", "Angle", names(extracted_data))
names(extracted_data)<-gsub("gravity", "Gravity", names(extracted_data))
names(extracted_data) <- gsub('activity', "Activity", names(extracted_data))

# creating a second, independent tidy data set with the average of each variable for each activity and each subject
install.packages("plyr")
library(plyr)
library(dplyr)
Tidy_data <- ddply(extracted_data, c("Subject","Activity"), numcolwise(mean))

# Reading tidy data into a text file
write.table(Tidy_data, file = "./Tidy_data.txt", row.names = FALSE)
