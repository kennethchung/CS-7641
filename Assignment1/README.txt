This document show you how to run the supervised learn against Wine dataset.
The WineDataCommon.R contains reading and setting up the wine training and test datasets.

Load Wine data and verify Wine Training and test data
1) Source WineDataCommon.R will load the following as global variables 
   a) WineFormula (Model Formula)
   b) Wine_cv (Cross Validation setting)
   c) WineTrainingData (Training Dataset)
   d) WineTestData (Test Dataset)
2) Run WineSummary() to get the summary of combined red and white dataset
3) Run WineVariableCorr() to get the predictor correlation matrix barplot
4) Run WineTargetDist() to get the wine quality distribution
5) Run Winelm() to get Wine linear regression matrix

Run supervised learning algoritum aganist wine dataset
1) Source SuperviseLearner.R first
2) Run gnn(WineFormula,Wine_cv,WineTrainingData, WineTestData,'avNNet',10) to use
   average single layer neural network where
   'avNet' is the average neural network
   10 is the maximum iterations
   The model with highest accuracy will be chosen and applied to test data for prediction
   
3) Run gnn(WineFormula,Wine_cv,WineTrainingData, WineTestData,'mlp',10) to use
   Multiple Layer Preceptron network work where
   'mlp' is the multiple layer preceptron 
   10 is the maximum iterations
   The model with highest accuracy will be chosen and applied to test data for prediction
   
4) Run gtree(WineFormula,Wine_cv,WineTrainingData, WineTestData, 0.12) to use
   rpart decision tree where
   0.12 the complexity parameter. This parameter assoicates with cross error and can be used for pruning at specific level
   gtree(WineFormula,Wine_cv,WineTrainingData, WineTestData, 0.05)
   The model with highest accuracy will be chosen and applied to test data for prediction
   
4) Run gtree(WineFormula,Wine_cv,WineTrainingData, WineTestData, -1) to use
   rpart decision tree where
   -1 is to use default setting from caret where it defaults to use 3 complexity paramters
   The model with highest accuracy will be chosen and applied to test data for prediction

5) Run gsvm(WineFormula,Wine_cv,WineTrainingData, WineTestData,'svmLinear' ) to 
   linear support vector machine kernel where
   'svmLinear' is the from KernelLab package
   It defaults to use 2^-2,0.5,1,1.5 as the cost
   The model with highest accuracy will be chosen and applied to test data for prediction
   
6) Run gsvm(WineFormula,Wine_cv,WineTrainingData, WineTestData,'svmRadial' ) to
   usse Radial Basis Function Kernel where
   'svmRadial' is the radial basis function
   It defaults to use 2^-2,0.5,1,1.5 as the cost for the model.
   The model with highest accuracy will be chosen and applied to test data for prediction


7) Run gknn(WineFormula,Wine_cv,WineTrainingData, WineTestData) to use
   k-Nearest Neighbors 
   It defaults to use 1,2,3,5,10,20,30,50 as k
   The model with highest accuracy will be chosen and applied to test data for prediction
   
8) Run gbtree(WineFormula,Wine_cv,WineTrainingData, WineTestData,10) to use
   boosted tree where
   10 is # of trials. where -1 means to use 1 to 100 trials
   gbtree(WineFormula,Wine_cv,WineTrainingData, WineTestData,-1)


Below are results of above runs.
-----------------------------------------------------------------------------------------------------------
CART 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4680, 4679, 4681, 4679, 4678, 4679, ... 

