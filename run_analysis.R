##Check whether the UCI HAR Dataset file has already been unzipped.
##If not, unzip it.

if(!file.exists("./UCI HAR Dataset")){
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

##Read in the various files. The working directory is the one containing the zip file.

xtrain<-read.table(file="UCI HAR Dataset/train/X_train.txt",header=FALSE)
xtest<-read.table(file="UCI HAR Dataset/test/X_test.txt",header=FALSE)
features<-read.table(file="UCI HAR Dataset/features.txt",header=FALSE)

strain<-read.table(file="UCI HAR Dataset/train/subject_train.txt",header=FALSE)
stest<-read.table(file="UCI HAR Dataset/test/subject_test.txt",header=FALSE)
Subject<-c(strain[,1],stest[,1])

ytrain<-read.table(file="UCI HAR Dataset/train/Y_train.txt",header=FALSE)
ytest<-read.table(file="UCI HAR Dataset/test/Y_test.txt",header=FALSE)
Activity<-c(ytrain[,1],ytest[,1])
alabels<-read.table(file="UCI HAR Dataset/activity_labels.txt",header=FALSE)

##Create a dataframe of the data
df<-rbind(xtrain,xtest)
names(df)<-features[,2]
dfcomplete<-cbind(Subject,Activity,df)

##Use plyr and dplyr libraries

library(plyr)
library(dplyr)
dfc<-tbl_df(dfcomplete)

##Choose data with mean() or std() in column title, remove meanFreq columns
dfc<-select(dfc,Subject,Activity,contains("-mean()"),contains("-std()"),-contains("meanFreq"))

##Replace the numbers for activities with their names
m<-merge(dfc,alabels,by.x="Activity",by.y="V1",all=TRUE)
m<-select(m,-Activity)
m<-rename(m,c("V2"="Activity"))
m<-m[,c(1,68,2:67)]

##Make the data names a bit more user friendly
n<-names(m)
n<-n[3:68]
n<-sub("-X", "_on_X_axis",n)
n<-sub("-Y", "_on_y_axis",n)
n<-sub("-Z", "_on_z_axis",n)
n<-sub("Jerk", "_jerk",n)
n<-sub("-std", "_sd",n)
n<-sub("-mean", "_mean",n)
n<-sub("[(]","",n)
n<-sub("[)]","",n)
n<-c("Subject","Activity",n)
names(m)<-n

##tidy the data and find the mean by Subject number and activity
tidydata<-aggregate(. ~ Subject+Activity,data=m,FUN=mean)
tidydata<-tbl_df(tidydata)
tidydata<-arrange(tidydata,Subject)

##Write this data to file
write.table(tidydata,row.names=FALSE,file="tidydata.txt")
