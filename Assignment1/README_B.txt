This document show you how to run the supervised learn against Breast dataset.
The BreastTissueCommon.R contains reading and setting up the Breast Tissue training and test datasets.

Load Breast Tissue data and verify Breast Tissue Training and test data
1) Source BreastTissueCommon.R will load the following as global variables 
   a) BreastFormula (Model Formula)
   b) Breast_cv (Cross Validation setting)
   c) BreastTrainingData (Training Dataset)
   d) BreastTestData (Test Dataset)
2) Run WineSummary() to get the summary of combined red and white dataset
3) Run BreastVariableCorr() to get the predictor correlation matrix barplot
4) Run BreastTargetDist() to get the Breast Tissues Class distribution
5) Run Breastlm() to get Wine linear regression matrix

Run supervised learning algoritum aganist wine dataset
1) Source SuperviseLearner.R first
2) Run gnn(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,'avNNet',10) to use
   average single layer neural network where
   'avNet' is the average neural network
   10 is the maximum iterations
   The model with highest accuracy will be chosen and applied to test data for prediction
   
3) Run gnn(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,'mlp',10) to use
   Multiple Layer Preceptron network work where
   'mlp' is the multiple layer preceptron 
   10 is the maximum iterations
   The model with highest accuracy will be chosen and applied to test data for prediction
   
4) Run gtree(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData, 0.12) to use
   rpart decision tree where
   0.12 the complexity parameter. This parameter assoicates with cross error and can be used for pruning at specific level
   gtree(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData, 0.05)
   The model with highest accuracy will be chosen and applied to test data for prediction
   
4) Run gtree(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData, -1) to use
   rpart decision tree where
   -1 is to use default setting from caret where it defaults to use 3 complexity paramters
   The model with highest accuracy will be chosen and applied to test data for prediction

5) Run gsvm(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,'svmLinear' ) to 
   linear support vector machine kernel where
   'svmLinear' is the from KernelLab package
   It defaults to use 2^-2,0.5,1,1.5 as the cost
   The model with highest accuracy will be chosen and applied to test data for prediction
   
6) Run gsvm(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,'svmRadial' ) to
   usse Radial Basis Function Kernel where
   'svmRadial' is the radial basis function
   It defaults to use 2^-2,0.5,1,1.5 as the cost for the model.
   The model with highest accuracy will be chosen and applied to test data for prediction


7) Run gknn(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData) to use
   k-Nearest Neighbors 
   It defaults to use 1,2,3,5,10,20,30,50 as k
   The model with highest accuracy will be chosen and applied to test data for prediction
   
8) Run gbtree(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,10) to use
   boosted tree where
   10 is # of trials. where -1 means to use 10, 20, ... trials
   gbtree(BreastFormula,Breast_cv,BreastTrainingData, BreastTestData,-1)


Below are results of above runs.
CART 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 78, 81, 78, 78, 78, 78, ... 

Resampling results across tuning parameters:

  cp      Accuracy  Kappa   Accuracy SD  Kappa SD
  0.0000  0.639     0.5623  0.1180       0.1405  
  0.0274  0.639     0.5614  0.1180       0.1413  
  0.0548  0.680     0.6100  0.1345       0.1614  
  0.0821  0.700     0.6339  0.1382       0.1661  
  0.1095  0.680     0.6113  0.1414       0.1693  
  0.1369  0.591     0.5097  0.1090       0.1266  
  0.1643  0.459     0.3372  0.1024       0.1295  
  0.1916  0.394     0.2470  0.0567       0.0516  
  0.2190  0.398     0.2485  0.0491       0.0490  
  0.2464  0.246     0.0738  0.0898       0.1175  

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was cp = 0.0821256. 
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   1   0   1   0   0   0
   fad   0   0   0   0   0   3
   gla   0   0   0   0   1   2
   mas   0   0   0   0   0   3

Overall Statistics
                                          
               Accuracy : 0.6842          
                 95% CI : (0.4345, 0.8742)
    No Information Rate : 0.4211          
    P-Value [Acc > NIR] : 0.01874         
                                          
                  Kappa : 0.6149          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              0.8000     1.0000    1.00000         NA    1.00000     0.3750
