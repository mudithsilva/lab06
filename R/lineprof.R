library(lineprof)
source("R/greedy_knapsack.R")
source("R/knapsack.R")
source("R/knapsack2.R")
options(max.print = 100000)
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )
l <- lineprof(greedy_knapsack(x = knapsack_objects[1:800,], W = 3500))
l <- lineprof(brute_force_knapsack(x = knapsack_objects[1:800,], W = 3500))
