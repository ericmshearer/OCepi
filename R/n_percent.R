#' Plot Labels for Counts & Proportion
#'
#' Standardized plot labels with options for ordering.
#'
#' @param n Counts variable.
#' @param percent Proportion variable.
#' @param reverse Default set to false. Order switched to percent n if FALSE.
#' @param n_suppress Maximum value for suppression. Returns double asterisk.
#'
#' @return Plot label as character.
#' @export
#'
#' @examples
#' n_percent(5, 25)
#' n_percent(5, 25, reverse = TRUE)
n_percent <- function(n, percent, reverse = FALSE, n_suppress = NULL){
  percent = ifelse(n > 0 & percent < 1, "<1%", sprintf("%s%%", percent))
  label = sprintf("%s (%s)", formatC(n, big.mark = ","), percent)
  if(reverse == TRUE){
    label = sprintf("%s (%s)", percent, formatC(n, big.mark = ","))
  }
  if(!is.null(n_suppress)){
    label = ifelse(n < n_suppress, "**", label)
  }
  return(label)
}
