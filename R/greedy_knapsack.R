#' @export greedy_knapsack
greedy_knapsack = function(x, W){
  if (W < 1){
    stop("The weight value is not valid")
  }
  for (y in colnames(x)){
    if (!(y %in% c("v","w")))
      stop("Variable name in the dataframe are not named correctly")
  }
#ordering the data in the dataframe x
  kgvalue <- c(0)
  itemStatus <- c(0)
  totalValue <- c(0)
  valuePerKg <- cbind(x,kgvalue)
  valuePerKg <- cbind(x,itemStatus)
  valuePerKg <- cbind(x,totalValue)
  for (i in 1:nrow(valuePerKg)){
  valuePerKg[i,"kgvalue"] <- valuePerKg[i,"v"]/valuePerKg[i,"w"]
  }
  valuePerKg <- valuePerKg[order(valuePerKg$kgvalue,decreasing = TRUE),]
  knapsakWeight <- 0

  for (i in 1:nrow(valuePerKg)){
  if (knapsakWeight <= W){
    if (valuePerKg[i,"w"]+knapsakWeight > W){
    # valuePerKg[i,"itemStatus"] <- (W-knapsakWeight)/valuePerKg[i,"w"]
    break()
    }
    else{
    knapsakWeight <- knapsakWeight + valuePerKg[i,"w"]
    valuePerKg[i,"itemStatus"] = 1
    }
    }

  }
  valuePerKg[,"kgvalue"] <- valuePerKg[,"v"]*valuePerKg[,"itemStatus"]
  valuePerKg[,"totalValue"] <- valuePerKg[,"itemStatus"]*valuePerKg[,"kgvalue"]
  valuePerKg[is.na(valuePerKg)] <- 0
  total <- round(sum(valuePerKg[,"totalValue"]))
  itemsList <- as.numeric(which(valuePerKg[,"itemStatus"]==1L))

  itemsMaximum <- max(which(valuePerKg$itemStatus==1))
  itemsList <- as.numeric(rownames(valuePerKg[1:itemsMaximum,]))
  resutl <- list("value"=total, "elements"=itemsList)
  return(resutl)

}


