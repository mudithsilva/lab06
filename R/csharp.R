# knapSack <- function(x,W){
#   n <- nrow(x)
#   wt <- x[,"w"]
#   val <- x[,"v"]
#   i <- numeric(0)
#   w <- numeric(0)
#
#  K <- data.frame(w = numeric(0), v = double(0.00))
#   for (i in 1:n)
#   {
#     for (w in 1:W)
#     {
#       if (i == 0 || w == 0)
#         K[i,w] <- 0
#       ival <- i-1
#       else if (wt[ival] <= w)
#         K[i,w] <- max(val[ival] + K[ival,w-wt[ival]], K[ival,w])
#       else
#         K[i,w] <- K[ival,w]
#     }
#   }
#
#   return (K[n,W])
# }
# #Testing the function
#
#
# set.seed(42)
# n <- 2000
# knapsack_objects <-
#   data.frame(
#     w=sample(1:4000, size = n, replace = TRUE),
#     v=runif(n = n, 0, 10000)
#   )
#
#
# knapSack(x = knapsack_objects[1:8,], W = 3500)



brute_force_knapsack = function(x, W){
  print(x)
  all_knapsack <- data.frame(w = numeric(0), v = double(0.00))
  maximum_knapsack = "vector"
  weight <- W
  if (!(is.data.frame(x)))
    stop("The input is not a dataframe")

  for (y in colnames(x)){
    if (!(y %in% c("v","w")))
      stop("Variable name in the dataframe are not named correctly")
  }

  for (i in 1:nrow(x)){
    if (x[i,"w"]<0 || x[i,"v"]<0)
      stop("all value must be positive")
  }

  for (item in 1:nrow(x)){
    if (x[item,"w"] < weight)
    {
      all_knapsack <- rbind(all_knapsack, c(x[item,"w"], x[item,"v"]))
      for (item2 in 1:nrow(x)){
        if ((x[item,"w"] + x[item2,"w"]) < weight){
          all_knapsack <- rbind(all_knapsack, c(w = x[item,"w"]+x[item2,"w"], v = x[item,"v"]+x[item2,"v"]))
        }
      }
    }
  }

  names(all_knapsack) <- c("w","v")
  return(all_knapsack)
}


brute_force_knapsack2 = function(x,W){
  mat <- matrix(ncol = nrow(x),nrow = 2^nrow(x))
  mat_row_names <- as.character(c(x[,"w"]))
  colnames(mat) <- mat_row_names
  options(max.print=1000000)
  return (combn(x[,"w"],7))
  return (mat)
}

calculate_binary_matrix = function(x){
  library(data.table)
  options(max.print=1000000)
  return(do.call(CJ, replicate(x, 0:1, FALSE)))
}

knapsack = function (x,W){
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
      valueSum <- valueSum+round(x[which(as.numeric(colnames(matrixWithWeight)[j]) %in% x[,"w"]),"v"])
      if (weightValue <= W){
        matrixWithWeight[i,"weight"] <- weightValue
      }
      matrixWithWeight[i,"value"] <- valueSum
    }
    #print(weightValue)
    print(matrixWithWeight[i,])
  }
  print(matrixWithWeight)
  # for (i in 1:nrow(matrixWithWeight)){
  #   if ()
  # }
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
knapsack(x = knapsack_objects[1:8,], W = 3500)
print(knapsack_objects[1:8,])


