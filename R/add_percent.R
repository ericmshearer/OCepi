#' Add Proportion
#'
#' Calculate percentage per category with options to round and multiply by 100.
#'
#' @param n Count/frequency variable.
#' @param digits Number of digits to round.
#' @param multiply Default set to TRUE. To keep as fraction set to FALSE.
#'
#' @return Proportion.
#' @export
#'
#' @examples
#' df <- data.frame(species = c("Droid","Human","Wookie"), n = c(3,12,1))
#' df$percent <- add_percent(df$n)
#' df
add_percent <- function(n, digits = 2, multiply = TRUE){

  if(multiply == TRUE){
    proportion = round(n/sum(n) * 100, digits = digits)
  } else{
    proportion = round(n/sum(n), digits = digits)
  }

  return(proportion)
}
