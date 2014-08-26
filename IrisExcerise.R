
library(e1071)
kmean<-function()
{
  km <- kmeans(iris[,1:4], 3)
  plot(iris[,1], iris[,2], col=km$cluster)
  points(km$centers[,c(1,2)], col=1:3, pch=8, cex=2)
  print(length(km$cluster))
  print(length(iris$Species))
  
  table(km$cluster, iris$Species)
  
  # 1 has 0 setosa, 46 versicolor 50 virginica
  # 2
  # 3
}

datasummary<-function()
{
  print(head(iris))
  print(nrow(iris))
  print(table(iris$Species))
  hist(iris$Sepal.Length, breaks=10, prob=T)
  lines(density(iris$Sepal.Length))
  
  categories <- table(iris$Species)
  barplot(categories, col=c('red', 'green', 'blue'))
  boxplot(Sepal.Length~Species, data=iris)
  pairs(iris[,c(1,2,3,4)])
  cor(iris[,c(1,2,3,4)])
  
  plot(Petal.Width~Sepal.Length, data=iris)
  model <- lm(Petal.Width~Sepal.Length, data=iris)
  abline(model)
  model2 <- lowess(iris$Petal.Width~iris$Sepal.Length)
  lines(model2, col="red")
  
}

DataPreparation<-function(){
  # select 10 records from iris with replacement
  index <- sample(1:nrow(iris), 10, replace=T)
  irissample <-iris[index,]
  # create some missing data
  irissample[10, 1] <- NA
  fixIris1 <- impute(irissample[,1:4], what='mean')
  fixIris2 <- impute(irissample[,1:4], what='median')
  
  #normalize data
  #x-mean(x)/standard deviation
  scaleiris <- scale(iris[, 1:4])
  
  # Some attributes shows high correlation, compute PCA
  cor(iris[, -5])
  pca <- prcomp(iris[,-5], scale=T)
  summary(pca)
  plot(pca)
  
}

testidx <- which(1:length(iris[,1])%%5 == 0)
iristrain <- iris[-testidx,]
iristest <- iris[testidx,]

library(neuralnet)
nnetTest<-function(){
  nnet_iristrain <-iristrain
  nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'setosa')
  nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'versicolor')
  nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'virginica')
  names(nnet_iristrain)[6] <- 'setosa'
  names(nnet_iristrain)[7] <- 'versicolor'
  names(nnet_iristrain)[8] <- 'virginica'
  nn <- neuralnet(setosa+versicolor+virginica ~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,
                  data=nnet_iristrain,hidden=c(3,3,3))
  
  plot(nn)
  mypredict <- compute(nn, iristest[-5])$net.result
  #print(mypredict)
  maxidx <- function(arr) {return(which(arr == max(arr)))}
  idx <- apply(mypredict, c(1), maxidx)
  prediction <- c('setosa', 'versicolor', 'virginica')[idx]
  table(prediction,iristest$Species)
}