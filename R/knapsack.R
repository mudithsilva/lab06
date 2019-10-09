brute_force_knapsack = function(x, W){
  all_knapsack <- data.frame(w = numeric(0), v = numeric(0))
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
      print(x[item,"w"])
      biggerWeight <- c(x[item,"w"], x[item,"v"])
      all_knapsack <- rbind(all_knapsack,biggerWeight)
  }

names(all_knapsack) <- c("w","v")
return(all_knapsack)
}

#Testing the function
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)