Resampling results across tuning parameters:

  cp       Accuracy  Kappa  Accuracy SD  Kappa SD
  0.00000  0.712     0.410  0.0162       0.0335  
  0.00552  0.712     0.386  0.0138       0.0288  
  0.01104  0.709     0.368  0.0128       0.0284  
  0.01657  0.709     0.368  0.0128       0.0284  
  0.02209  0.709     0.368  0.0128       0.0284  
  0.02761  0.709     0.368  0.0128       0.0284  
  0.03313  0.709     0.368  0.0128       0.0284  
  0.03865  0.709     0.368  0.0128       0.0284  
  0.04418  0.709     0.368  0.0128       0.0284  
  0.04970  0.709     0.368  0.0128       0.0284  
  0.05522  0.709     0.368  0.0128       0.0284  
  0.06074  0.709     0.368  0.0128       0.0284  
  0.06626  0.709     0.368  0.0128       0.0284  
  0.07178  0.709     0.368  0.0128       0.0284  
  0.07731  0.709     0.368  0.0128       0.0284  
  0.08283  0.709     0.368  0.0128       0.0284  
  0.08835  0.709     0.368  0.0128       0.0284  
  0.09387  0.709     0.368  0.0128       0.0284  
  0.09939  0.709     0.368  0.0128       0.0284  
  0.10492  0.706     0.366  0.0162       0.0298  
  0.11044  0.695     0.356  0.0299       0.0405  
  0.11596  0.680     0.343  0.0291       0.0372  
  0.12148  0.670     0.338  0.0218       0.0338  
  0.12700  0.668     0.339  0.0203       0.0349  
  0.13253  0.668     0.339  0.0203       0.0349  
  0.13805  0.665     0.327  0.0226       0.0707  
  0.14357  0.660     0.314  0.0228       0.0911  
  0.14909  0.658     0.303  0.0250       0.1076  
  0.15461  0.652     0.277  0.0272       0.1292  
  0.16014  0.625     0.145  0.0261       0.1585  

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was cp = 0.005521912. 
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      0     39    0
  Better    0    662  121
  Good      0    259  217

Overall Statistics
                                         
               Accuracy : 0.6772         
                 95% CI : (0.651, 0.7026)
    No Information Rate : 0.7396         
    P-Value [Acc > NIR] : 1              
                                         
                  Kappa : 0.2957         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity                   NA        0.6896      0.6420
Specificity              0.96995        0.6420      0.7302
Pos Pred Value                NA        0.8455      0.4559
Neg Pred Value                NA        0.4214      0.8528
Prevalence               0.00000        0.7396      0.2604
Detection Rate           0.00000        0.5100      0.1672
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy             NA        0.6658      0.6861
-----------------------------------------------------------------------------------------------------------
Model Averaged Neural Network 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4679, 4679, 4679, 4681, 4679, 4679, ... 

Resampling results across tuning parameters:

  size  decay  Accuracy  Kappa  Accuracy SD  Kappa SD
  1     0e+00  0.650     0.163  0.0488       0.1665  
  1     1e-04  0.710     0.381  0.0227       0.0565  
  1     1e-01  0.711     0.392  0.0219       0.0449  
  3     0e+00  0.681     0.252  0.0503       0.1595  
  3     1e-04  0.733     0.435  0.0200       0.0422  
  3     1e-01  0.729     0.427  0.0213       0.0450  
  5     0e+00  0.660     0.188  0.0594       0.1908  
  5     1e-04  0.740     0.452  0.0198       0.0434  
  5     1e-01  0.733     0.436  0.0207       0.0442  

Tuning parameter 'bag' was held constant at a value of FALSE
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were size = 5, decay = 1e-04 and bag = FALSE. 
        prediction
actual   Best Better Good
  Best      0     39    0
  Better    0    644  139
  Good      0    180  296
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      0     39    0
  Better    0    644  139
  Good      0    180  296

Overall Statistics
                                         
               Accuracy : 0.7242         
                 95% CI : (0.699, 0.7484)
    No Information Rate : 0.6649         
    P-Value [Acc > NIR] : 2.45e-06       
                                         
                  Kappa : 0.4206         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity                   NA        0.7462      0.6805
Specificity              0.96995        0.6805      0.7914
Pos Pred Value                NA        0.8225      0.6218
Neg Pred Value                NA        0.5748      0.8309
Prevalence               0.00000        0.6649      0.3351
Detection Rate           0.00000        0.4961      0.2280
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy             NA        0.7133      0.7359
----------------------------------------------------------------------------------------------------
Multi-Layer Perceptron 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold) 

