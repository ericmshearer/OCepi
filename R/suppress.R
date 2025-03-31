#' Data Suppression for Low Category Frequencies
#'
#' Mask values/counts below a specified threshold to maintain patient confidentiality.
#'
#' @param n Input field to be suppressed.
#' @param less_than Maximum value for suppression.
#' @param replace_with Value to use when input field is suppressed. String, numeric, or NA.
#'
#' @return Suppressed value.
#' @export
#'
#' @examples
#' df <- data.frame(Counts = c(5, 1, 10, 3, 12, 9, 4))
#' df$Counts_Suppressed <- suppress(df$Counts, less_than = 5, replace_with = "**")
#' df
suppress <- function(n, less_than = 5, replace_with = "**"){
  if(!inherits(n, c("numeric","integer")) | !inherits(less_than, c("numeric","integer"))){
    stop("Input not in numerical format.")
  }
  suppressed_values = ifelse(n < less_than, replace_with, n)
  return(suppressed_values)
}
