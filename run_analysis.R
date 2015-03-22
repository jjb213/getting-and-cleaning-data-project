## Getting and Cleaning Data
## Course Project
## 03/22/2015

setwd("~/coursera/data_scientist/getting-and-cleaning-data/project")

## 1. Merges the training and the test sets to create one data set.
data <- rbind(read.table('UCI HAR Dataset/test/X_test.txt'), read.table('UCI HAR Dataset/train/X_train.txt'))

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
colNames <- read.table('UCI HAR Dataset/features.txt')
colnames(data) <- colNames[,2]
data <- data[,grep("mean|std", colNames[,2])]

## 3. Uses descriptive activity names to name the activities in the data set
activityCode <- rbind(read.table('UCI HAR Dataset/test/y_test.txt'),read.table('UCI HAR Dataset/train/y_train.txt'))
descLabels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
data$Activity <- 0

for (i in 1:10299 ) {
        data$Activity[i] <- descLabels[activityCode[i,1]]
}

## 4. Appropriately labels the data set with descriptive variable names. 
## Already done in step 2, which made selecting mean and standard deviation measurements easier

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data2 <- data.frame(matrix(nrow=6, ncol=80))

for (i in 1:6) {
        data2[i,80] = descLabels[i]
        for (j in 1:79) {
                data2[i,j] <- mean(data[(data$Activity == descLabels[i]),j])
        }
}