Summary of sample sizes: 4680, 4679, 4679, 4679, 4679, 4679, ... 

Resampling results across tuning parameters:

  size  Accuracy  Kappa  Accuracy SD  Kappa SD
  1     0.712     0.389  0.0171       0.0384  
  3     0.721     0.418  0.0182       0.0383  
  5     0.726     0.417  0.0167       0.0411  

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was size = 5. 
        prediction
actual   Best Better Good
  Best      0     38    1
  Better    0    625  158
  Good      0    131  345
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      0     38    1
  Better    0    625  158
  Good      0    131  345

Overall Statistics
                                          
               Accuracy : 0.7473          
                 95% CI : (0.7227, 0.7707)
    No Information Rate : 0.6117          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.4828          
 Mcnemar's Test P-Value : 5.066e-09       

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity                   NA        0.7872      0.6845
Specificity              0.96995        0.6865      0.8350
Pos Pred Value                NA        0.7982      0.7248
Neg Pred Value                NA        0.6718      0.8066
Prevalence               0.00000        0.6117      0.3883
Detection Rate           0.00000        0.4815      0.2658
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy             NA        0.7368      0.7598
  
  
  
  
----------------------------------------------------------------------------------------------------
Evaluation on training data (5199 cases):

Trial	    Decision Tree   
-----	  ----------------  
	  Size      Errors  

   0	   150  966(18.6%)
   1	    84 1308(25.2%)
   2	   115 1250(24.0%)
   3	   108 1446(27.8%)
   4	    92 1549(29.8%)
   5	   102 1498(28.8%)
   6	    74 1564(30.1%)
   7	    99 1863(35.8%)
   8	    71 1704(32.8%)
   9	   119 1437(27.6%)
  10	    99 1683(32.4%)
  11	    98 1581(30.4%)
  12	    82 1456(28.0%)
  13	   114 1720(33.1%)
  14	    82 1915(36.8%)
  15	    37 1965(37.8%)
  16	    52 1738(33.4%)
  17	    67 1714(33.0%)
  18	    73 1881(36.2%)
  19	    58 1903(36.6%)
  20	    89 1785(34.3%)
  21	    46 2016(38.8%)
  22	    47 1793(34.5%)
  23	    34 1869(35.9%)
  24	    11 1531(29.4%)
  25	    19 1750(33.7%)
boost	        708(13.6%)   <<


	   (a)   (b)   (c)    <-classified as
	  ----  ----  ----
	    22   137          (a): class Best
	        2863   269    (b): class Better
	         302  1606    (c): class Good


	Attribute usage:

	100.00%	free.sulfur.dioxide
	100.00%	volatile.acidity
	100.00%	alcohol
	 99.96%	sulphates
	 99.85%	pH
	 99.56%	residual.sugar
	 99.52%	fixed.acidity
	 98.96%	chlorides
	 98.38%	total.sulfur.dioxide
	 96.67%	citric.acid


Time: 2.4 secs

C5.0 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4679, 4679, 4680, 4680, 4678, 4679, ... 

