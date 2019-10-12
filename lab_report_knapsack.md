
---
title: "Knapsack"
author: "Chathuranga Silva, Mohammed Bakheet, and Nikodimos Gezahegn"
date: "11th October 2019"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{lab_report_knapsack}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---




```r
library(lab6)
```


# Using the algorithms

The three algorithms are used to solve the problem of knapsack, each algorithm has its own time slack and mechanism.  <br />  

The brute force algorithm examines all situations for the knapsack problem using brute-force search, it goes through all possible alternatives and returns the maximum value found.   <br />  
The dynamic algorithm takes another approach to the problem. If the weights are actually discrete values (as in our example) we can use this to create an algorithm that can solve the knapsack problem exact by iterating over all possible values of w.  <br />  
The greedy algorithm doesn't give an exact result, however, it is shown that it returns at least 50% of the true maximum value, and reduces the computational complexity.  <br/>  
# Usage
```c
 brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
 dynamic_knapsack(x = knapsack_objects[1:8,], W = 3500)
 greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
```

# Arguments

x
  : A dataframe containing the data to be processed by any of the three algorithms (brute force, dynamic, or greedy algorithms).
  
W
  : Tha maximum weight the sack can contain.

# Returned Value of brute force algorithm

List
  : The brute force function returns a list containing the maximum value and the elements to be included in the sack
  
# Returned Value of dynamic algorithm
 List
  : The dynamic function returns a list containing the maximum value and the elements to be included in the sack

# Returned Value of greedy algorithm

 List
  : The greedy function returns a list containing the maximum value and the elements to be included in the sack
  

# Methods

**brute_force_knapsack(x,W)**
  :The brute_force_knapsack function returns a list containing the maximum value and the elements to be included in the sack
   The brute force function also shows the time slack of the function execution time

```r
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

start_time <- Sys.time()
brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> [1] 3 8
end_time <- Sys.time()
print(end_time - start_time)
#> Time difference of 0.03319573 secs
```

**dynamic_knapsack(x,W)**
    :The dynamic_knapsack function returns a list containing the maximum value and the elements to be included in the sack
   The brute force function also shows the time slack of the function execution time.

```r
start_time <- Sys.time()
dynamic_knapsack(x = knapsack_objects[1:8,], W = 2000)
#> Error in dynamic_knapsack(x = knapsack_objects[1:8, ], W = 2000): could not find function "dynamic_knapsack"
end_time <- Sys.time()
print(end_time - start_time)
#> Time difference of 0.00297904 secs
```

**greedy_knapsack(x,W)**
  :The greedy_knapsack function returns a list containing the maximum value and the elements to be included in the sack
   The brute force function also shows the time slack of the function execution time.

```r
start_time <- Sys.time()
greedy_knapsack(x = knapsack_objects[1:8,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> [1] 8 3
end_time <- Sys.time()
print(end_time - start_time)
#> Time difference of 0.01245141 secs
```

# References

R packages by Hadley Wickham 

