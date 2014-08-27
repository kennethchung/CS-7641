library("partykit")
library("e1071")
library("rpart")

library("ggplot2")
library("neuralnet")

DataPreparation<-function(){
  redWine<-read.csv("winequality-red.csv",head=TRUE,sep=";")
  whiteWine<-read.csv("winequality-white.csv",head=TRUE,sep=";")
  
  redWine$quality=as.character(redWine$quality)
  whiteWine$quality=as.character(whiteWine$quality)
  
  set.seed(2)
  redtrainindex = sample(1:nrow(redWine), nrow(redWine)/2)
  redtestindex = -redtrainindex
  redtraindata = redWine[redtrainindex,]
  redtestdata = redWine[redtestindex,]
  
  whitetrainindex = sample(1:nrow(whiteWine), nrow(whiteWine)/2)
  whitetestindex = -whitetrainindex
  whitetraindata =whiteWine[whitetrainindex,]
  whitetestdata = whiteWine[whitetestindex,]


  
}


DataExamination<-function(){
  #categories <- table(whiteWine$quality)
  #barplot(categories)
  #title(main="White Wine Dataset", 
  #      xlab="Wine Quality", ylab="Frequency") 
  
  categories <- table(whiteWine$quality)
  categories
  #barplot(categories)
  #title(main="White Wine Dataset", 
  #      xlab="Wine Quality", ylab="Frequency") 
  ggplot(as.data.frame(whitetestdata), aes(y=alcohol, x=volatile.acidity, color=quality)) + geom_point(shape=2)
}

DescisionTree<-function(){
  
  trainData <-whitetraindata
  testData <- whitetestdata
  
  fol <- formula(quality  ~  fixed.acidity + volatile.acidity + citric.acid + residual.sugar + chlorides + free.sulfur.dioxide
                 +density+pH+sulphates+alcohol )
  fit<-rpart(formula=fol,data=trainData,method="class",control=rpart.control(minsplit=10))
  
  pfit<- prune(fit, cp=   fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
  fit<-pfit
  
  print(fit)
  printcp(fit)
  #plot(as.party(fit), type="simple")
  rsq.rpart(fit)
  #summary(fit)
  #plotcp(fit)
  
  prediction <-predict(fit,testData,type="class")
  
  pred.df <-as.data.frame(prediction)
  
  prob <- sum(pred.df[,1] == testData$quality) /nrow(testData)
  print(prob)
  print(table(testData$quality,prediction))
}

neuralNetwork<-function(trainData1, testData1, factor){
  
  set.seed(2)
  trainindex = sample(1:nrow(trainData1), nrow(trainData1)/factor)
  testindex = sample(1:nrow(testData1), nrow(testData1)/factor)
  trainData = trainData1[trainindex,]
  testData = testData1[testindex,]


  trainData <- cbind(trainData, trainData$quality == '1')
  trainData <- cbind(trainData, trainData$quality == '2')
  trainData <- cbind(trainData, trainData$quality == '3')
  trainData <- cbind(trainData, trainData$quality == '4')
  trainData <- cbind(trainData, trainData$quality == '5')
  trainData <- cbind(trainData, trainData$quality == '6')
  trainData <- cbind(trainData, trainData$quality == '7')
  trainData <- cbind(trainData, trainData$quality == '8')
  trainData <- cbind(trainData, trainData$quality == '9')
  names(trainData)[13] <- 'G1'
  names(trainData)[14] <- 'G2'
  names(trainData)[15] <- 'G3'
  names(trainData)[16] <- 'G4'
  names(trainData)[17] <- 'G5'
  names(trainData)[18] <- 'G6'
  names(trainData)[19] <- 'G7'
  names(trainData)[20] <- 'G8'
  names(trainData)[21] <- 'G9'
  

  fol <- formula(G1+G2+G3+G4+G5+G6+G7+G8+G9  ~ volatile.acidity + density+alcohol)
  nn <- neuralnet(fol,data=trainData,hidden=c(3,3))
  plot(nn)
  prediction <- compute(nn, testData[
    c('volatile.acidity','density','alcohol')])$net.result
  

  
  maxidx <- function(arr) {return(which(arr == max(arr)))}
  idx <- apply(prediction, c(1), maxidx)
  prediction_matrix <- c('G1', 'G2','G3', 'G4','G5', 'G6','G7', 'G8','G9')[idx]
  pred.df <-as.data.frame(prediction_matrix)
  
  prob <- sum(pred.df[,1] == paste('G',as.character(testData$quality),sep = "")) /nrow(testData)
  print(prob)
  print(table(testData$quality,prediction_matrix))
  print(nn$result.matrix)
}


