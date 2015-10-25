# Function to Check if dependencies are installed and if not install
fEnsurePackageAvailability <- function (package) {
	suppressWarnings( {
		if (!require(package, character.only = TRUE)) {
			paste("Package", package, " not found. Installing...")
			install.packages(package)
			if (!require(package, character.only = TRUE)) {
				paste("Package", package, " installation FAILED!")
			} else {
				paste("Package", package, " SUCCESSFULLY installed.")
			}
		} else {
			paste("Package", package, " ALREADY installed.")
		}
	})
}

# Ensuring Package installation.
fEnsurePackageAvailability("plyr")
fEnsurePackageAvailability("reshape2")

#downloading the source zipped data files and unzipping
url_src <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url_src, dest = "dataset.zip", mode = "wb")
unzip("dataset.zip", exdir = ".")

# reading corresponding test and training data files.
testSet <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
trainingSet <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")

# appending columns of test and training datasets.
allObservations <- rbind(testSet, trainingSet)


# reading feature data file, to name the columns.
featureNames <- read.table(".\\UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)[[2]]
colnames(allObservations) <- featureNames

# Considering only the needded columns, i.e., mean and standard deviaion
allObservations <- allObservations[,featureNames[grep("mean|std",featureNames)]]

#storing the dataset names into a variable for easy of use
varNames <- names(allObservations)

# pre-procesing for standardizing the dataset column names
varNames <- gsub(pattern = "^t", replacement = "time", x = varNames)
varNames <- gsub(pattern = "^f", replacement = "freq", x = varNames)
varNames <- gsub(pattern = "-?mean[(][)]-?",replacement = "Mean", x=varNames)
varNames <- gsub(pattern = "-?std[(][)]-?",replacement = "Std", x=varNames)
varNames <- gsub(pattern = "-?meanFreq[(][)]-?",replacement = "MeanFreq", x=varNames)
varNames <- gsub(pattern = "BodyBody",replacement = "Body", x=varNames)

#Updating the dataset column names
names(allObservations) <- varNames


# creating activityLabels dataset
activityLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", stringsAsFactors=FALSE)
colnames(activityLabels) <- c("activityID", "activityLabel")

#getting test and train activities
testActivities <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", stringsAsFactors=FALSE)
trainingActivities <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", stringsAsFactors=FALSE)
allActivities <- rbind(testActivities, trainingActivities)

#Assigning column name to be used in join condition
colnames(allActivities) <- "activityID"

#joining the datasets, to preserver order
activities <- join(allActivities, activityLabels, by="activityID")

#adding the column to the dataset
allObservations <- cbind(activity=activities[, "activityLabel"], allObservations)

#reading subjects to be added to the dataset
testSubjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", stringsAsFactors=FALSE)
trainingSubjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", stringsAsFactors=FALSE)

allSubjects <- rbind(testSubjects, trainingSubjects)
colnames(allSubjects) <- "subjects"

allObservations <- cbind(allSubjects, allObservations)

#ordering the dataset
allObservations <- allObservations[order(allObservations$subjects, allObservations$activity),]

# storing the tidy dataset in a file
write.table(allObservations, file = "HAR_Dataset.txt", row.names=FALSE)


#creating a long dataset from a wide dataset
molten <- melt(allObservations, id.vars = c("subjects","activity"))

# transforming the dataset with aggregation, as reqired
subjectActivityMean <- dcast(molten, subjects+activity ~ variable, fun.aggregate=mean)

#writing the tidy data to file.
write.table(subjectActivityMean, file = "HAR_subjectActivityMean.txt", row.names=FALSE)
