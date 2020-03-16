
library(dplyr)
library(reshape2)
library(tidyr)

##File path to downloaded unzipped folder
file <- "C:/Users/nbate/Downloads/UCI HAR Dataset/"

train.files <- list.files(paste0(file,"train/"))
train.files <- train.files[!train.files %in% c("Inertial Signals")]
test.files <- list.files(paste0(file,"test/"))
test.files <- test.files[!test.files %in% c("Inertial Signals")]
df <- read.table(paste0(file,"activity_labels.txt"))
colnames(df) <- c("code","posture")

train <- read.table(paste0(file,"train/",train.files[1]))
tmp <- read.table(paste0(file,"train/",train.files[3]))
train <- cbind(train, tmp)
colnames(train) <- c("participant","code")
tmp2 <- read.table(paste0(file,"train/",train.files[2]))
train <- cbind(train,tmp2)

test <- read.table(paste0(file,"test/",test.files[1]))
tmp <- read.table(paste0(file,"test/",test.files[3]))
test <- cbind(test, tmp)
colnames(test) <- c("participant","code")
tmp2 <- read.table(paste0(file,"test/",test.files[2]))
test <- cbind(test,tmp2)

all <- rbind(test,train)
all <- merge(df, all)
features <- read.table(paste0(file,"features.txt"))
name <- as.vector(features$V2)
colnames(all)[4:564] <- name 

all2 <- melt(all, id.vars = c("participant","code","posture"))
all2 <- all2[grepl("std",all2$variable)==T|grepl("mean",all2$variable)==T,]

means <- all2 %>% group_by(participant,posture,variable) %>% summarise(
  mean = mean(value, na.rm = T),
)

means.wide <- spread(means, variable, mean)
