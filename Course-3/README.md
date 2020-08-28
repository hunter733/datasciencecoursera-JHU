#                                                  Getting and Cleaning Data Course Project


#### 3.Getting and Cleaning Data (COURSE 3)

##### About this Course
Before you can work with data you have to get some. This course will cover the basic ways that data can be obtained. The course will cover obtaining data from the web, from APIs, from databases and from colleagues in various formats. It will also cover the basics of data cleaning and how to make data “tidy”. Tidy data dramatically speed downstream data analysis tasks. The course will also cover the components of a complete data set including raw data, processing instructions, codebooks, and processed data. The course will cover the basics needed for collecting, cleaning, and sharing data.


## Project
The goal of the `Coursera` project for `Getting and Cleaning Data` is to read in the data set, and create an output that is a `tidy` data set.

The data used for the project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Data set used can be downloaded from [UCI data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

# Requirements
Below are prequisites required before running [run_analysis.R](run_analysis.R):

- Package: [tidyverse package](https://cran.r-project.org/web/packages/tidyverse/index.html). Use `install.package("tidyverse")` to install the package if not already installed.
- Download the [UCI data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Unzip the file in folder `data` in the working directory.

# Output

Output of the project is tidy data set [tidydata.txt](tidydata.txt) file. More details about the file and steps invlolved in creating it can be found in [CodeBook](CodeBook.md).
