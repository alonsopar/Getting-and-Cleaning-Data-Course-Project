the code read packages for tidying data

then read general dataincluding featuresm and activity labels

the code reads train and set data

then it creates  a tidy data frame called labels 
that includes 3 columns: activity , type and subject
after that i folllowed the steps 

1)Merges the training and the test sets to create one data set.

4) Appropriately labels the data set with descriptive variable names

I'll do this first, because it would be harder to do after selecting variables from point 2

2)select row that include mean and std

3) Uses descriptive activity names to name the activities in the data set

5)From the data set in step 4, creates a second, independent 
tidy data set with the average of each variable for each activity and each subject.

code book 

The file includes all the varibles that contain mean and std in their name according 
to features.ext file.
It also contains 3 additional variables 
Activity: 6 diffrent acctivities according to activity_labels.txt
Type: Two different type Train and Test 
Subject: 1:30 volunteers


