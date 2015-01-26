# Coursera- Getting and Cleaning Data
## Readme for Getting and Cleaning Data Course Project
There are files involved in this submission:
  1. run_analysis R script -submitted here in github
  2. ReadMe markdown document (this one)
  3. Codebook markdown document -also in github
  4. independent tidy data set - submitted in Coursera
 
## Explanation on how script works
The code has comment and mark #step 1 to #step 5 corresponding to the points below from question
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each    activity and each subject.

  **Step 1**
  
  Read files X_train, subject_train and y_train from train folder, then the program merge them in that order and keep   in variable merged_train.The same is applied to files in test folder. 
  train and test data are merged vertically respectively and the result is kept in merged_train_test
  
  **Step 2** extract only mean and std from features and keep in data1
  
  Read features.txt to variable feature. Use make.names to convert () and - to .
  
  copy data from merged_train_test to the variable "data"
  
  assign column names to data (all features + subject + activity)
  
  extract only mean and std features ( only keyword mean() and std are extracted --> 66 features) then keep the   outcome in variable "data1"
  
  **Step 3** put descriptive name to data in activity column
  
  Derive names from activity_labels.txt and label in activity column
  
  **Step 4**  Label the dataset with appropriate variable names 
     
     4.1 fix BodyBody to be only "Body"
     
     4.2 change ... to . (should be done before changing .. to .)
     
     4.3 fix 2 dots
     
     4.4 tBody to timeBody, fBody to freqBody
     
     4.5 acc to accel
  
  after finish, assign the new column names to data1
  
  **Step 5** generate independent file for mean values
  
  There are multiple rows for particular subject and activity and that we need one mean value for each feature
  
  use nested for loop to traverse 30 subjects with 6 activities each and find mean value by using colMeans function
  
Note: Apart from the desired tidy data in txt format, most steps are added with write.csv steps that would aim to ease the owner and reviewers