Resampling results across tuning parameters:

  model  winnow  trials  Accuracy  Kappa  Accuracy SD  Kappa SD
  rules  FALSE     1     0.734     0.448  0.0163       0.0330  
  rules  FALSE    10     0.754     0.494  0.0168       0.0326  
  rules  FALSE    20     0.755     0.496  0.0164       0.0333  
  rules  FALSE    30     0.755     0.497  0.0165       0.0332  
  rules  FALSE    40     0.755     0.498  0.0161       0.0324  
  rules  FALSE    50     0.755     0.498  0.0161       0.0324  
  rules  FALSE    60     0.755     0.498  0.0161       0.0324  
  rules  FALSE    70     0.755     0.498  0.0161       0.0324  
  rules  FALSE    80     0.755     0.498  0.0161       0.0324  
  rules  FALSE    90     0.755     0.498  0.0161       0.0324  
  rules  FALSE   100     0.755     0.498  0.0161       0.0324  
  rules   TRUE     1     0.729     0.437  0.0167       0.0362  
  rules   TRUE    10     0.745     0.474  0.0210       0.0430  
  rules   TRUE    20     0.745     0.474  0.0204       0.0428  
  rules   TRUE    30     0.744     0.472  0.0194       0.0418  
  rules   TRUE    40     0.744     0.473  0.0193       0.0417  
  rules   TRUE    50     0.744     0.473  0.0193       0.0417  
  rules   TRUE    60     0.744     0.473  0.0193       0.0417  
  rules   TRUE    70     0.744     0.473  0.0193       0.0417  
  rules   TRUE    80     0.744     0.473  0.0193       0.0417  
  rules   TRUE    90     0.744     0.473  0.0193       0.0417  
  rules   TRUE   100     0.744     0.473  0.0193       0.0417  
  tree   FALSE     1     0.732     0.448  0.0182       0.0360  
  tree   FALSE    10     0.757     0.492  0.0197       0.0408  
  tree   FALSE    20     0.759     0.496  0.0232       0.0504  
  tree   FALSE    30     0.761     0.501  0.0225       0.0473  
  tree   FALSE    40     0.758     0.493  0.0219       0.0464  
  tree   FALSE    50     0.760     0.500  0.0219       0.0467  
  tree   FALSE    60     0.759     0.496  0.0217       0.0459  
  tree   FALSE    70     0.760     0.499  0.0217       0.0457  
  tree   FALSE    80     0.760     0.499  0.0216       0.0454  
  tree   FALSE    90     0.759     0.497  0.0206       0.0431  
  tree   FALSE   100     0.762     0.503  0.0221       0.0462  
  tree    TRUE     1     0.726     0.434  0.0182       0.0378  
  tree    TRUE    10     0.748     0.475  0.0156       0.0321  
  tree    TRUE    20     0.753     0.485  0.0193       0.0404  
  tree    TRUE    30     0.753     0.486  0.0211       0.0441  
  tree    TRUE    40     0.753     0.484  0.0202       0.0423  
  tree    TRUE    50     0.753     0.486  0.0199       0.0414  
  tree    TRUE    60     0.752     0.483  0.0195       0.0407  
  tree    TRUE    70     0.753     0.484  0.0199       0.0412  
  tree    TRUE    80     0.752     0.484  0.0198       0.0412  
  tree    TRUE    90     0.753     0.485  0.0204       0.0424  
  tree    TRUE   100     0.754     0.487  0.0214       0.0442  

Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were trials = 100, model = tree and winnow = FALSE. 
   trials model winnow
11    100  tree  FALSE
 [1] "alcohol"              "sulphates"            "free.sulfur.dioxide"  "fixed.acidity"       
 [5] "volatile.acidity"     "residual.sugar"       "pH"                   "chlorides"           
 [9] "citric.acid"          "total.sulfur.dioxide"
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      1     37    1
  Better    0    663  120
  Good      0    156  320

Overall Statistics
                                          
               Accuracy : 0.7581          
                 95% CI : (0.7338, 0.7812)
    No Information Rate : 0.6595          
    P-Value [Acc > NIR] : 7.922e-15       
                                          
                  Kappa : 0.4934          
 Mcnemar's Test P-Value : 2.856e-09       

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity            1.0000000        0.7745      0.7256
Specificity            0.9707016        0.7285      0.8180
Pos Pred Value         0.0256410        0.8467      0.6723
Neg Pred Value         1.0000000        0.6252      0.8528
Prevalence             0.0007704        0.6595      0.3398
Detection Rate         0.0007704        0.5108      0.2465
Detection Prevalence   0.0300462        0.6032      0.3667
Balanced Accuracy      0.9853508        0.7515      0.7718
--------------------------------------------------------------------------------------
Support Vector Machines with Linear Kernel 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4679, 4679, 4678, 4680, 4679, 4678, ... 

Resampling results across tuning parameters:

  C     Accuracy  Kappa  Accuracy SD  Kappa SD
  0.25  0.718     0.4    0.0172       0.0379  
  0.50  0.718     0.4    0.0174       0.0382  
  1.00  0.718     0.4    0.0174       0.0381  
  1.50  0.718     0.4    0.0174       0.0383  

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was C = 1. 
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      0     39    0
  Better    0    647  136
  Good      0    209  267

