
DataSummary<-function(){
  
  #print(summary(WineDataset))
  #corrplot(cor(WineDataset[,-c(13,14)]),method='number',tl.cex=0.5)
  #categories <- table(WineDataset$quality3)
  #barplot(categories)
  #title(main="Wine Dataset", xlab="Wine Quality")
  testDataRows = nrow(testDataset)
  trainDataRows = nrow(trainDataset)
  testPct = 100*round(testDataRows/(testDataRows+trainDataRows),digits=2)
  trainPct = 100-testPct
  
  lbls <- c(paste("Test",nrow(testDataset),testPct,"%"), paste("Training",nrow(trainDataset),trainPct,"%"))
  pie3D(c(nrow(testDataset),nrow(trainDataset)), labels = lbls,  main="Training / Test Dataset")
}

gneuralnetwork<-function(formula,cv,testData,trainData ){


  model<-train(formula,data=trainData,method='avNNet',maxit=10,
                            trControl=cv,preProcess='range',tunelength=5,trace=F)
 
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(confusionMatrix(resultTable))
}


gsvm<-function(formula,cv,testData,trainData, svmMethod ){
  
  nn_opts=data.frame(.hidden=c(10,10))
  model<-train(formula,data=trainData,method=svmMethod,maxit=1000,
               trControl=cv,preProcess='range',tunelength=5,trace=F)
  print(model)
  
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(confusionMatrix(resultTable))
}

gknn<-function(formula,cv,testData,trainData ){
  
  knn_opts = data.frame(.k=c(seq(1,10,3),20,30,50))
  model <- train(formula, data = trainData, method = "knn", 
                  trControl = cv,preProcess='range', tuneGrid=knn_opts)
  print(model)
  #prediction <- predict(model, testData)
  #resultTable=table(actual=testData$myquality,prediction=prediction)
  #print(confusionMatrix(resultTable))
}