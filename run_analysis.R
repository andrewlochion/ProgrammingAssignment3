library(dplyr)

# Read test data
#data_x_test      <- tbl_df(read.table("UCI HAR Dataset/test/x_test.txt",sep="",header=FALSE))
#data_y_test      <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE))
#data_subj_test   <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE))
data_x_test      <- tbl_df(read.table("x_test.txt",sep="",header=FALSE))
data_y_test      <- tbl_df(read.table("y_test.txt",header=FALSE))
data_subj_test   <- tbl_df(read.table("subject_test.txt",header=FALSE))

# Read train data
#data_x_train     <- tbl_df(read.table("UCI HAR Dataset/train/x_train.txt",sep="",header=FALSE))
#data_y_train     <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE))
#data_subj_train  <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE))
data_x_train     <- tbl_df(read.table("x_train.txt",sep="",header=FALSE))
data_y_train     <- tbl_df(read.table("y_train.txt",header=FALSE))
data_subj_train  <- tbl_df(read.table("subject_train.txt",header=FALSE))

# Merge test & train data
data_x_merged    <- merge(data_x_test,data_x_train,all=TRUE)
data_y_merged    <- bind_rows(data_y_test,data_y_train)       # merge function fails
data_subj_merged <- merge(data_subj_test,data_subj_train,all=TRUE)

# Rename column names of activity and subject dataset
colnames(data_y_merged) <- "Activity_number"
colnames(data_subj_merged) <- "Subject"

# Substitute numbers with activity in activity dataset
activity <- tbl_df(read.delim("UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE))
colnames(activity)<-c("Activity_number","Activity")
data_y_merged_changed <- data_y_merged
data_y_merged_changed <- inner_join(data_y_merged_changed,activity)

# Rename column names of main dataset
x_names <- tbl_df(read.delim("UCI HAR Dataset/features.txt",sep="",header=FALSE))
x_names$V2 <- gsub("\\(\\)","",x_names$V2)
colnames(data_x_merged) <- x_names$V2

# Select mean and std
list <- intersect(grep("mean|std",x_names$V2), grep("meanFreq",x_names$V2,invert=TRUE))
data_merged_combined <- cbind(data_y_merged_changed[,'Activity'],data_subj_merged,data_x_merged[,list])

# Output table
write.table(file='project_tidydataset.txt',data_merged_combined,row.name=FALSE)

# Calculating average of each variable
data_grouped <- group_by(data_merged_combined, Activity, Subject)
data_grouped_mean <- summarize_each(data_grouped,funs(mean))

# Output table
write.table(file='project_tidydataset_average.txt',data_grouped_mean,row.name=FALSE)