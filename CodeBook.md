# Code book of tidy UCI HAR dataset

The resulting tidy data has a total of 88 variables:

1. subject - id number for the person who did the activity
2. activity - descriptive name of the activity done by a subject

The other 86 variables are taken as mean of the measurements
grouped per subject and per activity of the selected features
(as per [README](https://github.com/xtinkrr/GACDProject/blob/master/README.md)).

For more information on each variable, see the original
[features_info.txt](https://github.com/xtinkrr/GACDProject/blob/master/features_info.txt)
from the raw dataset.

And as noted by the original dataset's README:

> Features are normalized and bounded within [-1,1].