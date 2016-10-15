# Before running this script set your working directory to the location of the unzipped files

# Load appropriate libraries required by this script
library(reshape2)

# Read the features file and normalise to give a suitable list of column names
features <- read.table('features.txt', stringsAsFactors=FALSE)
features.required <- grep('.*mean.*|.*std.*', features[,2])
feature.names <- features[,2]
feature.names <- gsub('[-\\(\\),]', '.', feature.names) # Turn all unwanted characters to .
feature.names <- gsub('(\\.)*$', '', feature.names)    # Remove trailing .s
feature.names <- gsub('(\\.)+', '.', feature.names)    # Remove duplicate .s
feature.names <- tolower(feature.names)

# Read the activity labels information
activity.labels <- read.table('activity_labels.txt', stringsAsFactors=TRUE, col.names=c('activity.id', 'activity.name'))

# Read the training data
subject.train <- read.table('train/subject_train.txt', col.names=c('subject.id'))
y.train <- read.table('train/y_train.txt', col.names=c('activity.id'))
X.train <- read.table('train/X_train.txt', col.names=feature.names)[features.required]

# Read the test data
subject.test <- read.table('test/subject_test.txt', col.names=c('subject.id'))
X.test <- read.table('test/X_test.txt', col.names=feature.names)[features.required]
y.test <- read.table('test/y_test.txt', col.names=c('activity.id'))

# Comine the subject and set the type to factor
subject.combined <- rbind(subject.train, subject.test)
subject.combined$subject.id <- as.factor(subject.combined$subject.id)

# Combine the x and y components of the training data
X.combined <- rbind(X.train, X.test)
y.combined <- rbind(y.train, y.test)

# Finally combine the X.combined, subject.combined and y.combined tables into one
combined <- cbind(subject.combined, y.combined, X.combined)

# Merge the combined table with the activity table and drop the activity.id column
data <- merge(x=activity.labels, y=combined, by.x='activity.id', by.y='activity.id')
data <- subset(data, select=-activity.id)

# Melt and then recast the data to get the required tidy dataset
data.melted <- melt(data, id=c('activity.name', 'subject.id'))
data.tidy <- dcast(data.melted, activity.name + subject.id ~ variable, mean)

# Write the file out as a .txt
write.table(data.tidy, file = "tidy.data.txt", row.names=FALSE)