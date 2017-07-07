##################################################################################################
##  The script is part of the Getting and Cleaning Data Course Assignment.
##  The following site is being acknowledged for providing the data for this assignment       
##  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
##  The output of the script will be a tidy dataset with means calculated for feture variables
##  for each subject and activity
##################################################################################################


# Set working directory
setwd("/media/suhail/A2E44376E4434BAB/R/courseradata/UCI HAR Dataset")

library(data.table)
library(dplyr)

# read file with activity labels

activity_labels  <- fread("./activity_labels.txt")

# read train datsets - from the main train dataset, select only relevant columns (columns with mean and Sd)
# also rename the column names for the narrow data frames

subject_train <- fread("./train/subject_train.txt")
colnames(subject_train) <- "SubjectId"

x_train <- fread("./train/X_train.txt")
x_train <- x_train[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429
                      ,503:504,516:517,529:530,542:543)]


y_train <- fread("./train/y_train.txt")
# Add activity labels to the train data
y_train <- merge(x=y_train,y=activity_labels)
y_train$V1 <-NULL
colnames(y_train) <- "Activity_label"

#combine the train dataset parts
train <- cbind(subject_train,y_train,x_train)


# read test datsets - from the main test dataset, select only relevant columns (columns with mean and Sd)
# also rename the column names for the narrow data frames

subject_test <- fread("./test/subject_test.txt")
colnames(subject_test) <- "SubjectId"

x_test <- fread("./test/X_test.txt")
x_test <- x_test[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429
                      ,503:504,516:517,529:530,542:543)]

y_test <- fread("./test/y_test.txt")
# Add activity labels to the train data
y_test <- merge(x=y_test,y=activity_labels)
y_test$V1 <-NULL
colnames(y_test) <- "Activity_label"


#combine the test dataset parts
test <- cbind(subject_test,y_test,x_test)


#Create one dataset with a list of all observations
data <- rbind(train,test)


#rename the column names to make them more intuitive

data <- data %>% rename(
    tBodyAccMeanX = V1,
    tBodyAccMeanY = V2,
    tBodyAccMeanZ = V3,
    tBodyAccSdX = V4,
    tBodyAccSdY =V5,
    tBodyAccSdZ = V6,
    tGravityAccMeanX = V41,
    tGravityAccMeanY = V42,
    tGravityAccMeanZ = V43,
    tGravityAccSdX = V44,
    tGravityAccSdY = V45,
    tGravityAccSdZ = V46,
    tBodyAccJerkMeanX = V81,
    tBodyAccJerkMeanY = V82,
    tBodyAccJerkMeanZ = V83,
    tBodyAccJerkSdX = V84,
    tBodyAccJerkSdY = V85,
    tBodyAccJerkSdZ = V86,
    tBodyGyroMeanX = V121,
    tBodyGyroMeanY = V122,
    tBodyGyroMeanZ = V123,
    tBodyGyroSdX = V124,
    tBodyGyroSdY = V125,
    tBodyGyroSdZ = V126,
    tBodyGyroJerkMeanX = V161,
    tBodyGyroJerkMeanY = V162,
    tBodyGyroJerkMeanZ = V163,
    tBodyGyroJerkSdX = V164,
    tBodyGyroJerkSdY = V165,
    tBodyGyroJerkSdZ = V166,
    tBodyAccMagMean = V201,
    tBodyAccMagSd = V202,
    tGravityAccMagMean = V214,
    tGravityAccMagSd = V215,
    tBodyAccJerkMagMean = V227,
    tBodyAccJerkMagSd = V228,
    tBodyGyroMagMean = V240,
    tBodyGyroMagSd = V241,
    tBodyGyroJerkMagMean = V253,
    tBodyGyroJerkMagSd = V254,
    fBodyAccMeanX = V266,
    fBodyAccMeanY = V267,
    fBodyAccMeanZ = V268,
    fBodyAccSdX = V269,
    fBodyAccSdY = V270,
    fBodyAccSdZ = V271,
    fBodyAccJerkMeanX = V345,
    fBodyAccJerkMeanY = V346,
    fBodyAccJerkMeanZ = V347,
    fBodyAccJerkSdX = V348,
    fBodyAccJerkSdY = V349,
    fBodyAccJerkSdZ = V350,
    fBodyGyroMeanX = V424,
    fBodyGyroMeanY = V425,
    fBodyGyroMeanZ = V426,
    fBodyGyroSdX = V427,
    fBodyGyroSdY = V428,
    fBodyGyroSdZ = V429,
    fBodyAccMagMean = V503,
    fBodyAccMagSd = V504,
    fBodyBodyAccJerkMagMean = V516,
    fBodyBodyAccJerkMagSd = V517,
    fBodyBodyGyroMagMean = V529,
    fBodyBodyGyroMagSd = V530,
    fBodyBodyGyroJerkMagMean = V542,
    fBodyBodyGyroJerkMagSd = V543
)


# create summary by subject and activity
data2 <- data %>% 
  group_by(SubjectId,Activity_label) %>%
  summarize_all(mean,na.rm=TRUE)


# write the tidy dataset to file
write.table(data2,file="./tidy_UCI_HAR_data.txt",row.names=FALSE,sep=" ")


