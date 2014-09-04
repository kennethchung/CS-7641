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

boston<-read.csv("housing.csv",head=TRUE,sep=",")
tmp1<-boston
tmp1$myclass<-tmp1$MEDV
BostonDataset<-tmp1[-14]
set.seed(1234)
BostonTestIndex = sample(1:nrow(BostonDataset), nrow(BostonDataset)/3)

BostonTestData = BostonDataset[BostonTestIndex,]
BostonTrainingData = BostonDataset[-BostonTestIndex,]

BostonFormula = formula(myclass ~ CRIM+ZN+INDUX+CHAS+NOX+RM+AGE+DIS+RAD+TAX+PTRATIO+B+LSTAT)
Boston_cv=trainControl(method='repeatedcv',repeats=2)