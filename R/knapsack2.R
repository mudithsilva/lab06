library(parallel)

brute_force_knapsack <- function(x,W,parallel = FALSE) {
#The running time for this function is 0.6906214 secs
  if (!is.data.frame(x)) {
    stop("The input is not a dataframe")
  }

  if (W < 1) {
    stop("Please Enter valid Weight")
  }

  if (!(all(colnames(x) %in% c("v","w")))) {
    stop("Variable name in the dataframe are not named correctly")
  }

  # for (y in colnames(x)){
  #   if (!(y %in% c("v","w")))
  #     stop("Variable name in the dataframe are not named correctly")
  # }

  # --------- Functions for get Weights, Values and Names from Data Frame --------- #

  getAllWeight <- function(count) {
    return(combn(x[,"w"], count, sum))
  }

  getAllValues <- function(count) {
    return(combn(x[,"v"], count, sum))
  }

  getAllElements <- function(count) {
    return(combn(rownames(x), count, function(x) getElementName(x)))
  }

  getElementName <- function(names) {
    return(paste(names, collapse = ","))
  }
  # --------- Functions for get Weights, Values and Names from Data Frame --------- #

  best_combination <- list()
  best_combination[["value"]] = 0
  best_combination[["elements"]] = 0

  all_weight <- c()
  all_values <- c()
  all_elements <- c()

   if (parallel) {
    numberOfCores <- parallel::detectCores()
    clusters <- parallel::makeCluster(numberOfCores)

    all_weight <- unlist(parLapplyLB(clusters, 1:nrow(x), function(y) getAllWeight(y)))
    all_values <- unlist(parLapplyLB(clusters, 1:nrow(x), function(y) getAllValues(y)))
    all_elements <- unlist(parLapplyLB(clusters, 1:nrow(x), function(y) getAllElements(y)))

    parallel::stopCluster(clusters)
  } else {
    for(item in 1:nrow(x)) {
      set_weight <- getAllWeight(item)
      set_values <- getAllValues(item)
      set_elements <- getAllElements(item)

      all_weight <- c(all_weight, set_weight)
      all_values <- c(all_values, set_values)
      all_elements <- c(all_elements, set_elements)
    }
  }

  valid_range <- which(all_weight <= W)

  valid_weight <- all_weight[valid_range]
  valid_values <- all_values[valid_range]
  valid_elements <- all_elements[valid_range]

  max_value_element  <- which(valid_values == max(valid_values))
  best_combination[["value"]] = round(valid_values[max_value_element], digits = 0)
  best_combination[["elements"]] = as.numeric(unlist(strsplit(valid_elements[max_value_element], ",")))
  return(best_combination)
}


# RNGkind(sample.kind = "Rounding")
# set.seed(42)
# n <- 2000
# knapsack_objects <- data.frame(
#   w=sample(1:4000, size = n, replace = TRUE),
#   v=runif(n = n, 0, 10000)
# )
# #
# # brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel = TRUE)
# #brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
#
# start_time <- Sys.time()
# brute_force_knapsack_two(x = knapsack_objects[1:16,], W = 2000)
# end_time <- Sys.time()
# print(end_time - start_time)
#
# start_time <- Sys.time()
# brute_force_knapsack_two(x = knapsack_objects[1:16,], W = 2000, parallel = TRUE)
# end_time <- Sys.time()
# print(end_time - start_time)