Specificity              1.0000     1.0000    0.94444     0.8421    0.88889     1.0000
Pos Pred Value           1.0000     1.0000    0.50000         NA    0.33333     1.0000
Neg Pred Value           0.9333     1.0000    1.00000         NA    1.00000     0.6875
Prevalence               0.2632     0.2105    0.05263     0.0000    0.05263     0.4211
Detection Rate           0.2105     0.2105    0.05263     0.0000    0.05263     0.1579
Detection Prevalence     0.2105     0.2105    0.10526     0.1579    0.15789     0.1579
Balanced Accuracy        0.9000     1.0000    0.97222         NA    0.94444     0.68750.7443      0.7725

----------------------------------------------------------------------------------------------------------------
Support Vector Machines with Linear Kernel 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 77, 78, 78, 78, 79, 77, ... 

Resampling results across tuning parameters:

  C     Accuracy  Kappa  Accuracy SD  Kappa SD
  0.25  0.582     0.494  0.116        0.139   
  0.50  0.579     0.490  0.122        0.147   
  1.00  0.589     0.503  0.114        0.135   
  1.50  0.619     0.539  0.110        0.129   

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was C = 1.5. 
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   1   0   1   0   0   0
   fad   0   0   0   2   0   1
   gla   0   0   0   0   1   2
   mas   0   0   0   1   0   2

Overall Statistics
                                         
               Accuracy : 0.7368         
                 95% CI : (0.488, 0.9085)
    No Information Rate : 0.2632         
    P-Value [Acc > NIR] : 2.181e-05      
                                         
                  Kappa : 0.6791         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              0.8000     1.0000    1.00000     0.6667    1.00000     0.4000
Specificity              1.0000     1.0000    0.94444     0.9375    0.88889     0.9286
Pos Pred Value           1.0000     1.0000    0.50000     0.6667    0.33333     0.6667
Neg Pred Value           0.9333     1.0000    1.00000     0.9375    1.00000     0.8125
Prevalence               0.2632     0.2105    0.05263     0.1579    0.05263     0.2632
Detection Rate           0.2105     0.2105    0.05263     0.1053    0.05263     0.1053
Detection Prevalence     0.2105     0.2105    0.10526     0.1579    0.15789     0.1579
Balanced Accuracy        0.9000     1.0000    0.97222     0.8021    0.94444     0.6643

--------------------------------------------------------------------------------------
Support Vector Machines with Radial Basis Function Kernel 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 79, 80, 79, 78, 79, 78, ... 

Resampling results across tuning parameters:

  C     Accuracy  Kappa  Accuracy SD  Kappa SD
  0.25  0.406     0.260  0.0656       0.0539  
  0.50  0.503     0.391  0.1030       0.1144  
  1.00  0.573     0.475  0.0918       0.1064  
  1.50  0.573     0.475  0.0965       0.1139  

Tuning parameter 'sigma' was held constant at a value of 0.02
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were sigma = 0.02 and C = 1. 
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   0   0   2   0   0   0
   fad   0   0   0   0   0   3
   gla   0   0   0   0   0   3
   mas   0   0   0   0   0   3

Overall Statistics
                                          
               Accuracy : 0.6842          
                 95% CI : (0.4345, 0.8742)
    No Information Rate : 0.4737          
    P-Value [Acc > NIR] : 0.05341         
                                          
                  Kappa : 0.6174          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              1.0000     1.0000     1.0000         NA         NA     0.3333
Specificity              1.0000     1.0000     1.0000     0.8421     0.8421     1.0000
Pos Pred Value           1.0000     1.0000     1.0000         NA         NA     1.0000
Neg Pred Value           1.0000     1.0000     1.0000         NA         NA     0.6250
Prevalence               0.2105     0.2105     0.1053     0.0000     0.0000     0.4737
Detection Rate           0.2105     0.2105     0.1053     0.0000     0.0000     0.1579
Detection Prevalence     0.2105     0.2105     0.1053     0.1579     0.1579     0.1579
Balanced Accuracy        1.0000     1.0000     1.0000         NA         NA     0.6667

