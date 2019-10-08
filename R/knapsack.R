brute_force_knapsack = function(x, W){
  maximum_knapsack = "vector"
  if (!(as.data.frame(x)))
    stop("The input is not a dataframe")
  if (!(colnames(x) %in% c("v","w")))
    stop("Variable name in the dataframe are not named correctly")
  for (i in length(x)){
    if (x["w"]<0 || x["v"]<0)
      stop("all value must be positive")
  }

for (h in length(x)){
  print(length(x))
 print(x[h,"w"])
  print(x[h,"v"])
}


  return(maximum_knapsack)
}

#Testing the function
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


brute_force_knapsack(knapsack_objects)



