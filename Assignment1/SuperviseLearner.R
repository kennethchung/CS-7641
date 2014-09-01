
#########################################################################
# Turning Parameter neural network: avNNet or mlp (Multiprecepton neural)
# Turning Parameter iter: Maximum number of iteration it stops or it stops when it reaches below the threshold
##########################################################################
gnn<-function(formula,cv,trainData,testData,nnpkg,iter ){

  nodes<-ncol(trainData)-1
 

  
  if (nnpkg=='avNNet')
    model<-caret::train(formula,data=trainData,method=nnpkg,maxit=iter,
                            trControl=cv,preProcess='range',trace=F,tuneLength=30)
  else if (nnpkg=='mlp')
    model<-train(formula,data=trainData,method=nnpkg,maxit=iter,
                 trControl=cv,preProcess='range',trace=F,tuneLength=30)

  print(model)
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myclass,prediction=prediction)
  print(resultTable)
  print(caret::confusionMatrix(resultTable))
}

#########################################################################
# Turning Parameter complexity parameter: cp, cp is asscicated with cross error.
##########################################################################
gtree<-function(formula,cv,trainData,testData,cp ){
  
  # tuneLenght is used to evaluate a broader set of models
  # Default tree with pruning
  # Use the cp (Complexity Parameter) to simulate over pruning, under pruning
  cp_opts = data.frame(.cp=c(cp))
  
  if (cp >0)
    model<-caret::train(formula,data=trainData,method='rpart',tuneGrid=cp_opts,trControl=cv,
                 preProcess='range',tuneLength=30)
  else
    model<-caret::train(formula,data=trainData,method='rpart',trControl=cv,preProcess='range',
                 tuneLength=10 )
  print(model)
  
  #plot(as.party(model$finalModel), type="simple")
  #ext(model$finalModel)
  prediction <- predict(model, testData)
  
  # prediction using probability
  #prediction <- predict(model, testData, type="prob")
  
  resultTable=table(actual=testData$myclass,prediction=prediction)
  # Use the confusiont to evaluate the result
  print(caret::confusionMatrix(resultTable))
}

#########################################################################
# Turning Parameter: Trials
# If Trials < 1, default will be provided by caret packags 1,10,20,...100
##########################################################################
gbtree<-function(formula,cv,trainData,testData,trials ){

  # use trial to simulate boosting vs overfitting
  btree_opts = expand.grid(.model=c("tree", "rules"),
                          .trials=c(1:9, (1:10)*trials),
                          .winnow = c(TRUE, FALSE))

  # tuneLenght is used to evaluate a broader set of models
  if (trials>0)
    model<-caret::train(formula,data=trainData,method='C5.0',trControl=cv,
                 preProcess='range',tuneLength=30,tuneGrid=btree_opts)
  else
    # default # of trials
    model<-caret::train(formula,data=trainData,method='C5.0',trControl=cv,
                 preProcess='range',tuneLength=30)

  
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myclass,prediction=prediction)

  print(summary(model$finalModel))
  print(model)
  print(model$finalModel$tuneValue)
  print(predictors(model ))
 
  
  print(caret::confusionMatrix(resultTable))


}


#####################################################################
### Truning Parameter Kernels- svmMethod: svmRadial and svmLinear kernels from kernlab
### Tuning Parameter Cost: 0.25, 0.5, 1.5
######################################################################
gsvm<-function(formula,cv,trainData,testData, svmMethod){
  
  # tune C, the cost parameter
  # tune kernel type
  #svmcost_opts = data.frame(.C=2^seq(-5,5,len=5))
  
  
  cost<-c(2^-2,0.5,1,1.5)
  sigma<-0.02
  if (svmMethod =='svmLinear' ){
    svmcost_opts = data.frame(.C=cost)
    model<-train(formula,data=trainData,method=svmMethod,
               trControl=cv,preProcess='range',trace=F,tuneLength=30,tuneGrid=svmcost_opts)
  }else if (svmMethod == 'svmRadial') {
    svmcost_opts = data.frame(.C=cost,.sigma=sigma)
    model<-train(formula,data=trainData,method=svmMethod,
                 trControl=cv,preProcess='range',trace=F,tuneLength=30,tuneGrid=svmcost_opts)
  }
  
  print(model)
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myclass,prediction=prediction)
  print(caret::confusionMatrix(resultTable))
}

###############################################################
#### Turing Parameter k: It is set to 1,2,3,5,10,20,30, 50
###############################################################
gknn<-function(formula,cv,trainData,testData){
  
  # Tuning Parameter on k
  # Determine k with  highest accuracy
  knn_opts = data.frame(.k=c(1,2,3,5,10,20,30,50))
  
  model <- caret::train(formula, data = trainData, method = "knn", 
                  trControl = cv,preProcess='range', tuneGrid=knn_opts)
  print(model)
  dotPlot(varImp(model))
  prediction <- predict(model, testData)
  resultTable=table(actual=testData$myclass,prediction=prediction)
  print(caret::confusionMatrix(resultTable))
}

##############################################################
### Not use: These are for debug
##############################################################
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
  model<-caret::train(Species~.,data=iris,method='nnet',maxit=2,Hess=T,
               preProcess='range',trace=F,tuneLength=3)
  print(model)
  #print(model$finalModel)
  #plot(model, metric = "ROC",scales = list(x = list(log=2)))
  #prediction <- predict(model, iris)
  #print(prediction)
  #resultTable=table(iris$Species,prediction)
  

  #caret::confusionMatrix(prediction, iris$Species)
  
}



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