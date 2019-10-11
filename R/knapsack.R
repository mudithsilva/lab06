#' #'@export brute_force_knapsack
#' calculate_binary_matrix = function(x){
#'   library(data.table)
#'   options(max.print=1000000)
#'   return(do.call(CJ, replicate(x, 0:1, FALSE)))
#' }
#'
#' brute_force_knapsack = function (x,W){
#' # The running time for this function is 11.59642 secs
#'   if (W < 1){
#'     stop("The weight value is not valid")
#'   }
#'   for (y in colnames(x)){
#'     if (!(y %in% c("v","w")))
#'       stop("Variable name in the dataframe are not named correctly")
#'   }
#'
#'     library(data.table)
#'   options(max.print=1000000)
#'   binaryMatrix <- calculate_binary_matrix(nrow(x))
#'   weightAndValueMatrix <- matrix(nrow = nrow(x),ncol = 2+ncol(x))
#'   mat <- matrix(unlist(binaryMatrix),ncol = nrow(x))
#'   colnames(mat) <- c(x[,"w"])
#'   matrixWithWeight <- cbind(mat,c("weight"=0))
#'   colnames(matrixWithWeight)[ncol(matrixWithWeight)] <- "weight"
#'   matrixWithWeight <- cbind(matrixWithWeight,c("value"=0))
#'   colnames(matrixWithWeight)[ncol(matrixWithWeight)] <- "value"
#'
#'    for (i in 1:nrow(matrixWithWeight)){
#'      xm <- which(matrixWithWeight[i,] ==1, arr.ind = T)
#'      weightValue <- 0
#'      valueSum <- 0
#'
#'      for (j in xm){
#'        weightValue <- weightValue+as.numeric(colnames(matrixWithWeight)[j])
#'        valueSum <- valueSum+round(x[which(x$w == as.numeric(colnames(matrixWithWeight)[j])),"v"])
#'      }
#'
#'      if (weightValue <= W){
#'        matrixWithWeight[i,"weight"] <- weightValue
#'        matrixWithWeight[i,"value"] <- valueSum
#'      }
#'    }
#'
#'   maxValueRowNumver <- which(matrixWithWeight == max(matrixWithWeight[,"value"]), arr.ind=TRUE)
#'   colNamesValue <- which(matrixWithWeight[maxValueRowNumver[1],] ==1, arr.ind = F)
#'   names(colNamesValue) <- NULL
#'   result <- list("value" = max(matrixWithWeight[,"value"]), "elements"=colNamesValue)
#'   return(result)
#'
#' }
#'
#'
#' #Testing the function
#' #RNGkind(sample.kind = "Rounding")
#' set.seed(42)
#' n <- 2000
#' knapsack_objects <-
#'   data.frame(
#'     w=sample(1:4000, size = n, replace = TRUE),
#'     v=runif(n = n, 0, 10000)
#'   )
#'
#' start_time <- Sys.time()
#' brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
#' end_time <- Sys.time()
#' print(end_time - start_time)
#'
#'
#'
