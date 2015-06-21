# CODE BOOK

**Purpose**: Describes the variables, the data, and the transformations used to clean up the data and arrive at the summary data contained in *tidyData.txt*

## Dataset

A full description of the data can be obtained from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file when unzipped creates a directory called **"UCI HAR Dataset"**.

The **"UCI HAR Dataset"** has two sub directories **train** and **test** which containt data for the test and train sets.

## R Code

*run_analysis.R* is the file containing the R code. The file is present in the **"UCI HAR Dataset"** directory


## Description of input data

- **activity_labels.txt** : description about different type of activities. 
- **features.txt** : names of features in the data sets. 

Train data set

- **X_train.txt** : information about features.
- **Y_train.txt** : information about activities.
- **subject_train.txt** : information about subjects.

Test data set

- **X_test.txt** : information about features. 
- **Y_test.txt** : information about activities. 
- **subject_test.txt** : information about subjects. 

## Transformations

The data variables used in the R program are marked in *italics*


Subject data is loaded into *trainSubjectData* (for train data) and *testSubjectData* (for test data).

Activity data is loaded into *trainActivityData* (for train data) and *testActivityData* (for test data).

Sensor data set is loaded into *trainData* (for train data) and *testData* (for test data).

Names of feature are loaded into *featureNames*.

*allSubjectData* contains the combined subject data for both train and test data set.  

*allActivityData* contains the combined activity data for both train and test data set.

*allData* contains the combined sensor data for both train and test data set.

*completeData* is all the data viz. Subject, Activity and Sensor data combined for both Test and Train set.

*colMeanStd* is the collection of all column names which have mean or std (standard deviation) in them.

*colMeanStdData* is the collection of "Subject", "Activity_No" and *colMeanStd*.

*dataMeanStd* is the subset of data set *completeData* containing columns which have "Subject", "Activity_No", "Mean" or "Std"  in the column name (ignoring case).


*tidyData* is the data set containing average of each variable for each activity and each subject. This is then saved to the text file **tidyData.txt** 












