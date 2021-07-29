filter_fish <- function(fish, forklength, weight, sex){
  x <- fish[fish$forklength_cm >= forklength[1] & fish$forklength_cm <= forklength[2],]
  x <- x[x$weight_kg >= weight[1] & x$weight_kg <= weight[2],]
  x <- x[x$sex %in% sex,]
  x
}
