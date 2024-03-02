#' Calculate Time Between Two Dates
#'
#' Calculate the elapsed time between two dates in a specified unit of time. Order of dates within does not necessarily matter, but order will dictate sign of returned output.
#'
#' @param date2 More recent date.
#' @param date1 Older date or date further in the past.
#' @param unit Specify if returned time is in days, weeks, months, or years.
#'
#' @return Time interval in specified units.
#' @export
#'
#' @examples
#' date2 = as.POSIXlt("2023-02-08 00:10:00 PST")
#' date1 = as.POSIXlt("1986-01-08 22:00:00 PST")
#'
#' time_between(date2, date1, unit = "days")
time_between <- function(date2, date1, unit = c("days","weeks","months","years")){
  unit = match.arg(unit)
  if(!inherits(date2, c("Date","POSIXlt")) | !inherits(date1, c("Date","POSIXlt"))){
    stop("Input not in date format.")
  }
  time <- list(
    days = list(c(1)),
    weeks = list(c(7)),
    months = list(c(30.437)),
    years = list(c(365.25))
  )
  u = time[[unit]][[1]]
  age = as.numeric(difftime(date2, date1, units = "days"))/u
  out = floor(abs(age)) * sign(age)
  return(out)
}
