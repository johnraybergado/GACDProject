# Cleaning UCI HAR Dataset

The [run_analysis.R](https://github.com/xtinkrr/GACDProject/blob/master/run_analysis.R)
script produces a tidy data out of the the UCI Human
Activity Recognition [dataset](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
It generally does the following:

## General script flow
1. Combines the training and test set into one big
dataset.
2. Extracts mean and standard deviation measurements
out of the set of features.
3. Provides appropriate names to activity labels.
4. And computes the average of each variable for
every activity done by each subject.

Note the script assumes that the following libraries
are installed:

- data.table
- dplyr
- reshape2

And the dateset is in the same directory as the script.

See the [CodeBook](https://github.com/xtinkrr/GACDProject/blob/master/CodeBook.md) for more
details about the data.

## Reading the tidy data
The resulting tidy data can be read by the following code:
```R
address <- "https://s3.amazonaws.com/coursera-uploads/user-1e0ca9fd9a9ac83c0313ac80/973501/asst-3/fb419260023c11e581e4599541643855.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE)
View(data)
```