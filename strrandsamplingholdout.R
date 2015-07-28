strrandsamplingholdout <- function(classes,pTrain = 0.7,data = NULL,seedno = NA) {
    ## The function performs stratified random sampling in the sampling set with
    ## classes as given in the input vector with the classes for all samples. It
    ## returns a list with the indices of the samples assigned to the training 
    ## and the test sets.
    ## 
    ## Inputs:
    ## classes: vector with n elements, where n stands for the total number of
    ##          to be split in training and testing sets. The vector might have 
    ##          numerical or categorical data
    ## pTrain: Percentage of the total samples to be used for training, from
    ##         each class
    ## data: matrix or data frame with the values of samples, with dimensions
    ##       [n*m], where n is the total number of samples, m the number of 
    ##       different numerical features for each sample
    ## seedno: number of seed to reproduce the results amonf repetitive runs
    ##
    ## Output:
    ## A list with the following elements:
    ## trainID: vector with the indices of the samples assigned as training ones
    ## testID: vector with the indices of the samples assigned as testing ones
    ## xTrain: matrix or data frame with the sample values used for training (if
    ##         data != NULL)
    ## xTest: matrix or data frame with the sample values used for testing (if
    ##        data != NULL)
    ## yTrain: vector with the classes of the samples used for training
    ## yTest: vector with the classes of the samples used for testing
    
    
    numSamples = length(classes)		# the number of samples
    
    # Find the unique classes
    classesUnique = unique(classes)
    numClasses = length(classesUnique)	# number of classes
    
    # Find the indices of the training and testing samples
    idTrain <- vector()     # empty vector for the training samples indices
    idTest <- vector()      # empty vector for the testing samples indices
    for (i in 1:numClasses){
        classI <- classesUnique[i]
        indClass <- which(classes==classI)  
        numClassI <- length(indClass)       # number of samples of class i
        numTrainI <- round(pTrain * numClassI)      # we need an integer here, round to the nearest integer
        numTestI <- numClassI - numTrainI	# number of testing samples of class i
        if (!is.na(seedno)) set.seed(seedno+i)      # reproduce the results if seed is provided
        indSorted <- sample(1:numClassI, numClassI, replace=FALSE)  # suffle the samples
        
        # populate the training sets
        idTrain <- c(idTrain,indClass[indSorted[1:numTrainI]])
        if (numTestI>0){
            idTest <- c(idTest,indClass[indSorted[(numTrainI+1):numClassI]])
        }
    }
    
    if (is.null(data)) {
        strRndSamples <- list(idTrain = idTrain,idTest = idTest)
    }   
    else {
        dataTrain <- data[idTrain,]
        dataTest <- data[idTest,]
        classesTrain <- classes[idTrain]
        classesTest <- classes[idTest]
        strRndSamples <- list(idTrain = idTrain,idTest = idTest,dataTrain = dataTrain,
                              dataTest = dataTest,classesTrain = classesTrain,
                              classesTest = classesTest)
    }
}
