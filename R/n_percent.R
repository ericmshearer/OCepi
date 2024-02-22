#' Plot Labels for Counts & Proportion
#'
#' Standardized plot labels with options for order: "n (%)" or "% (n)".
#'
#' @param n Counts variable.
#' @param percent Proportion variable.
#' @param reverse TRUE/FALSE to set order.
#'
#' @return Plot label as character.
#' @export
#'
#' @examples
#' n_percent(5, 25)
n_percent <- function(n, percent, reverse = FALSE){
  percent = ifelse(percent < 1, "<1%", sprintf("%s%%", percent))
  label = sprintf("%s (%s)", formatC(n, big.mark = ","), percent)
  if(reverse == TRUE){
    label = sprintf("%s (%s)", percent, formatC(n, big.mark = ","))
  }
  return(label)
}
