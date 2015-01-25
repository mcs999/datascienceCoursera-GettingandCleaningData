### written by mcs999. Submitted on 26 Jan 2015 on github for Coursera course - Getting and Cleaning Data

run_analysis <-function(){
        
### Step 1 Create one dataset by merging train and test        
#### read files from train and merge, do the same for test
        subject_train <- read.table("train/subject_train.txt")
        X_train <- read.table("train/X_train.txt")
        y_train <- read.table("train/y_train.txt")
        
        subject_test <- read.table("test/subject_test.txt")
        X_test <- read.table("test/X_test.txt")
        y_test <- read.table("test/y_test.txt")
        
        
        merged_train <-cbind(X_train,subject_train,y_train)
        merged_test <- cbind(X_test,subject_test,y_test)
        
        #write.csv(merged_train,"merged_train.csv",row.names=FALSE)
        #write.csv(merged_test,"merged_test.csv",row.names=FALSE)
        merged_train_test <- rbind(merged_train, merged_test)
        #write.csv(merged_train_test,"merged_train_test.csv",row.names=FALSE)
### Step 2 extract only mean and std from features

#### read features and assign column names
        features<- read.table("features.txt")
        listofNames <-as.character(features[,2]) 
        listxx <- make.names(listofNames, unique=TRUE)

        data<- merged_train_test
        colnames(data)<- c(listxx, "subject","activity" ) 
#### extract mean() and std columns from features
#### find position of mean and std then merge mean&std data with
#### subject and activity columns
        matches <- grep("mean\\.\\.|std",listxx)
        data1 <- data[,matches]
        data1 <- cbind(data1,data$subject, data$activity)
        colnames(data1)[67] <- "subject"
        colnames(data1)[68] <- "activity"
        #write.csv(data1,"data1_step2.csv",row.names=FALSE)

### Step 3 put descriptive name to data in activity column
        act.label <- rbind("Walking","Walking Up","Walking Down","Sitting","Standing","Laying")
        num.subj <- 30
#### find position of each value of activity then put appropriate labels        
        one <- grep("1",data1$activity)    
        two <- grep("2",data1$activity)
        three <- grep("3",data1$activity)
        four <- grep("4",data1$activity)
        five <- grep("5",data1$activity)
        six <- grep("6",data1$activity)
        data1$activity[one] <- act.label[1]
        data1$activity[two] <- act.label[2]
        data1$activity[three] <- act.label[3]
        data1$activity[four] <- act.label[4]
        data1$activity[five] <- act.label[5]
        data1$activity[six] <- act.label[6]
        write.csv(data1,"data1_descrip.csv",row.names=FALSE)

        
### Step 4  Label the dataset with appropriate variable names       
        cname <- colnames(data1)        
#### 4.1 fix BodyBody to be only "Body"
        c_match <- grep("BodyBody",cname)
        oneBody <- gsub("BodyBody","Body",cname[c_match])
        cname[c_match] <- oneBody

#### 4.2 change ... to . (should be done before changing .. to .)

        three_dot <- grep("\\.\\.\\.",cname)
        cname[three_dot] <- gsub("\\.\\.\\.","\\.",cname[three_dot])

#### 4.3 fix 2 dots

        two_dots  <- grep("\\.\\.",cname)
        cname[two_dots] <- gsub("\\.\\.","",cname[two_dots])

#### 4.4 tBody to timeBody, fBody to freqBody

        tBody <- grep("tBody",cname)
        cname[tBody] <- gsub("tBody","timeBody",cname[tBody])
        fBody <- grep("fBody",cname)
        cname[fBody] <- gsub("fBody","freqBody",cname[fBody])

#### 4.5 acc to accel
        Acc <- grep("Acc",cname)
        cname[Acc]<- gsub("Acc","Accel",cname[Acc])
#### assign 4.1 to 4.5 to column names of data1
        colnames(data1) <- cname

        
        
### Step 5 generate independent file for mean values###
        data1.step5 <- data.frame()
        for (i in 1:num.subj ){
                for (j in 1:6  ) {
                        
                         dt <- data1[data1$subject == i & data1$activity == act.label[j],]
                         dt <- dt[,-(67:68)]
                         dt.mean <- colMeans(dt)
                         #data1.step5 <- rbind(data1.step5, cbind(dt.mean, data1$subject == i,data1$activity == act.label[j])
                         #dt.mean$subject <- i
                         #cat("act.label =",act.label[j],"\n")
                         #dt.mean$activity <- act.label[j]
                         #cat("dt.mean 2 last col =")
                         #print(dt.mean[67:68])
                         
                         # Use matrix cause the colname gone but can put it back later
                         dt.mean <- matrix(dt.mean,1,)
                         dt.mean <- cbind(dt.mean,i,act.label[j])
                         
                         data1.step5 <- rbind(data1.step5,dt.mean)
                         
                }
        }        
        colnames(data1.step5) <- colnames(data1)
        #cat(dim(data1.step5),"\n")
        write.csv(data1.step5,"data1_step5.csv",row.names=FALSE)
        write.table(data1.step5,"data1_step5.txt",row.names=FALSE)
}