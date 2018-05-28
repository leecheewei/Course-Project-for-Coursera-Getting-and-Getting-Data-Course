# Course-Project-for-Coursera-Getting-and-Getting-Data-Course
(Collection of files including the script for the course project for Coursera Getting and Cleaning Data course)

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.

This repository contains the following files:

README.md, this file, which provides an overview of the data set and how it was created.
TidyData.txt, which contains the data set.
CodeBook.md, the code book, which describes the contents of the data set. 
run_analysis.R, the R script that was used to create the data set


Study design
------------
The source data set that this project was based on was obtained from the Human Activity Recognition Using Smartphones Data Set, which describes how the data was initially collected as follows:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Training and test data were first merged together to create one data set, then the measurements on the mean and standard deviation were extracted for each measurement (79 variables extracted from the original 561), and then the measurements were averaged for each subject and activity, resulting in the final data set.



Information on run_analysis.R
-----------------------------
The R script run_analysis.R can be used to create the data set as required by the course project. Description is included in the code itself for easy understanding. The script process the original data files in the following steps. 

1. Download and unzip source data if it doesn't exist.
2. Read the data files. Only a few raw files are involved in the processing, i.e., 
    - 'features.txt': List of all features.
    - 'activity_labels.txt': Links the class labels with their activity name.
    - 'train/X_train.txt': Training set.
    - 'train/y_train.txt': Training labels.
    - 'test/X_test.txt': Test set.
    - 'test/y_test.txt': Test labels.activity_labels, features. 
3. Naming all the columns with the descriptive names
4. Merging the tables
5. Extracting only the mean and standard deviation measurements
6. Use descriptive activity and variable names to label the activities and features names in the data table
7. Creates a second, independent tidy data set and write to the text file 'TidyData.txt'

The TidyData.txt in this repository was created by running the run_analysis.R script using R version 3.4.4 on Windows 10 Professional 64-bit edition.

