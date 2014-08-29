
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

gneuralnetwork<-function(formula,cv,testData,trainData, projectedCols ){


  model<-train(formula,data=trainData,method='avNNet',maxit=1000,
                            trControl=cv,preProcess='range',tunelength=2,trace=F)
  print(model)
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(confusionMatrix(resultTable))
}