library(dplyr)
library(data.table)
library(tidyr)

# PART 1 Merges the training and the test sets to create one data set.

# Load Subject data
trainSubjectData <- tbl_df(read.table("train/subject_train.txt", header = FALSE))
testSubjectData  <- tbl_df(read.table("test/subject_test.txt", header = FALSE ))

# Load Activity data
trainActivityData <- tbl_df(read.table("train/Y_train.txt", header = FALSE))
testActivityData  <- tbl_df(read.table("test/Y_test.txt", header = FALSE))

# Load data
trainData <- tbl_df(read.table("train/X_train.txt", header = FALSE ))
testData  <- tbl_df(read.table("test/X_test.txt", header = FALSE ))

# Combine all the Subject data
allSubjectData <- bind_rows(trainSubjectData, testSubjectData)

# Combine all the activity data
allActivityData <- bind_rows(trainActivityData, testActivityData)

# Combine all the sensor data
allData <- bind_rows(trainData, testData)

# Load feature names
featureNames <- read.table("features.txt")

# Set the column names from the features file
colnames(allData) <- t(featureNames[2])

# Set the names of first and second column
colnames(allActivityData) <- "Activity_No"
colnames(allSubjectData) <- "Subject"

# Combine all the data 
completeData <- cbind(allSubjectData,allActivityData,allData)

# PART 2 Extracts only the measurements on the mean and standard deviation for each measurement.

# Filter those columns which have "mean" or "std" in their names 
colMeanStd <- grep("mean|std", featureNames$V2, ignore.case=TRUE, value=TRUE)

# PART 3 Add descriptive activity names to name the activities in the data set
# Add "Subject" and "Activity_No" to the above column filter
colMeanStdData <- union(c("Subject","Activity_No"),colMeanStd)


dataMeanStd <- subset(completeData,select=colMeanStdData) 


activityLabels <- tbl_df(read.table("activity_labels.txt", header=FALSE))

colnames(activityLabels) <- c("Activity_No", "Activity")

dataMeanStd <- merge(activityLabels, dataMeanStd , by="Activity_No", all.x=TRUE)

dataMeanStd$Activity <- as.character(dataMeanStd$Activity)

# PART 4 add descriptive variable names to the column labels

names(dataMeanStd)<-gsub("Acc", "Accelerometer", names(dataMeanStd))
names(dataMeanStd)<-gsub("Gyro", "Gyroscope", names(dataMeanStd))
names(dataMeanStd)<-gsub("BodyBody", "Body", names(dataMeanStd))
names(dataMeanStd)<-gsub("Mag", "Magnitude", names(dataMeanStd))
names(dataMeanStd)<-gsub("^t", "Time", names(dataMeanStd))
names(dataMeanStd)<-gsub("^f", "Frequency", names(dataMeanStd))
names(dataMeanStd)<-gsub("tBody", "TimeBody", names(dataMeanStd))
names(dataMeanStd)<-gsub("-mean()", "Mean", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("-std()", "STD", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("freq()", "Frequency", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("angle", "Angle", names(dataMeanStd))
names(dataMeanStd)<-gsub("gravity", "Gravity", names(dataMeanStd))

# PART 5 Create a second, independent tidy data set with the average of each variable for each activity and each subject.

dataMeanStd$Activity <- as.factor(dataMeanStd$Activity)
dataMeanStd$Subject  <- as.factor(dataMeanStd$Subject)


tidyData <- aggregate(. ~Subject + Activity, dataMeanStd, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)



