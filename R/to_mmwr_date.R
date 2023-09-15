#' MMWR Date from Record Date
#'
#' Following CDC MMWR schema, calculate week number or year based on input date.
#'
#' From CDC: The first day of any MMWR week is Sunday. MMWR week numbering is sequential beginning with 1 and
#' incrementing with each week to a maximum of 52 or 53. MMWR week #1 of an MMWR year is the first week of
#' the year that has at least four days in the calendar year. For example, if January 1 occurs on a Sunday, Monday,
#' Tuesday or Wednesday, the calendar week that includes January 1 would be MMWR week #1. If January 1
#' occurs on a Thursday, Friday, or Saturday, the calendar week that includes January 1 would be the last MMWR
#' week of the previous year (#52 or #53). Because of this rule, December 29, 30, and 31 could potentially fall into
#' MMWR week #1 of the following MMWR year.
#'
#' @param x Input date i.e. episode date.
#' @param type Specify to return disease week, year, or both.
#'
#' @return MMWR date for time series aggregation.
#' @export
#'
#' @examples
#' episode_date = as.Date("2020-01-14")
#' to_mmwr_date(episode_date, type = "week")
to_mmwr_date <- function(x, type = c("week","year","both")){

  if(class(x)!= "Date"){
    stop("Invalid date type.")
  }

  if(!type %in% c("week","year","both")){
    stop("Type is unavailable. Please select week, year, or both.")
  }

  weekday = as.numeric(strftime(x, "%w")) + 1
  week_start = x - (weekday - 1)
  week_end = week_start + 6

  #for week
  start_yday = as.numeric(strftime(week_start, "%j"))
  end_yday = as.numeric(strftime(week_end, "%j"))

  #for year
  start_year = as.numeric(strftime(week_start, "%Y"))
  end_year = as.numeric(strftime(week_end, "%Y"))

  epi_week = ifelse(end_yday %in% 4:10, 1, ((start_yday + 2) %/% 7) + 1)

  epi_year = ifelse(end_yday %in% 4:10, end_year, start_year)

  if(type == "week"){return(epi_week)}
  if(type == "year"){return(epi_year)}
  if(type == "both"){return(paste(epi_year, epi_week, sep = "-"))}

}
