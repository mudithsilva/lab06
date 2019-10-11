
dynamic_knapsack <- function(x,W) {

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

  best_combination <- list()
  best_combination[["value"]] = 0
  best_combination[["elements"]] = 0

  weight_mat <- matrix(NA, ncol = (W + 1), nrow = (nrow(x) + 1))
  weight_mat[1,] <- 0
  weight_mat[,1] <- 0

  weight <- x$w
  value <- x$v
  items <- nrow(weight_mat)

  for (row in 2:items) {
    for (column in 2:(W + 2)) {
      if (weight[row - 1] > column - 2) {
        weight_mat[row,column - 1] = weight_mat[row - 1, column - 1]
      } else {
        weight_mat[row,column - 1] = max(weight_mat[(row - 1), (column - 1)],
                                     (weight_mat[row - 1, column - 1 - weight[row - 1]] + value[row - 1])
        )
      }
    }
  }

  mat_rows <- nrow(weight_mat)
  mat_cols <- ncol(weight_mat)
  selectedItems <- c()


  while (mat_rows > 1 & mat_cols > 1) {
    if (weight_mat[mat_rows, mat_cols] != weight_mat[mat_rows - 1, mat_cols]) {
      selectedItems <- c(selectedItems, mat_rows - 1)
      mat_cols <- mat_cols - weight[mat_rows - 1]
    }
    mat_rows <- mat_rows - 1
  }

  best_combination[["value"]] = round(weight_mat[nrow(weight_mat), ncol(weight_mat)], digits = 0)
  best_combination[["elements"]] = sort(selectedItems)

  return(best_combination)
}

set.seed(42)
n <- 2000
knapsack_objects <- data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)
dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500)
