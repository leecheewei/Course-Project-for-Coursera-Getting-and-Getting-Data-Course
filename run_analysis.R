# OVERVIEW
#   R code for Getting and Cleaning Data Course Project.
#   See "tidy_data.txt" for tidied data.
#   See "README.md" for more information.

library(dplyr)

getwd()
## STEP 1 - Get data

# Download zip file if it has not been downloaded
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset1 <- "UCI_Dataset.zip"

if (!file.exists(dataset1)) 
{
  download.file(fileUrl, dataset1, mode = "wb")
}

# unzip zip file if unzip file does not exist
datapath <- "UCI_Dataset"
if (!file.exists(datapath)) 
{
  unzip(dataset1)
}



## STEP 2 - Read file

# Reading tables:
train_values <- read.table('./UCI HAR Dataset/train/X_train.txt')   #reading the observation values for train dataset
train_activity <- read.table('./UCI HAR Dataset/train/y_train.txt') #reading the activity ID for train dataset
train_subjects <- read.table('./UCI HAR Dataset/train/subject_train.txt')   	#reading the subject ID for train dataset

test_values <- read.table('./UCI HAR Dataset/test/X_test.txt')	#reading the observation values for test dataset
test_activity <- read.table('./UCI HAR Dataset/test/y_test.txt')	#reading the activity ID for test dataset
test_subjects <- read.table('./UCI HAR Dataset/test/subject_test.txt')		#reading the subject ID for test dataset


# Reading feature vector:
features <- read.table('./UCI HAR Dataset/features.txt')

# Reading activity labels:
activity_label <- read.table('./UCI HAR Dataset/activity_labels.txt')



## STEP 3 - Naming the columns

colnames(train_values) <- features[,2]	#name the column header of observation values with the variable names in features.txt
colnames(train_activity) <-'Activity_Id'	
colnames(train_subjects) <- 'Subject_Id'
      
colnames(test_values) <- features[,2] 
colnames(test_activity) <- 'Activity_Id'
colnames(test_subjects) <- 'Subject_Id'
      
colnames(activity_label) <- c('Activity_Id','Activity_Description')	#name the column header of activity label to match each ID to corresponding activity description



## STEP 4 - Merging the tables

train_data <- cbind(train_subjects, train_activity, train_values)		#horizontal combination of the train dataset table
test_data <- cbind(test_subjects, test_activity, test_values)		#horizontal combination of the test dataset table

all_data<- rbind(train_data,test_data)		#vertical combination of train and test data tables



# STEP 5 - Extracting only the mean and standard deviation measurements

column_names<-colnames(all_data)		#select the column names

mean_and_std <- (
			grepl("Activity_Id",column_names)|grepl("Subject_Id",column_names)| 
                 	grepl("mean.." , column_names)|grepl("std.." , column_names) 
                 )				#create a logic vector that is TRUE when mean or std are in the column names, while preserving the Subject_ID and Activity_ID column

mean_std_data <- all_data[ , mean_and_std == TRUE]		#Extract the mean and std data and form a new data table



# STEP 6 - Use descriptive activity and variable names to label the activities and features names in the data table

mean_std_data <- merge(mean_std_data, activity_label, by='Activity_Id', all.x=TRUE)

names(mean_std_data)<-gsub("^t", "time", names(mean_std_data))
names(mean_std_data)<-gsub("^f", "frequency", names(mean_std_data))
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data)<-gsub("BodyBody", "Body", names(mean_std_data))




# STEP 7 - Creates a second, independent tidy data set and write to the text file 'TidyData.txt'

tidy_dataset <- aggregate(. ~Subject_Id + Activity_Id + Activity_Description , mean_std_data, mean)	#calculate mean of variables while leaving 
tidy_dataset <- arrange(tidy_dataset, Subject_Id , Activity_Id)		#arrange the data in terms of Subject_Id followed by Activity_Id
write.table(tidy_dataset, file = "TidyData.txt", row.name=FALSE)		#write to text file

