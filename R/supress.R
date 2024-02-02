#' Data Suppression for Low Category Frequencies
#'
#' Mask values/counts below a specified threshold to maintain patient confidentiality.
#'
#' @param n Input field to be suppressed.
#' @param threshold Threshold when checking for suppression.
#' @param replace_with Value to use when input field is suppressed. String, numeric, or NA.
#'
#' @return Suppressed value.
#' @export
#'
#' @examples
#' df <- data.frame(Counts = c(5, 1, 10, 3, 12, 9, 4))
#' df$Counts_Suppressed <- suppress(df$Counts, threshold = 5, replace_with = "**")
suppress <- function(n, threshold = 5, replace_with = "**"){
  if(!class(n) %in% c("numeric","integer") | !class(threshold) %in% c("numeric","integer")){
    stop("Input not in numerical format.")
  }
  suppressed_values = ifelse(n < threshold, replace_with, n)
  return(suppressed_values)
}
