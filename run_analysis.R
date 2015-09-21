#read packages for tidying data
library(dplyr)
library(tidyr)
library(plyr)
#read general data
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
features2<-as.character((features[,2]))

activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"")
activity_labels<- as.character(activity_labels[,2])

#read train data

label_train<- tbl_df(read.table(file = ("~/UCI HAR Dataset/train/y_train.txt"), header=F))
set_train<- tbl_df(read.table(file = ("~/UCI HAR Dataset/train/x_train.txt"), header=F))
subject_train <- tbl_df(read.table("~/UCI HAR Dataset/train/subject_train.txt")

#tidy label train set: activity, type and subject                        
labeltr<- label_train%>%
  mutate(type="train") %>%
  bind_cols(Subject=subject_train)
colnames(labeltr)[1]<- "Activity"
colnames(labeltr)[3]<- "Subject"


#read test data

label_test <- tbl_df(read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\""))
set_test <- tbl_df(read.table("~/UCI HAR Dataset/test/x_test.txt", quote="\""))
subject_test <- tbl_df(read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\""))

#tidy label test set: activity, type and subject  
labelt<-label_test%>%
mutate(type="test") %>%
bind_cols(Subject=subject_test)
colnames(labelt)[1]<- "Activity"
colnames(labelt)[3]<- "Subject"


#full tidy labels 

labels<- tbl_df(bind_rows(labelt,labeltr))

# 1)Merges the training and the test sets to create one data set.

set<-tbl_df(bind_rows(set_test,set_train))
#4) Appropriately labels the data set with descriptive variable names
#i'll do this first, because it would be harder to do after selecting variables from point 2
colnames(set)<-features2

#2)select row that include mean and std
meanstd<- c((grep("mean",features2)),(grep("std",features2)))
set2<- set[,meanstd]

#set names according to subject and type of data
# 3) Uses descriptive activity names to name the activities in the data set
set3<- tbl_df(bind_cols(labels,set2))
set3$Activity <- factor(set3$Activity,
                    levels = c(1,2,3,4,5,6),
                    labels = activity_labels)

#5)From the data set in step 4, creates a second, independent 
#tidy data set with the average of each variable for each activity and each subject.
finalset<- set3 %>%
  group_by(type,Activity,Subject) %>%
  summarise_each(funs(mean))

