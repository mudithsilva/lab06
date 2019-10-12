# library(profvis)
#
# profvis({
#   set.seed(42)
#   n <- 2000
#   knapsack_objects <-
#     data.frame(
#       w=sample(1:4000, size = n, replace = TRUE),
#       v=runif(n = n, 0, 10000)
#     )
#   # ----- Brute Force Knapsack ------ #
#   item1 <- brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500)
#   # ----- Brute Force Knapsack ------ #
#
#   # ----- Brute Force Knapsack -with Parallel ----- #
#   item2 <- brute_force_knapsack(x = knapsack_objects[1:16,], W = 3500, parallel = TRUE)
#   # ----- Brute Force Knapsack -with Parallel ----- #
#
#   # ----- Dynamic Programming for Knapsack ----- #
#   item3 <- dynamic_knapsack(x = knapsack_objects[1:500,], W = 3500)
#   # ----- Dynamic Programming for Knapsack ----- #
#
#   # ----- Greedy heuristic for Knapsack ----- #
#   item4 <- greedy_knapsack(x = knapsack_objects[1:1000000,], W = 3500)
#   # ----- Greedy heuristic for Knapsack ----- #
# })
