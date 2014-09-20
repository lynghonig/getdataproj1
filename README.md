getdataproj1
============
#Introduction

This project uses data from [The UNC Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) in which 30 volunteers performed six activities (walking, walking upstairs, walking downstairs, sitting, standing and laying) whilst wearing a Samsung Galaxy S II. 3-axial linear acceleration and 3-axial angular velocity were captured using the phone's inbuilt accelometer and gyroscope.

- **Dataset**:[Data collected from accelerometers on Samsung Galaxy S smartphone](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

#Scripts

There is only one script: **run_analysis.R** which performs the following functions:

1. Reads in the data and unzips the data file (if necessary)
2. Creates a dataframe containing all the training and test data
3. Removes variables which are not means or standard deviations
4. Changes activity values (1-6) to their descriptive names (walking, walking upstairs, walking downstairs, sitting, standing and laying)
5. Makes the variable names more human friendly
6. Creates a tidy data set which takes the mean of each variable by subject and activity
7. Writes the data set created in (6) to file as tidydata.txt

#Codebook

The codebook in this repo explains in more detail the variables, data and transformations used