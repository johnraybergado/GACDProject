library(data.table)
library(dplyr)
library(reshape2)

# path to relevant files
training_data_path = ".\\UCI HAR Dataset\\train\\X_train.txt"
training_subject_path = ".\\UCI HAR Dataset\\train\\subject_train.txt"
training_label_path = ".\\UCI HAR Dataset\\train\\y_train.txt"
test_data_path = ".\\UCI HAR Dataset\\test\\X_test.txt"
test_subject_path = ".\\UCI HAR Dataset\\test\\subject_test.txt"
test_label_path = ".\\UCI HAR Dataset\\test\\y_test.txt"
column_names_path = ".\\UCI HAR Dataset\\features.txt"
activity_labels_path = ".\\UCI HAR Dataset\\activity_labels.txt"

# read and merge training and test dataset

## extract column names
column_names <- read.table(column_names_path)
column_names <- as.character(column_names$V2)

## read data
training_data <- as.data.table(read.table(file=training_data_path,
                                          header=FALSE,
                                          col.names=column_names))
training_subjects <- read.table(file=training_subject_path,
                                        header=FALSE,
                                        col.names="subject")
training_labels <- read.table(file=training_label_path,
                              header=FALSE,
                              col.names="activity_id")
test_data <- as.data.table(read.table(file=test_data_path,
                                      header=FALSE,
                                      col.names=column_names))
test_subjects <- read.table(file=test_subject_path,
                          header=FALSE,
                          col.names="subject")
test_labels <- read.table(file=test_label_path,
                                        header=FALSE,
                                        col.names="activity_id")
## merge data
training_data <- cbind(training_subjects, training_data)
training_data <- cbind(training_data, training_labels)
test_data <- cbind(test_subjects, test_data)
test_data <- cbind(test_data, test_labels)
tidy_data1 <- rbind(training_data, test_data)

# extract mean and standard deviation measurements
tidy_data1 <- select(tidy_data1, matches("mean|std|activity|subject"))

# provide names to activity labels
activity_labels <- as.data.table(read.table(activity_labels_path,
                              header=FALSE,
                              col.names=c("activity_id", "activity")))
tidy_data1 <- merge(tidy_data1, activity_labels, by="activity_id")
tidy_data1 <- select(tidy_data1, -activity_id)

## remove "." from column names
colnames(tidy_data1) <- gsub("\\.", "", colnames(tidy_data1))

# extract mean of each measurement for every subject and every activity
tidy_data1_melt <- melt(tidy_data1, id.vars=c("subject", "activity"))
tidy_data2 <- dcast(tidy_data1_melt, subject + activity ~ variable, mean)

# write to txt file
write.table(tidy_data2, file="UCI_HAR_tidy.txt", row.names=FALSE)