---------------------------------------------------------------------------------------------

Support Vector Machines with Radial Basis Function Kernel 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 77, 78, 77, 77, 79, 79, ... 

Resampling results across tuning parameters:

  C     Accuracy  Kappa  Accuracy SD  Kappa SD
  0.25  0.406     0.256  0.0548       0.0602  
  0.50  0.489     0.370  0.1091       0.1245  
  1.00  0.562     0.465  0.1185       0.1351  
  1.50  0.558     0.459  0.1184       0.1357  

Tuning parameter 'sigma' was held constant at a value of 0.02
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were sigma = 0.02 and C = 1. 
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   0   0   2   0   0   0
   fad   0   0   0   0   0   3
   gla   0   0   0   0   0   3
   mas   0   0   0   0   0   3

Overall Statistics
                                          
               Accuracy : 0.6842          
                 95% CI : (0.4345, 0.8742)
    No Information Rate : 0.4737          
    P-Value [Acc > NIR] : 0.05341         
                                          
                  Kappa : 0.6174          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              1.0000     1.0000     1.0000         NA         NA     0.3333
Specificity              1.0000     1.0000     1.0000     0.8421     0.8421     1.0000
Pos Pred Value           1.0000     1.0000     1.0000         NA         NA     1.0000
Neg Pred Value           1.0000     1.0000     1.0000         NA         NA     0.6250
Prevalence               0.2105     0.2105     0.1053     0.0000     0.0000     0.4737
Detection Rate           0.2105     0.2105     0.1053     0.0000     0.0000     0.1579
Detection Prevalence     0.2105     0.2105     0.1053     0.1579     0.1579     0.1579
Balanced Accuracy        1.0000     1.0000     1.0000         NA         NA     0.6667


--------------------------------------------------------------------------------------

Evaluation on training data (87 cases):

	    Decision Tree   
	  ----------------  
	  Size      Errors  

	    13    6( 6.9%)   <<


	   (a)   (b)   (c)   (d)   (e)   (f)    <-classified as
	  ----  ----  ----  ----  ----  ----
	    17           1                      (a): class adi
	          16                       1    (b): class car
	                12                      (c): class con
	                      10           2    (d): class fad
	           1                12          (e): class gla
	                             1    14    (f): class mas


	Attribute usage:

	100.00%	I0
	 65.52%	Area
	 43.68%	DA
	 21.84%	P
	 19.54%	HFS
	 16.09%	Max.IP


Time: 0.0 secs

C5.0 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 77, 77, 79, 80, 78, 77, ... 

