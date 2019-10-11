library(parallel)
#' @title Knapsack Algorithm - Brute Force Method 2
#' @description Brute Force Optional Approch to Solve Knapsack Problem
#'
#' @param x data.frame with colnames 'v' & 'w'
#' @param W Knapsack Maximum Weight
#' @return Return best Knapsack combination with maximum value
#' @export
#' @import parallel
#' @examples
#' set.seed(42)
#'n <- 2000
#'knapsack_objects <-
#'  data.frame(
#'    w=sample(1:4000, size = n, replace = TRUE),
#'    v=runif(n = n, 0, 10000)
#'  )
#'  brute_force_knapsack2(x = knapsack_objects[1:8,], W = 2000)
#'

brute_force_knapsack2 <- function(x,W,parallel = FALSE) {
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

  if (parallel) {
    numberOfCores <- parallel::detectCores() - 1
    clusters <- parallel::makeCluster(getOption("cl.cores", 2))
    # --------- Functions for Names from Data Frame, and Parallel Computing Func --------- #

    getElementName <- function(names) {
      return(paste(names, collapse = ","))
    }
    # --------- Functions for Names from Data Frame --------- #

    best_combination <- list()
    best_combination[["value"]] = 0
    best_combination[["elements"]] = 0

    all_weight <- c()
    all_values <- c()
    all_elements <- c()


    all_weight <- unlist(parLapplyLB(clusters, 1:nrow(x), function(item) combn(x[,"w"], item, sum)))
    all_values <- unlist(parLapplyLB(clusters, 1:nrow(x), function(item) combn(x[,"v"], item, sum)))
    all_elements <- unlist(parLapplyLB(clusters, 1:nrow(x), function(item) combn(rownames(x), item, function(x) getElementName(x))))

    valid_range <- unlist(clusterCall(clusters, function(y) which(all_weight <= W)))

    valid_weight <- unlist(clusterCall(clusters, function(y) all_weight[valid_range]))
    valid_values <-  unlist(clusterCall(clusters, function(y) all_values[valid_range]))
    valid_elements <- unlist(clusterCall(clusters, function(y) all_elements[valid_range]))

    max_value_element  <- unlist(clusterCall(clusters, function(y) which(valid_values == max(valid_values))))
    best_combination[["value"]] = round(valid_values[max_value_element], digits = 0)
    best_combination[["elements"]] = as.numeric(unlist(strsplit(valid_elements[max_value_element], ",")))

    parallel::stopCluster(clusters)
    return(best_combination)
  } else {
    # --------- Functions for Names from Data Frame --------- #

    getElementName <- function(names) {
      return(paste(names, collapse = ","))
    }
    # --------- Functions for Names from Data Frame --------- #

    best_combination <- list()
    best_combination[["value"]] = 0
    best_combination[["elements"]] = 0

    all_weight <- c()
    all_values <- c()
    all_elements <- c()

    for(item in 1:nrow(x)) {
      set_weight <- combn(x[,"w"], item, sum)
      set_values <- combn(x[,"v"], item, sum)
      set_elements <- combn(rownames(x), item, function(x) getElementName(x))

      all_weight <- c(all_weight, set_weight)
      all_values <- c(all_values, set_values)
      all_elements <- c(all_elements, set_elements)
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


}


# RNGkind(sample.kind = "Rounding")
# set.seed(42)
# n <- 2000
# knapsack_objects <- data.frame(
#   w=sample(1:4000, size = n, replace = TRUE),
#   v=runif(n = n, 0, 10000)
# )
# system.time(brute_force_knapsack2(x = knapsack_objects[1:20,], W = 3500, parallel = TRUE))
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
