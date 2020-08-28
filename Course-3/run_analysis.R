## Packages used for cleaning the data

library(dplyr)
library(tidyr)

## Loading the labels for activities and measures

activity_labels <- read.table(".\\data\\activity_labels.txt",
                              col.names = c("id", "label"))

features <- read.table(".\\data\\features.txt",
                       col.names = c("id", "label"))


## Loading and cleaning the test set


y_test <- read.table(".\\data\\test\\y_test.txt",
                     col.names = "activity")

subject_test <- read.table(".\\data\\test\\subject_test.txt",
                           col.names = c("subject"))

x_test <- read.table(".\\data\\test\\X_test.txt",
                     col.names = as.vector(features$label))

test_db <- cbind(subject_id = as.factor(subject_test$subject),
                 activity = factor(y_test$activity, labels = activity_labels$label),
                 x_test)



## Loading and cleaning the train set

y_train <- read.table(".\\data\\train\\y_train.txt",
                     col.names = "activity")

subject_train <- read.table(".\\data\\train\\subject_train.txt",
                           col.names = c("subject"))

x_train <- read.table(".\\data\\train\\X_train.txt",
                     col.names = as.vector(features$label))

train_db <- cbind(subject_id = as.factor(subject_train$subject),
                 activity = factor(y_train$activity, labels = activity_labels$label),
                 x_train)



## Merging both datasets

full_db <- rbind(train_db, test_db)

## Tidying the dataset, selecting columns and calculate means

tidy_db <- full_db %>%

    select(1:2,
           grep("mean|std", colnames(.)),
           - grep("meanFreq", colnames(.))) %>%

    pivot_longer(3:last_col(), names_to = "feature", values_to = "value") %>%

    group_by(subject_id, activity, feature) %>%

    summarise(mean = mean(value)) %>%

    pivot_wider(names_from = feature, values_from = mean)


## Correcting names of variables

names(tidy_db) <- gsub("^t", "Time", names(tidy_db))

names(tidy_db) <- gsub("^f", "Frequency", names(tidy_db))

names(tidy_db) <- gsub("BodyBody", "Body", names(tidy_db))

names(tidy_db) <- gsub("Acc", "Accelerometer", names(tidy_db))

names(tidy_db) <- gsub("Gyro", "Gyroscope", names(tidy_db))

names(tidy_db) <- gsub("Mag", "Magnitude", names(tidy_db))

names(tidy_db) <- gsub("freq", "Frequency", names(tidy_db))

names(tidy_db) <- gsub("mean", "Mean", names(tidy_db))

names(tidy_db) <- gsub("std", "STD", names(tidy_db))


## Saving .txt file

write.table(tidy_db, file = "tidydata.txt", row.name=FALSE)
