#' Calculate Incidence Rate per 100,000
#'
#' Calculate incidence rate using your own population denominator.
#'
#' @param n Number of cases.
#' @param pop Population denominator.
#' @param digits Number of digits to round rate.
#'
#' @return Crude rate per 100,000.
#' @export
#'
#' @examples
#' rate_per_100k(5, 320000, digits = 1)
rate_per_100k <- function(n, pop, digits = 1){
  if(!class(n) %in% c("numeric","integer") | !class(pop) %in% c("numeric","integer")){
    stop("Input variables are not numeric.")
  }
  rate = round((n/pop)*100000, digits = digits)
  return(rate)
}
