# run_analysis.R
R code for Corsera Assignment

Readme file for the Coursera assignment

The 'run_analysis.R' script downloads the data and sets the working directory. I manually unzipped the data once it is downloaded to the working directory

Executing the script one step at a time then 
Read each of X, Y, Features and subjects data
Creates x, y combined data from training and test data
properly names the columns
using a filter extratcs x data for mean and std in the column names.
it then calculates the mean for all the data on X_combined set

It finally saves the data to "UCI-HAR-dataset-AVG-tidy.txt" file.
