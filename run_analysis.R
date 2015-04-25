# run_analysis.R is a script that:
# 1. Merges training and test sets to create one data set.
# 2. Extracts only mean and standard deviation values for each measurement. 
# 3. Uses descriptive names to name the activities in the data set
# 4. Labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#
# Libraries used:
library("plyr")
###############################################################################

# Code to read all necessary files to create correspondent data frames.
# Note: read.table(file=file.choose()) allows user to manually choose file to be read.

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Code to rename columns of the data frames
names(features) <- c("ID","feature")
names(x_train)<-features$feature
names(y_train)<-c("activity_label")
names(subject_train)<-c("subject")
names(x_test)<-features$feature
names(y_test)<-c("activity_label")
names(subject_test)<-c("subject")
#names(activity_labels)<-c("activity_label_id","activity_label")

# Code to replace activities numbes by descriptive activity names
y_train$activity_label[y_train$activity_label == 1] <- as.vector(activity_labels$V2)[1]
y_train$activity_label[y_train$activity_label == 2] <- as.vector(activity_labels$V2)[2]
y_train$activity_label[y_train$activity_label == 3] <- as.vector(activity_labels$V2)[3]
y_train$activity_label[y_train$activity_label == 4] <- as.vector(activity_labels$V2)[4]
y_train$activity_label[y_train$activity_label == 5] <- as.vector(activity_labels$V2)[5]
y_train$activity_label[y_train$activity_label == 6] <- as.vector(activity_labels$V2)[6]

y_test$activity_label[y_test$activity_label == 1] <- as.vector(activity_labels$V2)[1]
y_test$activity_label[y_test$activity_label == 2] <- as.vector(activity_labels$V2)[2]
y_test$activity_label[y_test$activity_label == 3] <- as.vector(activity_labels$V2)[3]
y_test$activity_label[y_test$activity_label == 4] <- as.vector(activity_labels$V2)[4]
y_test$activity_label[y_test$activity_label == 5] <- as.vector(activity_labels$V2)[5]
y_test$activity_label[y_test$activity_label == 6] <- as.vector(activity_labels$V2)[6]

# Code to create ID column for the data frames
x_train$ID<-seq.int(nrow(x_train))
y_train$ID<-seq.int(nrow(y_train))
subject_train$ID<-seq.int(nrow(subject_train))
x_test$ID<-seq.int(nrow(x_test))
y_test$ID<-seq.int(nrow(y_test))
subject_test$ID<-seq.int(nrow(subject_test))

# Code to merge data frames
dftrainList<- list(x_train,y_train,subject_train)
dftrain<-join_all(dftrainList)

dftestList<-list(x_test,y_test,subject_test)
dftest<-join_all(dftestList)

df <- rbind(dftrain,dftest)
df$ID<-seq.int(nrow(df))

# Code to extracts only mean and standard deviation values for each measurement and
# to create a data set with the average of each variable for each activity and each subject.
vec<-names(df)[grep('mean()', names(df), fixed=TRUE)]
vec2<-names(df)[grep('std()', names(df), fixed=TRUE)]
vec3<-c(vec,vec2)
df_melt<-melt(df, id=c("ID", "activity_label", "subject"), measure.vars=vec3)
df_tidy<-dcast(df_melt, activity_label + subject ~ variable, mean)

# Code to write the txt file with the tidy data set in the working directory
write.table(df_tidy, file="./df_tidy.txt", row.names=FALSE)