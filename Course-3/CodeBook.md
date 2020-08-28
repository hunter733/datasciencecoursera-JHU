# Code Book

## Data Set

The data used for the project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Data set used can be downloaded from [UCI data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Transformations

- Both the processed test and training datasets are read into R and merged into one data set.
- Column headers are changed for identifiers as described in `Identifiers` section below.
- Column names are changed for measurements as per `features.txt` found in the zip file.
- Measurement not containing `mean` or `standard deviation` are removed from the data set.
- The activity identifiers are replaced with the activity labels based on the `activity_labels.txt` file.
- Column names are expanded e.g. `acc` to `Accelerometer` etc., invalid characters like `-`, `()` are removed and `BodyBody` is replaced with `Body`.
- Mean is calculated for the remaining measurement based on corresponding subject and activity.
- The summary dataset is written to the disk, in `tidydata.txt`.

## Output File

This part describes all of the data fields in the [tidydata.txt](tidydata.txt) file.

### Identifiers

- `subject_id` - ID of the test subject
  - 1 - 30
- `activity` - Activity that subjects were performing for the corresponding measurement
  - Walking
  - Walking Upstairs
  - Walking Downstairs
  - Sitting
  - Standing
  - Laying


### Measurement

All of the remaining variables are mean values of the measurement for given subject and activity.


- TimeBodyAccelerometerMeanX
- TimeBodyAccelerometerMeanY
- TimeBodyAccelerometerMeanZ
- TimeBodyAccelerometerSTDX
- TimeBodyAccelerometerSTDY
- TimeBodyAccelerometerSTDZ
- TimeGravityAccelerometerMeanX
- TimeGravityAccelerometerMeanY
- TimeGravityAccelerometerMeanZ
- TimeGravityAccelerometerSTDX
- TimeGravityAccelerometerSTDY
- TimeGravityAccelerometerSTDZ
- TimeBodyAccelerometerJerkMeanX
- TimeBodyAccelerometerJerkMeanY
- TimeBodyAccelerometerJerkMeanZ
- TimeBodyAccelerometerJerkSTDX
- TimeBodyAccelerometerJerkSTDY
- TimeBodyAccelerometerJerkSTDZ
- TimeBodyGyroscopeMeanX
- TimeBodyGyroscopeMeanY
- TimeBodyGyroscopeMeanZ
- TimeBodyGyroscopeSTDX
- TimeBodyGyroscopeSTDY
- TimeBodyGyroscopeSTDZ
- TimeBodyGyroscopeJerkMeanX
- TimeBodyGyroscopeJerkMeanY
- TimeBodyGyroscopeJerkMeanZ
- TimeBodyGyroscopeJerkSTDX
- TimeBodyGyroscopeJerkSTDY
- TimeBodyGyroscopeJerkSTDZ
- TimeBodyAccelerometerMagnitudeMean
- TimeBodyAccelerometerMagnitudeSTD
- TimeGravityAccelerometerMagnitudeMean
- TimeGravityAccelerometerMagnitudeSTD
- TimeBodyAccelerometerJerkMagnitudeMean
- TimeBodyAccelerometerJerkMagnitudeSTD
- TimeBodyGyroscopeMagnitudeMean
- TimeBodyGyroscopeMagnitudeSTD
- TimeBodyGyroscopeJerkMagnitudeMean
- TimeBodyGyroscopeJerkMagnitudeSTD
- FrequencyBodyAccelerometerMeanX
- FrequencyBodyAccelerometerMeanY
- FrequencyBodyAccelerometerMeanZ
- FrequencyBodyAccelerometerSTDX
- FrequencyBodyAccelerometerSTDY
- FrequencyBodyAccelerometerSTDZ
- FrequencyBodyAccelerometerJerkMeanX
- FrequencyBodyAccelerometerJerkMeanY
- FrequencyBodyAccelerometerJerkMeanZ
- FrequencyBodyAccelerometerJerkSTDX
- FrequencyBodyAccelerometerJerkSTDY
- FrequencyBodyAccelerometerJerkSTDZ
- FrequencyBodyGyroscopeMeanX
- FrequencyBodyGyroscopeMeanY
- FrequencyBodyGyroscopeMeanZ
- FrequencyBodyGyroscopeSTDX
- FrequencyBodyGyroscopeSTDY
- FrequencyBodyGyroscopeSTDZ
- FrequencyBodyAccelerometerMagnitudeMean
- FrequencyBodyAccelerometerMagnitudeSTD
- FrequencyBodyAccelerometerJerkMagnitudeMean
- FrequencyBodyAccelerometerJerkMagnitudeSTD
- FrequencyBodyGyroscopeMagnitudeMean
- FrequencyBodyGyroscopeMagnitudeSTD
- FrequencyBodyGyroscopeJerkMagnitudeMean
- FrequencyBodyGyroscopeJerkMagnitudeSTD
