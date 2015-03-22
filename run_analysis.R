#1.Merges the training(train/X_train.txt) and the test sets(test/X_test.txt) to create one data set.
#Read in all the info
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
#creat new variables for subject, activity and type(test or train)
X_test$subject<-subject_test$V1
X_test$activity<-y_test$V1
X_train$subject<-subject_train$V1
X_train$activity<-y_train$V1
X_test$type <- rep("test",2947)
X_train$type <- rep("train",7352)
#combine X_test and X_train
total <- rbind(X_test,X_train)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
mean_index<-which(grepl("-mean()",features$V2,fixed=TRUE))
std_index<-which(grepl("-std()",features$V2,fixed=TRUE))
mean_std<-c(mean_index,std_index)
sorted_mean_std<-sort(mean_std)
#Note that subject, activity and type (the last three columns) are also included here
total_mean_std<-total[,c(sorted_mean_std,562:564)]

#3.Uses descriptive activity names to name the activities in the data set
#Create a new variable in total_mean_std called activity_des
total_mean_std$activity_des<-total_mean_std$activity
#Replace 1 with WALKING
WALKING_list<-which(total_mean_std$activity==1)
total_mean_std$activity_des[WALKING_list]<-rep("WALKING",length(WALKING_list))
#Replace 2 with WALKING_UPSTAIRS
WALKING_UPSTAIRS_list<-which(total_mean_std$activity==2)
total_mean_std$activity_des[WALKING_UPSTAIRS_list]<-rep("WALKING_UPSTAIRS",length(WALKING_UPSTAIRS_list))
#Replace 3 with WALKING_DOWNSTAIRS
WALKING_DOWNSTAIRS_list<-which(total_mean_std$activity==3)
total_mean_std$activity_des[WALKING_DOWNSTAIRS_list]<-rep("WALKING_DOWNSTAIRS",length(WALKING_DOWNSTAIRS_list))
#Replace 4 with SITTING
SITTING_list<-which(total_mean_std$activity==4)
total_mean_std$activity_des[SITTING_list]<-rep("SITTING",length(SITTING_list))
#Replace 5 with STANDING
STANDING_list<-which(total_mean_std$activity==5)
total_mean_std$activity_des[STANDING_list]<-rep("STANDING",length(STANDING_list))
#Replace 6 with LAYING
LAYING_list<-which(total_mean_std$activity==6)
total_mean_std$activity_des[LAYING_list]<-rep("LAYING",length(LAYING_list))

#4.Appropriately labels the data set with descriptive variable names. 
#convert factors to characters in features
features_c<-lapply(features, as.character)
#get the list of measurements that are mean and standard deviation for each measurement
var_list<-features_c$V2[sorted_mean_std]
#rename the variables in total_mean_std as in features.txt
names(total_mean_std)<-c(var_list,"subject","activity","type","activity_des")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#reshape the data
library(reshape2)
total_mean_std_melt <- melt(total_mean_std,id=c("activity_des","subject"),measure.vars=var_list)
tidy_dataset <- dcast(total_mean_std_melt, activity_des + subject ~ variable, mean)
write.table(tidy_dataset,file="tidyDataset.txt",row.name=FALSE)
