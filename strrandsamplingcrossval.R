strrandsamplingcrossval <- function(classes,nfolds = 10,data = NULL,seedno = NA) {
    ## The function performs stratified random sampling for n-fold 
    ## cross-validation in the sampling set with classes as given in the input 
    ## vector with the classes for all samples. It returns a list with the
    ## indices of the samples assigned to each of the nfolds sets.
    ## 
    ## Inputs:
    ## classes: vector with n elements, where n stands for the total number of
    ##          to be split in training and testing sets. The vector might have 
    ##          numerical or categorical data.
    ## nfolds: number of folds (sets) which the total number of samples will
    ##         be split in
    ## seedno: number of seed to reproduce the results amonf repetitive runs
    ##
    ## Output:
    ## A list with nfolds elements, each one containing the indices of the 
    ## samples assigned to the respective fold (set)

    if(nfolds < 1) stop("wrong number of folds")
    numSamples = length(classes)		# the number of samples
    if(nfolds > numSamples) warning("number of folds larger than number of samples, some folds will be empty")
    
    # Find the unique classes
    classesUnique = unique(classes)
    numClasses = length(classesUnique)	# number of classes
    
    # Find the indices of the folds
    id <- NULL
    for (i in 1:nfolds){
        id[[i]] <- vector()     # empty vector for the samples indices
    }
    count <- 0      # counter to help result in folds with equal number of samples
    for (i in 1:numClasses){
        classI <- classesUnique[i]
        indClass <- which(classes==classI)  
        numClassI <- length(indClass)       # number of samples of class i
        numInFold <- floor(numClassI/nfolds)      # minimum number of samples in each fold 
        if (!is.na(seedno)) set.seed(seedno+i)
        indSorted <- sample(1:numClassI, numClassI, replace=FALSE)  # suffle the samples
        
        # populate the folds
        if (numInFold > 0){
            for (j in 1:nfolds){
                id[[j]] <- c(id[[j]],indClass[indSorted[(numInFold*(j-1)+1):(numInFold*j)]])
            }
        }
        # assign the remaining samples
        if (numInFold*nfolds < numClassI){
            for (j in (numInFold*nfolds+1):numClassI){
                idSample <- (count%%nfolds) + 1
                id[[idSample]] <- c(id[[idSample]],indClass[indSorted[j]])
                count <- count + 1
            }
        }
    }
    
    id
}