Resampling results across tuning parameters:

  model  winnow  trials  Accuracy  Kappa  Accuracy SD  Kappa SD
  rules  FALSE     1     0.632     0.555  0.1237       0.146   
  rules  FALSE     2     0.650     0.577  0.1288       0.152   
  rules  FALSE     3     0.636     0.560  0.1131       0.134   
  rules  FALSE     4     0.641     0.565  0.1147       0.137   
  rules  FALSE     5     0.649     0.577  0.1090       0.130   
  rules  FALSE     6     0.647     0.573  0.1297       0.155   
  rules  FALSE     7     0.640     0.565  0.1121       0.134   
  rules  FALSE     8     0.647     0.574  0.1188       0.142   
  rules  FALSE     9     0.647     0.574  0.1263       0.151   
  rules  FALSE    10     0.654     0.582  0.1234       0.148   
  rules  FALSE    20     0.660     0.589  0.1226       0.147   
  rules  FALSE    30     0.659     0.587  0.1266       0.152   
  rules  FALSE    40     0.658     0.586  0.1347       0.161   
  rules  FALSE    50     0.654     0.581  0.1437       0.173   
  rules  FALSE    60     0.653     0.581  0.1348       0.162   
  rules  FALSE    70     0.653     0.581  0.1315       0.157   
  rules  FALSE    80     0.653     0.580  0.1315       0.157   
  rules  FALSE    90     0.653     0.581  0.1315       0.157   
  rules  FALSE   100     0.661     0.590  0.1306       0.156   
  rules   TRUE     1     0.626     0.546  0.1158       0.140   
  rules   TRUE     2     0.629     0.550  0.0976       0.115   
  rules   TRUE     3     0.638     0.562  0.1133       0.137   
  rules   TRUE     4     0.633     0.555  0.1035       0.125   
  rules   TRUE     5     0.635     0.557  0.1043       0.126   
  rules   TRUE     6     0.639     0.561  0.0990       0.120   
  rules   TRUE     7     0.636     0.559  0.0962       0.114   
  rules   TRUE     8     0.636     0.558  0.1068       0.129   
  rules   TRUE     9     0.641     0.564  0.0852       0.102   
  rules   TRUE    10     0.641     0.565  0.0950       0.113   
  rules   TRUE    20     0.633     0.555  0.0986       0.117   
  rules   TRUE    30     0.640     0.564  0.1031       0.123   
  rules   TRUE    40     0.646     0.570  0.0986       0.116   
  rules   TRUE    50     0.649     0.574  0.1022       0.121   
  rules   TRUE    60     0.645     0.570  0.0993       0.117   
  rules   TRUE    70     0.653     0.579  0.1050       0.124   
  rules   TRUE    80     0.642     0.566  0.1026       0.121   
  rules   TRUE    90     0.649     0.574  0.1022       0.120   
  rules   TRUE   100     0.649     0.574  0.1022       0.120   
  tree   FALSE     1     0.635     0.558  0.1163       0.139   
  tree   FALSE     2     0.669     0.599  0.1216       0.145   
  tree   FALSE     3     0.650     0.576  0.1309       0.156   
  tree   FALSE     4     0.640     0.564  0.1208       0.145   
  tree   FALSE     5     0.657     0.585  0.1341       0.160   
  tree   FALSE     6     0.651     0.576  0.1222       0.148   
  tree   FALSE     7     0.644     0.569  0.1159       0.140   
  tree   FALSE     8     0.655     0.582  0.1287       0.154   
  tree   FALSE     9     0.655     0.582  0.1245       0.150   
  tree   FALSE    10     0.655     0.582  0.1278       0.155   
  tree   FALSE    20     0.654     0.580  0.1200       0.144   
  tree   FALSE    30     0.657     0.584  0.1151       0.138   
  tree   FALSE    40     0.657     0.585  0.1287       0.155   
  tree   FALSE    50     0.653     0.580  0.1239       0.149   
  tree   FALSE    60     0.661     0.589  0.1302       0.156   
  tree   FALSE    70     0.661     0.589  0.1302       0.156   
  tree   FALSE    80     0.661     0.589  0.1302       0.156   
  tree   FALSE    90     0.657     0.585  0.1250       0.150   
  tree   FALSE   100     0.653     0.580  0.1239       0.149   
  tree    TRUE     1     0.625     0.545  0.1285       0.154   
  tree    TRUE     2     0.635     0.557  0.1352       0.163   
  tree    TRUE     3     0.629     0.551  0.1298       0.155   
  tree    TRUE     4     0.651     0.577  0.1122       0.134   
  tree    TRUE     5     0.657     0.584  0.1141       0.138   
  tree    TRUE     6     0.644     0.568  0.1223       0.145   
  tree    TRUE     7     0.638     0.560  0.1273       0.151   
  tree    TRUE     8     0.644     0.569  0.1243       0.147   
  tree    TRUE     9     0.649     0.574  0.1085       0.130   
  tree    TRUE    10     0.663     0.592  0.1229       0.148   
  tree    TRUE    20     0.629     0.549  0.1074       0.127   
  tree    TRUE    30     0.625     0.546  0.0984       0.115   
  tree    TRUE    40     0.637     0.559  0.1016       0.121   
  tree    TRUE    50     0.637     0.559  0.1016       0.121   
  tree    TRUE    60     0.645     0.569  0.1025       0.121   
  tree    TRUE    70     0.645     0.569  0.1067       0.126   
  tree    TRUE    80     0.645     0.569  0.1067       0.126   
  tree    TRUE    90     0.649     0.574  0.1134       0.134   
  tree    TRUE   100     0.649     0.574  0.1053       0.124   

Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were trials = 2, model = tree and winnow = FALSE. 
  trials model winnow
