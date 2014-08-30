library(partykit)
library(e1071)
library(rpart)

library(ggplot2)
library(neuralnet)

library(nnet)
library(caret)
library(randomForest)
library(ipred)
library(kernlab)
library(rgl)
library(misc3d)
library(class)
library(RWeka)
library(foreign)
library(doSNOW)
registerDoSNOW(makeCluster(3,type="SOCK"))
DataPreparation<-function(){


  redWine<-read.csv("winequality-red.csv",head=TRUE,sep=";")
  whiteWine<-read.csv("winequality-white.csv",head=TRUE,sep=";")
  
  redWine$quality=as.character(redWine$quality)
  whiteWine$quality=as.character(whiteWine$quality)
  redWine$quality=as.factor(redWine$quality) 
  whiteWine$quality=as.factor(whiteWine$quality)

  
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
  #rsq.rpart(fit)
  #summary(fit)
  #plotcp(fit)
  
  prediction <-predict(fit,testData,type="class")
  
  pred.df <-as.data.frame(prediction)
  
  prob <- sum(pred.df[,1] == testData$quality) /nrow(testData)
  print(prob)
  print(table(testData$quality,prediction))
}


DescisionTree1<-function(){
  
  trainData <-whitetraindata
  testData <- whitetestdata
  
  print(head(trainData))
  fol <- formula(quality  ~  fixed.acidity + volatile.acidity + citric.acid + residual.sugar + chlorides + free.sulfur.dioxide
                +density+pH+sulphates+alcohol )
  #fit<-rpart(formula=fol,data=trainData,method="class",control=rpart.control(minsplit=10))
  #fit <- J48(fol, data = trainData)
  fit <- J48(fol, data = trainData)
  #pfit<- prune(fit, cp=   fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
  #fit<-pfit
  #print(summary(fit))
 
  eval_fit <- evaluate_Weka_classifier(fit, newdata=testData, numFolds = 100, complexity = FALSE, 
                                       seed = 1, class = TRUE)
  
  print(eval_fit)
  prediction <- predict(fit, data=testData,type='class')
  
  #printcp(fit)
  #plot(as.party(fit), type="simple")
  #rsq.rpart(fit)
  #summary(fit)
  #plotcp(fit)
  
  #prediction <-predict(fit,testData,type="class")
  
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
  nn <- neuralnet(fol,data=trainData,hidden=c(2))
  #str(nn)
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

mysvm<-function(trainData, testData){

  
  fol <- formula(quality  ~  fixed.acidity + volatile.acidity + citric.acid + residual.sugar 
                 + chlorides + free.sulfur.dioxide
                 +density+pH+sulphates+alcohol )
  model <- svm(quality~., data=trainData,type='C-classification')
  print(model)

  
  
  #plot(model, trainData, fixed.acidity~alcohol)
  #plot(model, trainData, volatile.acidity ~alcohol)
  #plot(model, trainData, citric.acid~alcohol)
  #plot(model, trainData, residual.sugar~alcohol)
  #plot(model, trainData, chlorides~alcohol)
  #plot(model, trainData, free.sulfur.dioxide~alcohol)
  plot(model, trainData, density~alcohol,svSymbol = 10, dataSymbol = 4)
  #plot(model, trainData, pH~alcohol)
  #plot(model, trainData, sulphates~alcohol)
  
  predictions <- predict(model,testData, decision.values=T)
  

  pred.df <-as.data.frame(predictions)
  prob <- sum(pred.df[,1] == testData$quality) /nrow(testData)
  print(prob)

  
  print(table( true = testData$quality,pred = predictions))
 
}

mysvmThreeClass<-function(trainData, testData){
  
  trainData$quality=as.numeric(trainData$quality)
  testData$quality=as.numeric(testData$quality)
  

  trainData$qualityThreeClass<-apply(trainData[,c('quality','alcohol')], 1, QualityClass)
  testData$qualityThreeClass<-apply(testData[,c('quality','alcohol')], 1, QualityClass)
  head(testData[-12])
  model <- svm(qualityThreeClass~., data=trainData[,c('volatile.acidity','alcohol','qualityThreeClass')],type='C-classification')
  print(str(model))
  print(length(trainData$alcohol))
  print(length(trainData$volatile.acidity))
  
  
  predictions <- predict(model,testData[,c('volatile.acidity','alcohol','qualityThreeClass')])
  pred.df <-as.data.frame(predictions)
  prob <- sum(pred.df[,1] == testData$qualityThreeClass) /nrow(testData)
  print(prob)
  plot(model, testData[,c('volatile.acidity','alcohol','qualityThreeClass')], volatile.acidity~alcohol)
  
 
  print(table( true = testData$qualityThreeClass,pred = predictions))

  
}


myknn<-function(trainData, testData, k){
  
  
  cl=factor(trainData$quality)
  
  par(mfrow=c(2,2))
  result<-knn(trainData[-12], testData[-12], cl,k)
  #s=split(sample(nrow(iris)),rep(1:3,length=nrow(iris)))
  plot(result)
  title(main=paste(k,"nearest neighbors",sep="-"), 
        xlab="Quality", ylab="Frequency") 
  

  
  summary(result)

  print(table( true = testData$quality,pred = result))
  
  result.df = as.data.frame(result)
  prob <- sum(result.df[,1] == testData$quality) /nrow(testData)
  print(prob)
}

QualityClass <- function(eachRow) {
  return(
    if (eachRow[1]>0 && eachRow[1]<4){
        'good' 
     
    }else if (eachRow[1]>4 && eachRow[1]<7){
        'better'
    }
    else{
      'best'
    }
    )
}

simpleknn<-function(){
  
  # Class A cases
  A1=c(0,0)
  A2=c(1,1)
  A3=c(2,2)
  
  # Class B cases
  B1=c(6,6)
  B2=c(5.5,7)
  B3=c(6.5,5)
  
  # Build the classification matrix
  train=rbind(A1,A2,A3, B1,B2,B3)
  print(train)
  # Class labels vector (attached to each class instance)
  cl=factor(c(rep("A",3),rep("B",3)))
  
  # The object to be classified
  test=rbind(c(4, 4),c(0, 1))

  
  # call knn() and get its summary
  result<-knn(train, test, cl, k = 2)
  plot(result)
  summary(knn(train, test, cl, k = 1))
 
}


