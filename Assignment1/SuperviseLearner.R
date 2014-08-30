
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

gnn<-function(formula,cv,trainData,testData,nnpkg,iter ){

  nodes<-ncol(trainData)-1
 
  mlpGrid <- data.frame(.size=c(2,2))
  
  if (nnpkg=='avNNet')
    model<-train(formula,data=trainData,method=nnpkg,maxit=iter,
                            trControl=cv,preProcess='range',trace=F)
  else if (nnpkg=='mlp')
    model<-train(formula,data=trainData,method=nnpkg,maxit=iter,
                 trControl=cv,preProcess='range',trace=F)

  print(model)
  prediction <- predict(model, testData,type="class")
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(resultTable)
  print(caret::confusionMatrix(resultTable))
}


gtree<-function(formula,cv,trainData,testData,cp ){
  
  # tuneLenght is used to evaluate a broader set of models
  # Default tree with pruning
  # Use the cp (Complexity Parameter) to simulate over pruning, under pruning
  cp_opts = data.frame(.cp=c(cp))
  
  if (cp >0)
    model<-train(formula,data=trainData,method='rpart',tuneGrid=cp_opts,trControl=cv,
                 preProcess='range',tuneLength=30)
  else
    model<-train(formula,data=trainData,method='rpart',trControl=cv,preProcess='range',
                 tuneLength=30 )
  print(model)
  
  plot(as.party(model$finalModel), type="simple")
  text(model$finalModel)
  prediction <- predict(model, testData, type="class")
  
  # prediction using probability
  #prediction <- predict(model, testData, type="prob")
  
  resultTable=table(actual=testData$myquality,prediction=prediction)
  # Use the confusiont to evaluate the result
  print(caret::confusionMatrix(resultTable))
}

gbtree<-function(formula,cv,trainData,testData,trials ){
  
  # use trial to simulate boosting vs overfitting
  btree_opts = data.frame(.model="tree",.trials=c(1:trials),.winnow=FALSE)
  # tuneLenght is used to evaluate a broader set of models
  if (trials>0)
    model<-train(formula,data=trainData,method='C5.0',trControl=cv,
                 preProcess='range',tuneLength=30,tuneGrid=btree_opts)
  else
    # default # of trials
    model<-train(formula,data=trainData,method='C5.0',trControl=cv,
                 preProcess='range',tuneLength=30)
  print(model)
  #plotcp(model$finalModel)
  #plot(as.party(model$finalModel), type="simple")
  #text(model$finalModel)
  #prediction <- predict(model, testData, type="class")
  prediction <- predict(model, testData, type="prob")
  head(prediction)
  maxidx <- function(arr) {return(which(arr == max(arr)))}
  idx <- apply(prediction, c(1), maxidx)
  prediction_matrix <- c('Best', 'Better','Good')[idx]
  pred.df <-as.data.frame(prediction_matrix)
  resultTable=table(actual=testData$myquality,prediction=pred.df[,1])
  print(caret::confusionMatrix(resultTable))
}



gsvm<-function(formula,cv,trainData,testData, svmMethod ){
  
  # tune C, the cost parameter
  # tune kernel type
  #svmcost_opts = data.frame(.C=2^seq(-5,5,len=5))
  svmcost_opts = data.frame(.C=c(2^-2,0.5,1,1.5))
  
  model<-train(formula,data=trainData,method=svmMethod,
               trControl=cv,preProcess='range',trace=F,tuneLength=30,tuneGrid=svmcost_opts)
  
  
  print(model)
  prediction <- predict(model, testData,type="class")
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(caret::confusionMatrix(resultTable))
}

gknn<-function(formula,cv,trainData,testData){
  
  # Tuning Parameter on k
  # Determine k with  highest accuracy
  knn_opts = data.frame(.k=c(1,2,3,5,10,20,30,50))
  
  model <- train(formula, data = trainData, method = "knn", 
                  trControl = cv,preProcess='range', tuneGrid=knn_opts)
  print(model)
  dotPlot(varImp(model))
  prediction <- predict(model, testData,type="class")
  resultTable=table(actual=testData$myquality,prediction=prediction)
  print(caret::confusionMatrix(resultTable))
}

giris<-function(){

  
  #knn_opts = data.frame(.k=c(1))
  #model <- train(Species~., data = iris, method = "knn", 
  #               trControl = trainControl(method='cv',number=3),preProcess=c("center", "scale"), tuneGrid=knn_opts)
  #model<-train(Species~.,data=iris,method='svmRadial',metric = "ROC",
  #             trControl=trainControl(method = "repeatedcv", repeats = 3
  #                                    ,summaryFunction = twoClassSummary
  #                                    ,classProbs = TRUE),preProcess='range',tunelength=5,trace=F)
  
  #marsGrid <- data.frame(degree = 1, nprune = (1:10) * 3)
  #tc <- trainControl("cv",10)
  #rpart.grid <- expand.grid(.cp=0.45)
  #model<-train(Species~.,data=iris,method='rpart',trControl=tc,tuneGrid=rpart.grid)
  #print(str(model))
  #print(model)
  #plot(as.party(model$finalModel), type="simple")
  #text(model$finalModel)
  
  mlp_opts = data.frame(.size=2,.decay=c(0,0.001,0.1))
  model<-train(Species~.,data=iris,method='nnet',maxit=2,Hess=T,
               preProcess='range',trace=F,tuneLength=3)
  print(model)
  #print(model$finalModel)
  #plot(model, metric = "ROC",scales = list(x = list(log=2)))
  #prediction <- predict(model, iris)
  #print(prediction)
  #resultTable=table(iris$Species,prediction)
  

  #caret::confusionMatrix(prediction, iris$Species)
  
}