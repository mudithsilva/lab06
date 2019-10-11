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
#   #item1 <- greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
#   item2 <- dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500)
#   #item2 <- brute_force_knapsack2(x = knapsack_objects[1:800,], W = 3500)
#   #item3 <- brute_force_knapsack2(x = knapsack_objects[1:16,], W = 3500)
# })

