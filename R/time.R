#' Date to Month Date
#'
#' Recode date to standard month date for dashboards or ggplots2.
#'
#' @param date Input date.
#'
#' @return Date in YYYY-MM-01 format.
#' @export
#'
#' @rdname to_month
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

#' Date to Quarter
#'
#' Recode date to calendar or fiscal quarter.
#'
#' @param x Input date.
#' @param fiscal Boolean, TRUE returns fiscal quarter.
#'
#' @return Character in format YYYY-Q0#.
#' @export
#'
#' @rdname to_quarter
#' @examples
#' to_quarter(Sys.Date())
#' to_quarter(Sys.Date(), fiscal = TRUE)
to_quarter <- function(x, fiscal = FALSE){
  if(!inherits(x, "Date")){
    stop("Input not in date format.")
  }

  quart = as.POSIXlt(x)$mon %/% 3L + 1L
  year = as.numeric(strftime(x, "%Y"))
  if(fiscal){
    quart = ifelse(quart %in% c(1,2), quart + 2, quart - 2)
  }
  out = sprintf("%s-Q0%s", year, quart)
  return(out)
}
