# tidyDataset
###Course Project for Getting and Cleaning Data


run_analysis.R takes data files from the UCI HAR Dataset and returns a text file called "tidyDataset.txt" for average of the mean and sd of each variable for each activity and each subject.

Note that only the mean() and std() of signals are included in the tidy dataset, not those natural mean varialbes such as gravityMean and tBodyAccMean

A guarantteed  way to run this analysis is to run run_analysis.R line by line (sorry). If you would like to "source" it, please make sure the UCI HAR Dataset folder is in your working directory. 

For detailed explaination of the code, please see comments within run_analysis.R itself.

P.S. I could not upload tidy data set in coursera. Error message: "There was a problem connecting to the upload server". Therefore I put it in this repo as well. The file name is tidyDataset.txt