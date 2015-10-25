Code book 
=================

This document provides information about the generated sets by the script `run_analysis.R`, provided in this repository.

## Data sets
The script `run_analysis.R`, creates two data tidy sets HAR_Dataset.txt and HAR_subjectActivityMean.txt.

### Data set HAR_Dataset.txt

The dataset "HAR_Dataset.txt" is the result of cleaning and selecting data from The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project used in the R script:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

HAR_Dataset.txt looks like.

1. The first variable `subjects` denotes the subject number that performed an activity. In total there are 30 subjects.
2. The second variable `activity` denotes the activity performed by the subject. There are six activites, listed below:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

Of all the features only the mentioned below were addressed
* The prefix `t` was rewritten into `time`
* The prefix `f` was rewritten into `freq`
* dashes and parentheses have been removed
* BodyBody has been replaced by Body
* Hungarian notation has been used for naming

For example:

* `tBodyAcc-mean()-X` becomes `timeBodyAccMeanX` 
* `tBodyAcc-std()-Y` becomes `timeBodyAccStdY`
* `fBodyAcc-mean()-Z` becomes `freqBodyAccMeanZ`
* `fBodyBodyGyroMag-mean()` becomes `freqBodyGyroMagMean`
* `fBodyBodyGyroJerkMag-meanFreq()` becomes `freqBodyGyroJerkMagMeanFreq`

The description of the features is available in the file `features_info.txt`, part of the zip download.

### Data set HAR_subjectActivityMean.txt
Generated from HAR_Dataset.txt, the data is grouped by subject and activity and then aggregated using the mean function.

## Original data set
Full description can be found thorugh the link http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
