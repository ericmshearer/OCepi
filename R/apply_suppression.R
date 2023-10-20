#' Data Suppression for Low Category Frequencies
#'
#' @param n Input field to be suppressed.
#' @param threshold Threshold when checking for suppression.
#' @param replace_with Value to use when input field is suppressed. String, numeric, or NA.
#'
#' @return Suppressed value to be used in public reporting.
#' @export
#'
#' @examples
#' df <- data.frame(Counts = c(5, 1, 10, 3, 12, 9, 4))
#' df$Counts_Suppressed <- apply_suppression(df$Counts, threshold = 5, replace_with = "**")
apply_suppression <- function(n, threshold = NULL, replace_with = NULL){

  if(class(n)!="numeric" | class(threshold)!="numeric"){
    stop("Input not in numerical format.")
  }

  suppressed_values = ifelse(n < threshold, replace_with, n)

  return(suppressed_values)

}
