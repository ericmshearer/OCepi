#' Add Proportion
#'
#' Calculate percentage per category with options to round and multiply by 100.
#'
#' @param n Count/frequency variable.
#' @param digits Number of digits to round.
#' @param multiply Boolean TRUE/FALSE to multiply proportion by 100.
#'
#' @return Proportion.
#' @export
#'
#' @examples
#' library(dplyr)
#' starwars %>% head(20) %>% count(species) %>% mutate(percent = add_percent(n))
add_percent <- function(n, digits = 2, multiply = TRUE){

  if(multiply == TRUE){
    proportion = round(n/sum(n) * 100, digits = digits)
  } else{
    proportion = round(n/sum(n), digits = digits)
  }

  return(proportion)
}
