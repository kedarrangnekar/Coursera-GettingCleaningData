# Coursera-GettingCleaningData
Repository for Getting and Cleaning Data Course in Data Science Specialisation

In this repo you will find 2 files related to Wearable Computing Data used for the "Getting and Cleaning Data" course
## 1. R Script named "run_analysis.R"
## 2. MetaData for the tidy data set named "CodeBook.md"

## Steps followed
    1. Merging Train and Test Data
          Used read.table command to load the subject data and activity data file
          The actual data (561 domain variables) was loaded using read.table but with an argument sep = "" as read.fwf was very time consuming and not memory efficient
          Created an additional column called "training" in the training dataset and "test" in test dataset in order to differentiate the datasets from one another post merging
          Merged the dataset using merge() function using join_all command
          (Alternatively can use cbind() but only if data is ordered)
    2. Adding Column Names
          Used the features.txt file to load headers.
          Adding additional column names and rbinding it to our merged dataset
    3. Identifying columns with mean() and std() calculations
          Used grep() to identify column indices
    4. Naming Activities
          Used activity_labels.txt as reference file
          Activity_id used as key to merge datasets
    5. Final Tidy Data
          Used melt() to make "id","subject" and "activity_name" as ids
          Recast the data using dcast() with function argument "mean" to arrive at desired tidy data.
          
