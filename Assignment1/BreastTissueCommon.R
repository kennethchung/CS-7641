library(partykit)
library(e1071)
library(rpart)

library(ggplot2)
library(neuralnet)

library(nnet)

library(randomForest)
library(ipred)
library(kernlab)
library(rgl)
library(misc3d)
library(class)
library(RWeka)
library(foreign)
library(doSNOW)
library(corrplot)
library(plotrix)
library(rattle)
library(pROC)
library(RSNNS)
library(C50)

library(caret)
registerDoSNOW(makeCluster(3,type="SOCK"))

BreasTissue<-read.csv("BreastTissue.csv",head=TRUE,sep=",")

tmp1<-BreasTissue[-1]
names(tmp1)
tmp1$myclass<-BreasTissue$Class
tmp1$myclass=as.factor(tmp1$myclass)
BreastDataset<-tmp1[-1]
set.seed(1234)
BreastTrainIndex = createDataPartition(BreastDataset$myclass, p=0.8, list=F, times = 1)

BreastProjectCols = c('myclass','I0','PA500','HFS','DA','Area',
                    'A.DA','Max.IP','DR','P')
BreastTestData = BreastDataset[-BreastTrainIndex,BreastProjectCols]
BreastTrainingData = BreastDataset[BreastTrainIndex,BreastProjectCols]

BreastFormula = formula(myclass ~ I0+PA500+HFS+DA+Area+A.DA+Max.IP+DR+P)


Breast_cv=trainControl(method='repeatedcv',repeats=3)

BreastSummary<-function()
{
  print(summary(BreastDataset))
}

BreastVariableCorr<-function()
{
  tmp<-BreastDataset[,-c(10)]
  corre <- cor(tmp)
  print(corre)
  
  print(names(tmp[,findCorrelation(corre,0.7)]))
  
  corrplot(corre,method='number',tl.cex=0.5)
}

BreastTargetDist<-function(){
  categories <- table(BreastDataset$myclass)
  barplot(categories)
  title(main="Breast Tissue Dataset", xlab="Breast Class")
}

BreastTestAndTrainPct<-function(){
  testDataRows = nrow(BreastTestData)
  trainDataRows = nrow(BreastTrainingData)
  testPct = 100*round(testDataRows/(testDataRows+trainDataRows),digits=2)
  trainPct = 100-testPct
  
  lbls <- c(paste("Test",nrow(BreastTestData),testPct,"%"), paste("Training",nrow(BreastTrainingData),trainPct,"%"))
  pie3D(c(nrow(BreastTestData),nrow(BreastTrainingData)), labels = lbls,  main="Training / Test Dataset")
}

Breastlm<-function(){
  
  print(summary(lm(formula = I0 ~ PA500+HFS+DA+Area+A.DA+Max.IP+DR+P,data = BreastDataset)))
  
  #print(summary(lm(formula = myclass ~ I0+PA500+HFS+DA+Area+A.DA+Max.IP+DR+P)))
  
  #print(summary(lm(formula = quality ~ free.sulfur.dioxide+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
  #             total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  
  #print(summary(lm(formula = quality ~fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
  #             total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  
  
  
}