2      2  tree  FALSE
[1] "DA"     "I0"     "Area"   "HFS"    "Max.IP" "P"     
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   2   0   0   0   2
   con   1   0   1   0   0   0
   fad   0   0   0   2   0   1
   gla   0   0   0   2   1   0
   mas   0   0   0   1   0   2

Overall Statistics
                                          
               Accuracy : 0.6316          
                 95% CI : (0.3836, 0.8371)
    No Information Rate : 0.2632          
    P-Value [Acc > NIR] : 0.0008033       
                                          
                  Kappa : 0.5537          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              0.8000     1.0000    1.00000     0.4000    1.00000     0.4000
Specificity              1.0000     0.8824    0.94444     0.9286    0.88889     0.9286
Pos Pred Value           1.0000     0.5000    0.50000     0.6667    0.33333     0.6667
Neg Pred Value           0.9333     1.0000    1.00000     0.8125    1.00000     0.8125
Prevalence               0.2632     0.1053    0.05263     0.2632    0.05263     0.2632
Detection Rate           0.2105     0.1053    0.05263     0.1053    0.05263     0.1053
Detection Prevalence     0.2105     0.2105    0.10526     0.1579    0.15789     0.1579
Balanced Accuracy        0.9000     0.9412    0.97222     0.6643    0.94444     0.6643

-----------------------------------------------------------------------------------------
Multi-Layer Perceptron 

87 samples
 9 predictor
 6 classes: 'adi', 'car', 'con', 'fad', 'gla', 'mas' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 78, 79, 80, 78, 79, 78, ... 

Resampling results across tuning parameters:

  size  Accuracy  Kappa  Accuracy SD  Kappa SD
   1    0.466     0.345  0.108        0.128   
   3    0.647     0.572  0.134        0.160   
   5    0.648     0.575  0.153        0.182   
   7    0.652     0.581  0.137        0.163   
   9    0.636     0.561  0.134        0.158   
  11    0.632     0.556  0.134        0.159   
  13    0.627     0.550  0.148        0.176   
  15    0.625     0.549  0.132        0.157   
  17    0.632     0.557  0.146        0.172   
  19    0.643     0.570  0.148        0.175   
  21    0.641     0.567  0.143        0.171   
  23    0.636     0.563  0.150        0.176   
  25    0.625     0.548  0.137        0.161   
  27    0.625     0.547  0.149        0.176   
  29    0.632     0.557  0.140        0.166   
  31    0.635     0.558  0.142        0.169   
  33    0.632     0.555  0.166        0.197   
  35    0.614     0.535  0.147        0.173   
  37    0.604     0.523  0.132        0.156   
  39    0.624     0.547  0.150        0.178   
  41    0.611     0.531  0.154        0.180   
  43    0.610     0.529  0.120        0.142   
  45    0.628     0.551  0.150        0.179   
  47    0.646     0.572  0.136        0.162   
  49    0.645     0.571  0.152        0.182   
  51    0.628     0.550  0.156        0.187   
  53    0.633     0.556  0.131        0.157   
  55    0.610     0.529  0.139        0.163   
  57    0.619     0.541  0.159        0.188   
  59    0.608     0.527  0.134        0.159   

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was size = 7. 
      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   1   0   1   0   0   0
   fad   0   0   0   2   0   1
   gla   0   0   0   0   3   0
   mas   0   0   0   1   0   2
Confusion Matrix and Statistics

      prediction
actual adi car con fad gla mas
   adi   4   0   0   0   0   0
   car   0   4   0   0   0   0
   con   1   0   1   0   0   0
   fad   0   0   0   2   0   1
   gla   0   0   0   0   3   0
   mas   0   0   0   1   0   2

