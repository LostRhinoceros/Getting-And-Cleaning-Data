# Getting-And-Cleaning-Data
Download files from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Update the file variable in the R script with the file path you unzipped the download to.  The script will find the relevant files and read them in before rbinding the test and training sets together.

The "all" dataframe has the combined data organized by participant and posture.  The "all2" dataframe is the long version of the data to facilitate filtering out irrelevant variables and the final summarization of the data.

"means" is the long-format dataframe containing the averages of the relevant variables.

"means.wide" is the reformatted tidy version of the dataset organized by participant and posture.
