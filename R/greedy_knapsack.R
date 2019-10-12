#' @title Greedy Knapsack Algorithm
#'
#' @param x data.frame with colnames 'v' & 'w'
#' @param W Knapsack Maximum Weight
#'
#' @return Return best Knapsack combination with maximum value
#' @export
#'
#' @examples
#' set.seed(42)
#'n <- 2000
#'knapsack_objects <- data.frame(
#'  w=sample(1:4000, size = n, replace = TRUE),
#'  v=runif(n = n, 0, 10000)
#')
#'greedy_knapsack(x = knapsack_objects[1:8,], W = 3500)
#'

greedy_knapsack <- function(x,W) {

  if (!is.data.frame(x)) {
    stop("The input is not a dataframe")
  }

  if (W < 1) {
    stop("Please Enter valid Weight")
  }

  if (!(all(colnames(x) %in% c("v","w")))) {
    stop("Variable name in the dataframe are not named correctly")
  }

  best_combination <- list()
  best_combination[["value"]] = 0
  best_combination[["elements"]] = 0

  valuePerWeight <- x[,"v"] / x[,"w"]
  x["valuePerWeight"] <- valuePerWeight


  x <- x[order(x["valuePerWeight"], decreasing = TRUE),] # Sorting - Decreasing
  maxWeight <- W
  totalSum <- 0
  rowItem <- 1

  for (rowItem in 1:nrow(x)) {
    if (x[,"w"][rowItem] < maxWeight) {
      if (maxWeight > 0) {
        maxWeight <- maxWeight - x[,"w"][rowItem]
        totalSum <- totalSum + x[,"v"][rowItem]
        best_combination[["elements"]] <- c(best_combination[["elements"]], as.numeric(row.names(x)[rowItem]))
      }
    } else {
      break()
    }
  }

  best_combination[["elements"]] = best_combination[["elements"]][which(best_combination[["elements"]] > 0)]
  best_combination[["value"]] = round(totalSum, digits = 0)
  return(best_combination)
}

# RNGkind(sample.kind = "Rounding")
# set.seed(42)
# n <- 2000
# knapsack_objects <- data.frame(
#  w=sample(1:4000, size = n, replace = TRUE),
#  v=runif(n = n, 0, 10000)
# )
# greedy_knapsack(x = knapsack_objects[1:8,], W = 3500)