Overall Statistics
                                          
               Accuracy : 0.8421          
                 95% CI : (0.6042, 0.9662)
    No Information Rate : 0.2632          
    P-Value [Acc > NIR] : 2.185e-07       
                                          
                  Kappa : 0.8074          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: adi Class: car Class: con Class: fad Class: gla Class: mas
Sensitivity              0.8000     1.0000    1.00000     0.6667     1.0000     0.6667
Specificity              1.0000     1.0000    0.94444     0.9375     1.0000     0.9375
Pos Pred Value           1.0000     1.0000    0.50000     0.6667     1.0000     0.6667
Neg Pred Value           0.9333     1.0000    1.00000     0.9375     1.0000     0.9375
Prevalence               0.2632     0.2105    0.05263     0.1579     0.1579     0.1579
Detection Rate           0.2105     0.2105    0.05263     0.1053     0.1579     0.1053
Detection Prevalence     0.2105     0.2105    0.10526     0.1579     0.1579     0.1579
Balanced Accuracy        0.9000     1.0000    0.97222     0.8021     1.0000     0.8021


-----------------------------------------------------------------------------------------
> BostonTree()
n=302 (36 observations deleted due to missingness)

node), split, n, deviance, yval
      * denotes terminal node

 1) root 302 24963.1200 24.11026  
   2) RM< 6.797 241  7852.8710 20.83278  
     4) LSTAT>=11.49 122  1701.2110 17.53934  
       8) CRIM>=5.43706 25   141.4056 13.37600 *
       9) CRIM< 5.43706 97  1014.7850 18.61237 *
     5) LSTAT< 11.49 119  3471.7000 24.20924  
      10) DIS>=1.48495 116  1424.6030 23.54224  
        20) RM< 6.543 91   773.6675 22.53516 *
        21) RM>=6.543 25   222.6984 27.20800 *
      11) DIS< 1.48495 3     0.0000 50.00000 *
   3) RM>=6.797 61  4293.5680 37.05902  
     6) RM< 7.437 38  1064.1230 32.32105 *
     7) RM>=7.437 23   967.0461 44.88696  
      14) PTRATIO>=18.3 3   223.8200 33.30000 *
      15) PTRATIO< 18.3 20   280.0375 46.62500 *

Regression tree:
rpart(formula = BostonFormula, data = BostonTrainingData, method = "anova", 
    control = rpart.control(minsplit = 10))

Variables actually used in tree construction:
[1] CRIM    DIS     LSTAT   PTRATIO RM     

Root node error: 24963/302 = 82.659

n=302 (36 observations deleted due to missingness)

        CP nsplit rel error  xerror     xstd
1 0.513425      0   1.00000 1.00654 0.106526
2 0.107357      1   0.48658 0.50273 0.067664
3 0.090630      2   0.37922 0.42315 0.060406
4 0.082005      3   0.28859 0.39079 0.071127
5 0.021833      4   0.20658 0.29709 0.054498
6 0.018555      5   0.18475 0.28499 0.054602
7 0.017155      6   0.16620 0.28025 0.054593
8 0.010000      7   0.14904 0.27178 0.054803
Call:
rpart(formula = BostonFormula, data = BostonTrainingData, method = "anova", 
    control = rpart.control(minsplit = 10))
  n=302 (36 observations deleted due to missingness)

          CP nsplit rel error    xerror       xstd
1 0.51342463      0 1.0000000 1.0065439 0.10652573
2 0.10735678      1 0.4865754 0.5027278 0.06766440
3 0.09062964      2 0.3792186 0.4231529 0.06040598
4 0.08200485      3 0.2885890 0.3907945 0.07112653
5 0.02183303      4 0.2065841 0.2970920 0.05449754
6 0.01855492      5 0.1847511 0.2849913 0.05460159
7 0.01715479      6 0.1661962 0.2802511 0.05459317
8 0.01000000      7 0.1490414 0.2717773 0.05480306

Variable importance
     RM   LSTAT   INDUX    CRIM PTRATIO     DIS     NOX     AGE     TAX      ZN       B     RAD 
     37      18      10       8       7       4       4       3       3       2       2       1 

