#' Date to Month Date
#'
#' Recode date to standard month date for dashboards or ggplots2.
#'
#' @param date Input date.
#'
#' @return Date in YYYY-MM-01 format.
#' @export
#'
#' @examples
#' patient_encounter = as.Date("2020-01-14")
#' to_month(patient_encounter)
to_month <- function(date){
  if(!inherits(date, "Date")){
    stop("Input not in date format.")
  }
  month_day = as.numeric(strftime(date, "%e"))
  diff = date - month_day + 1
  return(diff)
}
