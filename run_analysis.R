# Read all test and train data sets
testData <- read.table("test/X_test.txt")
testSubject <- read.table("test/subject_test.txt")
testLabel <- read.table("test/y_test.txt")

trainData <- read.table("train/X_train.txt")
trainSubject <- read.table("train/subject_train.txt")
trainLabel <- read.table("train/y_train.txt")

# Row bind them all into three data sets and name them

XTotal <- rbind(testData, trainData)
SubjectTotal <- rbind(testSubject, trainSubject)
YTotal <- rbind(testLabel, trainLabel)

names(SubjectTotal) <- "Subjects"
names(YTotal) <- "Activities" 

# Store features names from features.txt into a vector
featuresnames <- read.table("features.txt", stringsAsFactors=FALSE, colClasses = c("NULL", "character"))$V2

# Store which columns have mean or standard deviation
columns <- grepl("(std|mean[^F])", featuresnames, perl=TRUE)

# Get only columns we are interested in and stripe the names of parenthesis
XTotal <- XTotal[, columns]
names(XTotal) <- gsub("\\(|\\)", "", featuresnames[columns])

# Store activities names
activities <- read.table("activity_labels.txt")
YTotal[,1] = activities[YTotal[,1], 2]

# Column bind them and write to totalData.txt
totalData <- cbind(SubjectTotal, YTotal, XTotal)

# Create data set with average of each variable for each activity and each subject
library(plyr);
tidy <-aggregate(. ~Subjects + Activities, totalData, mean)
tidy <- tidy[order(tidy$Subjects,tidy$Activities),]
write.table(tidy, file = "tidy.txt",row.name=FALSE)