Node number 1: 302 observations,    complexity param=0.5134246
  mean=24.11026, MSE=82.65933 
  left son=2 (241 obs) right son=3 (61 obs)
  Primary splits:
      RM      < 6.797    to the left,  improve=0.5134246, (0 missing)
      LSTAT   < 4.65     to the right, improve=0.4148030, (0 missing)
      INDUX   < 4.01     to the right, improve=0.2236434, (0 missing)
      TAX     < 267.5    to the right, improve=0.1699797, (0 missing)
      PTRATIO < 18.8     to the right, improve=0.1643197, (0 missing)
  Surrogate splits:
      LSTAT   < 4.65     to the right, agree=0.871, adj=0.361, (0 split)
      INDUX   < 4.01     to the right, agree=0.844, adj=0.230, (0 split)
      PTRATIO < 14.55    to the right, agree=0.838, adj=0.197, (0 split)
      TAX     < 222.5    to the right, agree=0.818, adj=0.098, (0 split)
      ZN      < 87.5     to the left,  agree=0.815, adj=0.082, (0 split)

Node number 2: 241 observations,    complexity param=0.1073568
  mean=20.83278, MSE=32.58453 
  left son=4 (122 obs) right son=5 (119 obs)
  Primary splits:
      LSTAT < 11.49    to the right, improve=0.3412714, (0 missing)
      DIS   < 1.3879   to the right, improve=0.2075428, (0 missing)
      RM    < 6.543    to the left,  improve=0.1606336, (0 missing)
      AGE   < 67.35    to the right, improve=0.1583458, (0 missing)
      NOX   < 0.535    to the right, improve=0.1508868, (0 missing)
  Surrogate splits:
      AGE   < 69.9     to the right, agree=0.788, adj=0.571, (0 split)
      NOX   < 0.519    to the right, agree=0.776, adj=0.546, (0 split)
      CRIM  < 0.167215 to the right, agree=0.763, adj=0.521, (0 split)
      INDUX < 7.625    to the right, agree=0.747, adj=0.487, (0 split)
      RM    < 6.0195   to the left,  agree=0.726, adj=0.445, (0 split)

Node number 3: 61 observations,    complexity param=0.09062964
  mean=37.05902, MSE=70.38635 
  left son=6 (38 obs) right son=7 (23 obs)
  Primary splits:
      RM      < 7.437    to the left,  improve=0.5269274, (0 missing)
      LSTAT   < 4.685    to the right, improve=0.3163922, (0 missing)
      PTRATIO < 14.75    to the right, improve=0.1541413, (0 missing)
      INDUX   < 18.84    to the left,  improve=0.1230664, (0 missing)
      B       < 390.66   to the right, improve=0.1014833, (0 missing)
  Surrogate splits:
      B       < 391.01   to the right, agree=0.754, adj=0.348, (0 split)
      LSTAT   < 3.99     to the right, agree=0.738, adj=0.304, (0 split)
      CRIM    < 0.11706  to the left,  agree=0.705, adj=0.217, (0 split)
      PTRATIO < 14.75    to the right, agree=0.689, adj=0.174, (0 split)
      INDUX   < 18.84    to the left,  agree=0.672, adj=0.130, (0 split)

Node number 4: 122 observations,    complexity param=0.02183303
  mean=17.53934, MSE=13.94435 
  left son=8 (25 obs) right son=9 (97 obs)
  Primary splits:
      CRIM    < 5.43706  to the right, improve=0.3203720, (0 missing)
      PTRATIO < 19.65    to the right, improve=0.2884766, (0 missing)
      NOX     < 0.607    to the right, improve=0.2529634, (0 missing)
      LSTAT   < 16.215   to the right, improve=0.2488873, (0 missing)
      DIS     < 2.07945  to the left,  improve=0.2478077, (0 missing)
  Surrogate splits:
      RAD < 16       to the right, agree=0.910, adj=0.56, (0 split)
      TAX < 551.5    to the right, agree=0.885, adj=0.44, (0 split)
      NOX < 0.667    to the right, agree=0.844, adj=0.24, (0 split)
      B   < 136.55   to the left,  agree=0.836, adj=0.20, (0 split)
      RM  < 6.1785   to the right, agree=0.828, adj=0.16, (0 split)

