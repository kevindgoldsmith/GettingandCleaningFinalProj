library(plyr)
library(reshape2)

#loads all data tables. assumes all tables are saved as same name from zip file, in folder called "c3proj"
X_test<-read.table("X_test.txt")
X_train<-read.table("X_train.txt")
y_test<-read.table("y_test.txt")
y_train<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")
subject_test<-read.table("subject_test.txt")
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

#assign Activity labels to y_train/test files
labeledtest<-join(activity_labels,y_test)
labeledtrain<-join(activity_labels,y_train)

#assign Feature labels to X_train/test files
colnames(X_train)<-features[,2]
colnames(X_test)<-features[,2]

#merge subject, Activity, and data files together 
testmerge<-cbind(subject_test, labeledtest[2], X_test)
trainmerge<-cbind(subject_train, labeledtrain[2], X_train)

#name first two columns of merged train and test files "Subject" and "Activity"
names(testmerge)[1]<-"Subject"
names(testmerge)[2]<-"Activity"
names(trainmerge)[1]<-"Subject"
names(trainmerge)[2]<-"Activity"

#merge test and train files into single file
final<-rbind(trainmerge,testmerge)

#find variable names that include "mean" or "std", save in column vector
#Also keep first two Subject and Activity columns
keep<-c(1,2,grep("mean|std",names(final)))

#save the names of all variables that include "mean" and "std"
keepnames<-grep("mean|std",names(final),value=TRUE)

#subset data set to only include first identified variables. "final" is now the completed data set for steps 1-4
final<-final[,keep]

#create new data set called "finaltidy"
#melt all variables except "Activity" and "Subject" into a single column called variable
finaltidy<-melt(final,id=c("Activity","Subject"),measure.vars=keepnames)

#recast finaltidy to split by Activity, Subject, and the mean of each other variable
#finaltidy is now completed tidy data set (step 5)
finaltidy<-dcast(finaltidy,Activity + Subject ~ variable, mean)

#remove no longer needed data
rm(X_test)
rm(X_train)
rm(y_test)
rm(y_train)
rm(subject_test)
rm(subject_train)
rm(features)
rm(activity_labels)
rm(labeledtest)
rm(labeledtrain)
rm(testmerge)
rm(trainmerge)
rm(keep)
rm(keepnames)

#output files
write.table(final,file = "FinalOutput.txt",row.name = FALSE)
write.table(finaltidy, file ="FinalTidyOutput.txt", row.name = FALSE)