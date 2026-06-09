library(reshape2)

# Establecer directorio de trabajo (ajústalo a tu ruta)
setwd("C:/Downloads/project")



# Cargar actividad y features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Seleccionar variables de media y desviación estándar
featuresWanted <- grep("mean\\(\\)|std\\(\\)", features[,2])
featuresWanted.names <- features[featuresWanted,2]

# Limpiar nombres
featuresWanted.names <- gsub('-mean\\(\\)', 'Mean', featuresWanted.names)
featuresWanted.names <- gsub('-std\\(\\)', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# Cargar datos de entrenamiento
train <- read.table("UCI HAR Dataset/train/X_train.txt")[,featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

train <- cbind(subject = trainSubjects[,1],
               activity = trainActivities[,1],
               train)

# Cargar datos de test
test <- read.table("UCI HAR Dataset/test/X_test.txt")[,featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(subject = testSubjects[,1],
              activity = testActivities[,1],
              test)

# Unir datasets
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# Convertir a factores
allData$activity <- factor(allData$activity,
                           levels = activityLabels[,1],
                           labels = activityLabels[,2])

allData$subject <- factor(allData$subject)

# Crear dataset tidy (media por sujeto y actividad)
allData.melted <- melt(allData, id = c("subject", "activity"))
tidyData <- dcast(allData.melted, subject + activity ~ variable, mean)

# Guardar archivo en la misma carpeta
write.table(tidyData, "tidy.txt", row.names = FALSE, quote = FALSE)
