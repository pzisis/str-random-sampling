# str-random-sampling
##Stratified random sampling

The functions strrandsamplingholdout and strrandsamplingcrossval implement and offer an insight in the stratified random sampling in a given dataset. 

Function strrandsamplingholdout: Based on an input vector storing the class of each sample of the dataset, the function assigns randomly a pre-defined percentage of samples from each class to the training and testing datasets. The training and testing datasets can then be used in applications such as supervised learning classification with holdout validation, by applying strrandsamplingholdout either once (e.g. 70/30 training/testing samples, the % of training samples inserted as parameter) or a number of iterations. If the data themselves are provided, the training and testing data are additionally returned, together with the respective class of each sample. 

Function strrandsamplingcrossval: In a similar notion, the function gets as input a vector with the class of each sample of the full dataset and returns the indices of the samples assigned to each of the folds (sets). The number of folds can be inserted as a parameter, with 10-fold cross validation being the default choice.

To allow reproduction of results, an integer indicating a seed for the random number generation within the functions can be provided as parameter.
