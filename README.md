Read all test and train data sets. Each has three files: X, subject and Y. Then the script binds them all in three data sets with the command rbind.
 
The script then goes on to read the features.txt into a vector, and only selects variables with 'std' or 'mean' with the command grepl. Then we select the X variables only from these variables, and name them from the features file.

To make them human readable, we remove parenthesis and store activities names instead of the integer of the activity. Then we column bind all the three datasets.

To conclude, we use the package plyr to aggregate the variables into mean for each subject and activity. Then we write the table to the file tidy.txt.