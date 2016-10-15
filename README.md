# Getting and Cleaning Data Assignment

Pre-requisites for running the run_analysis.R script:

* User has extracted the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and unzipped it.
* User has set their working directory (using `setwd`) to the location of the unzipped directory.
* User had installed the `reshape2` package locally. This can be done by running `install.packages('reshape2')`.

The run_analysis.R script performs the following steps:

* Loads the features.txt file, extracting the values relating to mean and std.
* Tidies the values to that all non-alphanumeric characters are replaced with "." and the names are all lower-case.
* Loads the activity_labels.txt file, loading the activity names as factors.
* Loads the training and test files and combines them (note only the columns relating to mean and std are loaded from the X_train.txt and X_test.txt files).
* Merges the activity and combined training and test data into a single data table.
* Creates a tidy data set with the average of each variable for each activity and each subject.
* Writes the tidy data to file in txt format (an example of which is checked in as "tidy.data.txt"

