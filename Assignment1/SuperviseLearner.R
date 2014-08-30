
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

gnn<-function(formula,cv,testData,trainData,nnpkg,iter ){

  
  model<-train(formula,data=trainData,method=nnpkg,maxit=iter,
                            trControl=cv,preProcess='range',tunelength=5,trace=F)
  print(model)
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(resultTable)
  print(confusionMatrix(resultTable))
}


gsvm<-function(formula,cv,testData,trainData, svmMethod ){
  
  
  model<-train(formula,data=trainData,method=svmMethod,maxit=1000,
               trControl=cv,preProcess='range',tunelength=5,trace=F)
  print(str(model))
  print(model)
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(confusionMatrix(resultTable))
}

gknn<-function(formula,cv,testData,trainData ){
  
  knn_opts = data.frame(.k=c(1,2,3,5,10,20,30,50))
  model <- train(formula, data = trainData, method = "knn", 
                  trControl = cv,preProcess='range', tuneGrid=knn_opts)
  #print(str(model))
  print(model)
  dotPlot(varImp(model))
  prediction <- predict(model, testData)
  print(resultTable=table(actual=testData$myquality,prediction=prediction))
  print(confusionMatrix(prediction,testData$myquality))
}

giris<-function(){

  
  knn_opts = data.frame(.k=c(1))
  model <- train(Species~., data = iris, method = "knn", 
                 trControl = trainControl(method='cv',number=3),preProcess='range', tuneGrid=knn_opts)
  print(str(model))
  print(model)
  
  prediction <- predict(model, iris)
  print(prediction)
  resultTable=table(iris$Species,prediction)
  

  confusionMatrix(prediction, iris$Species)
  
}