Node number 5: 119 observations,    complexity param=0.08200485
  mean=24.20924, MSE=29.17395 
  left son=10 (116 obs) right son=11 (3 obs)
  Primary splits:
      DIS  < 1.48495  to the right, improve=0.5896526, (0 missing)
      CRIM < 5.435875 to the left,  improve=0.3130748, (0 missing)
      NOX  < 0.6275   to the left,  improve=0.1668395, (0 missing)
      CHAS < 0.5      to the left,  improve=0.1657371, (0 missing)
      AGE  < 96.5     to the left,  improve=0.1476670, (0 missing)
  Surrogate splits:
      CRIM < 7.04563  to the left,  agree=0.992, adj=0.667, (0 split)

Node number 6: 38 observations
  mean=32.32105, MSE=28.00324 

Node number 7: 23 observations,    complexity param=0.01855492
  mean=44.88696, MSE=42.04548 
  left son=14 (3 obs) right son=15 (20 obs)
  Primary splits:
      PTRATIO < 18.3     to the right, improve=0.4789726, (0 missing)
      LSTAT   < 4.96     to the right, improve=0.2172196, (0 missing)
      NOX     < 0.626    to the right, improve=0.1725020, (0 missing)
      CHAS    < 0.5      to the right, improve=0.1576942, (0 missing)
      AGE     < 90.1     to the left,  improve=0.1159916, (0 missing)

Node number 8: 25 observations
  mean=13.376, MSE=5.656224 

Node number 9: 97 observations
  mean=18.61237, MSE=10.4617 

Node number 10: 116 observations,    complexity param=0.01715479
  mean=23.54224, MSE=12.28106 
  left son=20 (91 obs) right son=21 (25 obs)
  Primary splits:
      RM      < 6.543    to the left,  improve=0.30060100, (0 missing)
      LSTAT   < 7.685    to the right, improve=0.20132820, (0 missing)
      TAX     < 222.5    to the right, improve=0.18184980, (0 missing)
      PTRATIO < 19.15    to the right, improve=0.10392560, (0 missing)
      NOX     < 0.5125   to the right, improve=0.09501072, (0 missing)
  Surrogate splits:
      LSTAT < 4.905    to the right, agree=0.828, adj=0.20, (0 split)
      CRIM  < 0.016545 to the right, agree=0.802, adj=0.08, (0 split)

Node number 11: 3 observations
  mean=50, MSE=0 

Node number 14: 3 observations
  mean=33.3, MSE=74.60667 

Node number 15: 20 observations
  mean=46.625, MSE=14.00188 

Node number 20: 91 observations
  mean=22.53516, MSE=8.50184 

Node number 21: 25 observations
  mean=27.208, MSE=8.907936 

n=302 (36 observations deleted due to missingness)

node), split, n, deviance, yval
      * denotes terminal node

 1) root 302 24963.1200 24.11026  
   2) RM< 6.797 241  7852.8710 20.83278  
     4) LSTAT>=11.49 122  1701.2110 17.53934  
       8) CRIM>=5.43706 25   141.4056 13.37600 *
       9) CRIM< 5.43706 97  1014.7850 18.61237 *
     5) LSTAT< 11.49 119  3471.7000 24.20924  
      10) DIS>=1.48495 116  1424.6030 23.54224  
        20) RM< 6.543 91   773.6675 22.53516 *
        21) RM>=6.543 25   222.6984 27.20800 *
      11) DIS< 1.48495 3     0.0000 50.00000 *
   3) RM>=6.797 61  4293.5680 37.05902  
     6) RM< 7.437 38  1064.1230 32.32105 *
     7) RM>=7.437 23   967.0461 44.88696  
      14) PTRATIO>=18.3 3   223.8200 33.30000 *
      15) PTRATIO< 18.3 20   280.0375 46.62500 *