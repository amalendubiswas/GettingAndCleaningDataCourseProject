This CodeBook.md file describes the variables, the data, and any transformations or work that has been performed to clean up the Samsung data.

# Variables used for the location of directories and files:
1. The empty_separator variable contains "" string.
2. The uci_har_dataset_directory variable contains "UCI HAR Dataset" string.
3. The features_file variable contains "UCI HAR Dataset\features.txt" string.
4. The activity_labels_file variable contains "UCI HAR Dataset\activity_labels.txt" string.
5. The x_train_file variable contains "UCI HAR Dataset\train\X_train.txt" string.
6. The y_train_file variable contains "UCI HAR Dataset\train\y_train.txt" string.
7. The subject_train_file variable contains "UCI HAR Dataset\train\subject_train.txt" string.
8. The x_test_file variable contains "UCI HAR Dataset\test\X_test.txt" string.
9. The y_test_file variable contains "UCI HAR Dataset\test\y_test.txt" string.
10. The subject_test_file variable contains "UCI HAR Dataset\test\subject_test.txt" string.
11. The final_output_file variable contains "sensor_averages_by_subject_activity.txt". This is final independent output tidy data set with the average of each variable for each activity and each subject.

# Variables used for loading raw data, features data column names, and activity label names:
1. The X_train, y_train and subject_train variables contain raw data loaded from the X_train.txt, y_train.txt and subject_train.txt files located under ".\UCI HAR Dataset\train" folder under the working directory.
2. The X_test, y_test and subject_test variables contain raw data loaded from the X_test.txt, y_test.txt and subject_test.txt files located under ".\UCI HAR Dataset\test" folder under the working directory.
3. The features variable contains the data column names loaded from the "features.txt" located under "UCI HAR Dataset" folder under the working directory.
4. The activities variable contains the activity labels loaded from the "activity_labels.txt" located under "UCI HAR Dataset" folder under the working directory.

# Variables used for merging the training and the test sets to create one data set:
The x_dataset variable contains one 'x' data set by merging (rbind'ing) X_train and X_test data sets.
The y_dataset variable contains one 'y' data set by merging (rbind'ing) y_train and y_test data sets.
The subject_dataset variable contains one 'subject' data set by merging (rbind'ing) subject_train and subject_test data sets.

# Variables used for extracting only the measurements on the mean and standard deviation for each measurement:
The features_mean_or_std (a numeric vector) variable contains only columns (measurements) that has mean() or std() in their column names (measurements) for each measurement. The features_mean_or_std variable is then applied to the x_dataset to subset the desired columns.

The activities variable is then applied to the y_dataset to update the values with correct activity names. This is for useing descriptive activity names to name the activities in the data set.

Then the 'x' data set has been appropriately labeled with correct the column names, the 'y' data set has been appropriately labeled with descriptive the column names, and the 'subject' data set has been appropriately labeled with descriptive the column names.

# Variables used for producing output: 
The single_dataset variable contains one single data set by merging (cbind'ing) x_dataset, y_dataset and subject_dataset.
The averages_data_by_subject_activity variable contains a second, independent tidy data set with the average of each variable for each activity and each subject.
The mean function has been applied to the single dataset variable single_dataset with the average of each variable for each activity and each subject. The ddply() function within the plyr package has been utilized to apply colMeans().
The sensor_averages_by_subject_activity.txt file contains the final independent output tidy file with the average of each variable for each activity and each subject. This output file will be created under the working directory.