Overall Statistics
                                          
               Accuracy : 0.7042          
                 95% CI : (0.6785, 0.7289)
    No Information Rate : 0.6895          
    P-Value [Acc > NIR] : 0.1333          
                                          
                  Kappa : 0.3708          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity                   NA        0.7229      0.6625
Specificity              0.96995        0.6625      0.7665
Pos Pred Value                NA        0.8263      0.5609
Neg Pred Value                NA        0.5184      0.8345
Prevalence               0.00000        0.6895      0.3105
Detection Rate           0.00000        0.4985      0.2057
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy             NA        0.6927      0.7145

------------------------------------------------------------------------------------------
Support Vector Machines with Radial Basis Function Kernel 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4679, 4678, 4679, 4679, 4680, 4679, ... 

Resampling results across tuning parameters:

  C     Accuracy  Kappa  Accuracy SD  Kappa SD
  0.25  0.720     0.396  0.0168       0.0374  
  0.50  0.723     0.406  0.0180       0.0386  
  1.00  0.728     0.418  0.0187       0.0397  
  1.50  0.730     0.422  0.0176       0.0376  

Tuning parameter 'sigma' was held constant at a value of 0.02
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were sigma = 0.02 and C = 1.5. 
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best      0     39    0
  Better    0    656  127
  Good      0    213  263

Overall Statistics
                                          
               Accuracy : 0.708           
                 95% CI : (0.6824, 0.7326)
    No Information Rate : 0.6995          
    P-Value [Acc > NIR] : 0.2633          
                                          
                  Kappa : 0.3759          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity                   NA        0.7225      0.6744
Specificity              0.96995        0.6744      0.7654
Pos Pred Value                NA        0.8378      0.5525
Neg Pred Value                NA        0.5107      0.8455
Prevalence               0.00000        0.6995      0.3005
Detection Rate           0.00000        0.5054      0.2026
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy             NA        0.6984      0.7199
------------------------------------------------------------------------------------------

k-Nearest Neighbors 

5199 samples
  10 predictor
   3 classes: 'Best', 'Better', 'Good' 

Pre-processing: re-scaling to [0, 1] 
Resampling: Cross-Validated (10 fold, repeated 3 times) 

Summary of sample sizes: 4679, 4679, 4679, 4680, 4678, 4679, ... 

Resampling results across tuning parameters:

  k   Accuracy  Kappa  Accuracy SD  Kappa SD
   1  0.745     0.490  0.0189       0.0371  
   2  0.698     0.396  0.0148       0.0298  
   3  0.714     0.417  0.0208       0.0411  
   5  0.718     0.418  0.0160       0.0332  
  10  0.718     0.410  0.0165       0.0347  
  20  0.721     0.408  0.0163       0.0354  
  30  0.720     0.407  0.0170       0.0372  
  50  0.717     0.398  0.0147       0.0333  

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was k = 1. 
Confusion Matrix and Statistics

        prediction
actual   Best Better Good
  Best     13     24    2
  Better   21    635  127
  Good      0    146  330

Overall Statistics
                                          
               Accuracy : 0.7535          
                 95% CI : (0.7291, 0.7767)
    No Information Rate : 0.6202          
    P-Value [Acc > NIR] : <2e-16          
                                          
                  Kappa : 0.5024          
 Mcnemar's Test P-Value : 0.3179          

Statistics by Class:

                     Class: Best Class: Better Class: Good
Sensitivity              0.38235        0.7888      0.7190
Specificity              0.97943        0.6998      0.8260
Pos Pred Value           0.33333        0.8110      0.6933
Neg Pred Value           0.98332        0.6699      0.8431
Prevalence               0.02619        0.6202      0.3536
Detection Rate           0.01002        0.4892      0.2542
Detection Prevalence     0.03005        0.6032      0.3667
Balanced Accuracy        0.68089        0.7443      0.7725