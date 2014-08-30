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
library(corrplot)
library(plotrix)
library(rattle)
library(pROC)
library(RSNNS)

#registerDoSNOW(makeCluster(3,type="SOCK"))

redWine<-read.csv("winequality-red.csv",head=TRUE,sep=";")
whiteWine<-read.csv("winequality-white.csv",head=TRUE,sep=";")
tmp1<-redWine
tmp2<-whiteWine
tmp1$myquality<-apply(redWine[,c('quality','alcohol')], 1, wineQuality)
tmp2$myquality<-apply(whiteWine[,c('quality','alcohol')], 1, wineQuality)
tmp1$WineColor<-c(rep(1,nrow(redWine)))
tmp2$WineColor<-c(rep(2,nrow(whiteWine)))

WineDataset<-rbind(tmp1,tmp2)
WineDataset$myquality=as.factor(WineDataset$myquality)

set.seed(1234)
wineTestIndex = sample(1:nrow(WineDataset), nrow(redWine)/2)
wineTestIndex = createDataPartition(WineDataset$myquality, p=0.8, list=F)


WineProjectCols = c('myquality','free.sulfur.dioxide','fixed.acidity','volatile.acidity','citric.acid','residual.sugar',
                'chlorides','total.sulfur.dioxide','pH','sulphates','alcohol')

WineProjectColsNN = c('volatile.acidity','alcohol')

WineTestData = WineDataset[wineTestIndex,WineProjectCols]
WineTrainingData = WineDataset[-wineTestIndex,WineProjectCols]
WineFormula = formula(myquality ~ free.sulfur.dioxide+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
                        total.sulfur.dioxide+pH+sulphates+alcohol)

WineFormulaNN = formula(myquality ~ volatile.acidity+alcohol)


Wine_cv=trainControl(method='cv',number=10)
wineQuality <- function(eachRow) {
  return(
    #eachRow[1])
    if (eachRow[1]<6)  
      'Good' 
    else if (eachRow[1]>7)
      'Best'
    else
      'Better'
  )
}

WineSummary<-function()
{
  print(summary(WineDataset))
}

WineVariableCorr<-function()
{
  tmp<-WineDataset[,-c(13)]
  corre <- cor(tmp)
  print(corre)
  
  print(names(tmp[,findCorrelation(corre,0.7)]))
  
  corrplot(corre,method='number',tl.cex=0.5)
}

WineTargetDist<-function(){
  categories <- table(WineDataset$myquality)
  barplot(categories)
  title(main="Wine Dataset", xlab="Wine Quality")
}
WineTestAndTrainPct<-function(){
  testDataRows = nrow(WineTestData)
  trainDataRows = nrow(WineTrainingData)
  testPct = 100*round(testDataRows/(testDataRows+trainDataRows),digits=2)
  trainPct = 100-testPct
  
  lbls <- c(paste("Test",nrow(WineTestData),testPct,"%"), paste("Training",nrow(WineTrainingData),trainPct,"%"))
  pie3D(c(nrow(WineTestData),nrow(WineTrainingData)), labels = lbls,  main="Training / Test Dataset")
}
winelm<-function(){
  
  print(summary(lm(formula = quality ~ density+WineColor+free.sulfur.dioxide+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
              total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  
  print(summary(lm(formula = quality ~ WineColor+free.sulfur.dioxide+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
               total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  
  #print(summary(lm(formula = quality ~ free.sulfur.dioxide+fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
  #             total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  
  #print(summary(lm(formula = quality ~fixed.acidity+volatile.acidity+citric.acid+residual.sugar+chlorides+
  #             total.sulfur.dioxide+pH+sulphates+alcohol, data = WineDataset)))
  

  
}



