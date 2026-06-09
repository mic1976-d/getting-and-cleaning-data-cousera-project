# getting-and-cleaning-data-cousera-project
Repository for getting and cleaning coursera project
This project is part of the Coursera course Getting and Cleaning Data. The R script, run_analysis.R, performs the following steps:

Downloads the dataset if it is not already available in the working directory.
Loads the information related to activities and features.
Imports both the training and test datasets, retaining only the variables associated with means and standard deviations.
Incorporates the activity and subject data into each dataset, merging them with the main observations.
Combines the training and test datasets into a single dataset.
Transforms the activity and subject variables into factors.
Produces a tidy dataset containing the average of each variable for every subject–activity combination.

The final output is stored in the file tidy.txt.
