library(neuralnet)
library(nnet)
library(caret)
library("e1071")
optionPrice <- function(eachRow) {return(
  eachRow[1])
  #if (eachRow[1]>0)  
  #  eachRow[1] 
  #else 
  #  (eachRow[2]+eachRow[3])/2)
}

SpxdataPreparation<-function(){
  spxdata<-read.csv("SPX_20081103_to_20081128.csv");
  spxdata$quotedate <- strptime(spxdata$quotedate, "%m/%d/%Y")
  spxdata$expiration <- strptime(spxdata$expiration, "%m/%d/%Y")
  
  spxdata$daystoexpire<-spxdata$expiration-spxdata$quotedate
  spxdata$daystoexpire<-as.numeric(spxdata$daystoexpire)
  spxdata$underlying_last<-as.numeric(spxdata$underlying_last)
  spxdata$strike<-as.numeric(spxdata$strike)
  spxdata$last<-as.numeric(spxdata$last)
  spxdata$bid<-as.numeric(spxdata$bid)
  spxdata$ask<-as.numeric(spxdata$ask)
  spxdata$optionprice<-apply(spxdata[,c('last','bid','ask')], 1, optionPrice)
  attach(spxdata)
  
}

SpxCallOptionNN<-function()
{
  
  spxcalldata<-spxdata[spxdata$type=='call',]
  spxcalldata<-spxcalldata[spxcalldata$optionprice>0,]
  spxcalldata<-spxcalldata[spxcalldata$openinterest>0,]

  
  #spxcalldata<-spxcalldata[,c('quotedate','underlying_last','strike','daystoexpire','optionprice')]
  traindata<-spxcalldata[as.Date(spxcalldata$quotedate)==as.Date('2008-11-03'),]
  testdata<-spxcalldata[as.Date(spxcalldata$quotedate)==as.Date('2008-11-04'),]
  
  print(nrow(traindata))
  print(nrow(testdata))
 
  nn <- neuralnet(optionprice ~impliedvol+delta+gamma+theta,data=traindata,hidden=c(5))
                  #,algorithm="rprop+" ,threshold=0.05)
  print(nn)
  #prediction1 <- predict(nn, newdata = testdata)
  #prediction1
}

MSFTCallOptionNN<-function()
{
  
  
}
SpxCallOptionSVM<-function()
{
  
  spxcalldata<-spxdata[spxdata$type=='call',]
  spxcalldata<-spxcalldata[spxcalldata$optionprice>100,]
  spxcalldata<-spxcalldata[spxcalldata$openinterest>100,]
  
  
  #spxcalldata<-spxcalldata[,c('quotedate','underlying_last','strike','daystoexpire','optionprice')]
  traindata<-spxcalldata[as.Date(spxcalldata$quotedate)==as.Date('2008-11-24'),]
  testdata<-spxcalldata[as.Date(spxcalldata$quotedate)==as.Date('2008-11-25'),]
  
  print(nrow(traindata))
  print(nrow(testdata))
  
  mode <- model <- svm(optionprice ~strike+daystoexpire+impliedvol+delta+gamma+theta, data=traindata,kernel = "polynomial")
  #,algorithm="rprop+" ,threshold=0.05)
  print(mode)
  predictions <- predict(model,data=testdata)
  predictions.df <-as.data.frame(predictions)
  print(length(predictions.df[,1]))
  print(length(testdata$optionprice))
 
  predictions.df.subset = predictions.df[1:length(testdata$optionprice),]
  #predictions.df.subset$optionprice = testdata$optionprice
  #predictions.df.subset
  prob <- sum( (predictions.df[1:length(testdata$optionprice),1] - testdata$optionprice)^2)/nrow(testdata)
  print(prob)
  #round(prop.table(table(pred = predictions, true = testdata$pop)))
  #prediction1
}

toubleshoot<-function(){
  set.seed(1)
  N=500
  x <- cbind(runif(N, min=1, max=500), runif(N, min=1, max=500), runif(N, min=1, max=500), runif(N, min=1, max=500), runif(N, min=1, max=500))
  
  y <- ifelse(x[,1] + 2*x[,1] + 3*x[,1] + 4*x[,1] + 5*x[,1] > 3750, 1, 0)

  x <- cbind(runif(50, min=1, max=500), runif(50, min=1, max=500))
  y <- ifelse(x[,1] + 2*x[,1] > 500, 1, 0)
  y <- x[,1] + 2*x[,1]
  print(y)
  trainSMALL <- data.frame(x[1:(N/10),], y=y[1:(N/10)])
  trainALL <- data.frame(x, y)
  n <- names(trainSMALL)
  f <- as.formula(paste('y ~', paste(n[!n %in% 'y'], collapse = ' + ')))
  netSMALL <- neuralnet(f, trainSMALL, hidden = c(2,2), threshold = 0.01)
  netALL <- neuralnet(f, trainALL, hidden = c(2,2), threshold = 0.01)
  print(netSMALL) # error 4.117671763
  print(netALL) # error 0.009598461875
    
  
  
  
}