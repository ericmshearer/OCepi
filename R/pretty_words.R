#' Messy String to Title Casing
#'
#' Convert string to title casing. Useful for fixing patient or street names.
#'
#' @param x String variable
#'
#' @return Input string in title casing format.
#' @export
#'
#' @examples
#' pretty_words("MeSsY DaTa GiVeS mE a HeAdAcHe.")
pretty_words <- function(x){
  x = gsub("([\\w])([\\w]+)", "\\U\\1\\L\\2", x, perl = TRUE)
  return(x)
}
