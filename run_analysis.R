#########################################################################################
## Getting and Cleaning Data Course Project
## run_analysis.R
#########################################################################################
## Create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.
#########################################################################################

# Install "plyr" and "data.table" packages if necessary
if (!require("plyr")) {
    install.packages("plyr")
}

if (!require("data.table")) {
    install.packages("data.table")
}

require("plyr")
require("data.table")

# Setup location for directories and files
empty_separator <- ""
uci_har_dataset_directory <- "UCI\ HAR\ Dataset"

features_file <- paste(uci_har_dataset_directory, "/features.txt", sep = empty_separator)
activity_labels_file <- paste(uci_har_dataset_directory, "/activity_labels.txt", sep = empty_separator)

x_train_file <- paste(uci_har_dataset_directory, "/train/X_train.txt", sep = empty_separator)
y_train_file <- paste(uci_har_dataset_directory, "/train/y_train.txt", sep = empty_separator)
subject_train_file <- paste(uci_har_dataset_directory, "/train/subject_train.txt", sep = empty_separator)

x_test_file  <- paste(uci_har_dataset_directory, "/test/X_test.txt", sep = empty_separator)
y_test_file  <- paste(uci_har_dataset_directory, "/test/y_test.txt", sep = empty_separator)
subject_test_file <- paste(uci_har_dataset_directory, "/test/subject_test.txt", sep = empty_separator)

final_output_file <- "sensor_averages_by_subject_activity.txt"

# Load data column names
features <- read.table(features_file)

# Load activity labels
activities <- read.table(activity_labels_file)

# Load X_train, y_train and subject_train raw data
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)

# Load X_test, y_test and subject_test raw data
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

#########################################################################################
## STEP 1. Merge the training and the test sets to create one data set.
#########################################################################################
# Merge X_train and X_test data sets and create one 'x' data set
x_dataset <- rbind(x_train, x_test)

# Merge y_train and y_test data sts and create one 'y' data set
y_dataset <- rbind(y_train, y_test)

# Merge subject_train and subject_test data sts and create one 'subject' data set
subject_dataset <- rbind(subject_train, subject_test)

#########################################################################################
## STEP 2. Extract only the measurements on the mean and standard deviation for each measurement.
#########################################################################################
# Extract the only columns (measurements) that has mean() or std() in their column 
# names (measurements) for each measurement
features_mean_or_std <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_dataset <- x_dataset[, features_mean_or_std]

#########################################################################################
## STEP 3. Uses descriptive activity names to name the activities in the data set.
#########################################################################################
# update the values with correct activity names
y_dataset[, 1] <- activities[y_dataset[, 1], 2]

#########################################################################################
## STEP 4. Appropriately labels the data set with descriptive variable names.
#########################################################################################
# appropriately label the 'x' data set with correct the column names
names(x_dataset) <- features[features_mean_or_std, 2]

# appropriately label the 'y' data set with descriptive column name
names(y_dataset) <- "activity"

# appropriately label the 'subject' data set with descriptive column name 
names(subject_dataset) <- "subject"

# bind 'x' data set, 'y' data set and 'subject' data set in a single data set
single_dataset <- cbind(x_dataset, y_dataset, subject_dataset)

#########################################################################################
## STEP 5. From the data set in step 4, create a second, independent tidy data set with the 
##         average of each variable for each activity and each subject.
#########################################################################################
# apply mean function to the single dataset that has been created in step 4 with the average 
# of each variable for each activity and each subject.
averages_data_by_subject_activity <- ddply(single_dataset, .(subject, activity), function(x) colMeans(x[, 1:66]))

# write the data set to a file named "sensor_averages_by_subject_activity.txt"
write.table(averages_data_by_subject_activity, final_output_file, row.name=FALSE)
#########################################################################################