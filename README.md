# GettingandCleaningFinalProj
The R program in this folder, "run_analysis.R", is meant to operate on the files saved in this zip file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

All the text files from that folder should be copied into the working R directory. This program works as follows:

1) Loads all needed text files into R environment.
2) Lables the columns of the "X_train" and "X_test" files using the variable names specified in the "features" file.
3) For each set of test and train files, joins the subject (subject_train/test), activity (y_train/test, mapped to "activity_labels"), and data (X) tables
4) Joins the two larger test and train tables into a single "final" table
5) Extracts the Subject and Activity variables, and all measurement variables representing mean and standard deviation measurements to create the final "final" table.
6) Summarizes the "final" table into a "finaltidy" table, by taking the mean of each measurement variable, cut by Subject and Activity.
