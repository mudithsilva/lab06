calculate_binary_matrix = function(x){
  library(data.table)
  options(max.print=1000000)
  return(do.call(CJ, replicate(x, 0:1, FALSE)))
}

brute_force_knapsack = function (x,W){
  library(data.table)
  options(max.print=1000000)
  binaryMatrix <- calculate_binary_matrix(nrow(x))
  weightAndValueMatrix <- matrix(nrow = nrow(x),ncol = 2+ncol(x))
  mat <- matrix(unlist(binaryMatrix),ncol = nrow(x))
  colnames(mat) <- c(x[,"w"])
  matrixWithWeight <- cbind(mat,c("weight"=0))
  colnames(matrixWithWeight)[ncol(matrixWithWeight)] <- "weight"
  matrixWithWeight <- cbind(matrixWithWeight,c("value"=0))
  colnames(matrixWithWeight)[ncol(matrixWithWeight)] <- "value"
   for (i in 1:nrow(matrixWithWeight)){
     xm <- which(matrixWithWeight[i,] ==1, arr.ind = T)
     weightValue <- 0
     valueSum <- 0
     for (j in xm){
       weightValue <- weightValue+as.numeric(colnames(matrixWithWeight)[j])
       valueSum <- valueSum+round(x[which(x$w == as.numeric(colnames(matrixWithWeight)[j])),"v"])
     }
     if (weightValue <= W){
       matrixWithWeight[i,"weight"] <- weightValue
       matrixWithWeight[i,"value"] <- valueSum
     }
   }
  maxValueRowNumver <- which(matrixWithWeight == max(matrixWithWeight[,"value"]), arr.ind=TRUE)
  colNamesValue <- which(matrixWithWeight[maxValueRowNumver[1],] ==1, arr.ind = F)
  cat(paste("$value "),sep = "\n")
  cat(paste("   ",max(matrixWithWeight[,"value"])),sep = "\n")
  cat(paste("$elements "),sep = "\n")
  elements <- as.vector(write.table(format(colNamesValue),row.names=F, col.names=F, quote=F))

  #print(max(matrixWithWeight[,"value"]))
}
#Testing the function
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


#brute_force_knapsack3(x = knapsack_objects[1:8,], W = 3500)
brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)



