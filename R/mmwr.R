#' Date to MMWR Disease Week
#'
#' Following CDC MMWR schema, calculate week number based on input date.
#'
#' From CDC: The first day of any MMWR week is Sunday. MMWR week numbering is sequential beginning with 1 and
#' incrementing with each week to a maximum of 52 or 53. MMWR week #1 of an MMWR year is the first week of
#' the year that has at least four days in the calendar year. For example, if January 1 occurs on a Sunday, Monday,
#' Tuesday or Wednesday, the calendar week that includes January 1 would be MMWR week #1. If January 1
#' occurs on a Thursday, Friday, or Saturday, the calendar week that includes January 1 would be the last MMWR
#' week of the previous year (#52 or #53). Because of this rule, December 29, 30, and 31 could potentially fall into
#' MMWR week #1 of the following MMWR year.
#'
#' @param date Input date i.e. episode date, specimen collection date.
#'
#' @return Epidemiological week per MMWR schema.
#' @export
#'
#' @examples
#' episode_date = as.Date("2020-01-14")
#' mmwr_week(episode_date)
mmwr_week <- function(date){
  if(!inherits(date, "Date")){
    stop("Input not in date format.")
  }
  weekday = as.numeric(strftime(date, "%w")) + 1
  week_start = date - (weekday - 1)
  week_end = week_start + 6

  start_yday = as.numeric(strftime(week_start, "%j"))
  end_yday = as.numeric(strftime(week_end, "%j"))
  epi_week = ifelse(end_yday %in% 4:10, 1, ((start_yday + 2) %/% 7) + 1)
  return(epi_week)
}

#' Date to MMWR Year
#'
#' Following CDC MMWR schema, calculate year based on input date.
#'
#' From CDC: The first day of any MMWR week is Sunday. MMWR week numbering is sequential beginning with 1 and
#' incrementing with each week to a maximum of 52 or 53. MMWR week #1 of an MMWR year is the first week of
#' the year that has at least four days in the calendar year. For example, if January 1 occurs on a Sunday, Monday,
#' Tuesday or Wednesday, the calendar week that includes January 1 would be MMWR week #1. If January 1
#' occurs on a Thursday, Friday, or Saturday, the calendar week that includes January 1 would be the last MMWR
#' week of the previous year (#52 or #53). Because of this rule, December 29, 30, and 31 could potentially fall into
#' MMWR week #1 of the following MMWR year.
#'
#' @param date Input date i.e. episode date, specimen collection date.
#'
#' @return Epidemiological year per MMWR schema.
#' @export
#'
#' @examples
#' episode_date = as.Date("2020-01-14")
#' mmwr_year(episode_date)
mmwr_year <- function(date){
  if(!inherits(date, "Date")){
    stop("Input not in date format.")
  }
  weekday = as.numeric(strftime(date, "%w")) + 1
  week_start = date - (weekday - 1)
  week_end = week_start + 6
  end_yday = as.numeric(strftime(week_end, "%j"))
  start_year = as.numeric(strftime(week_start, "%Y"))
  end_year = as.numeric(strftime(week_end, "%Y"))
  epi_year = ifelse(end_yday %in% 4:10, end_year, start_year)
  return(epi_year)
}

#' Week Ending Date
#'
#' Calculate week ending date following CDC MMWR schema.
#'
#' @param date Input date.
#'
#' @return Output date.
#' @export
#'
#' @examples
#' episode_date = as.Date("2020-01-14")
#' week_ending_date(episode_date)
week_ending_date = function(date){
  if(!inherits(date, "Date")){
    stop("Input not in date format.")}
  week_day = as.numeric(strftime(date, "%w"))
  diff = 6 - week_day
  return(date + diff)
}

#' Calculate Total Disease Weeks for Year
#'
#' Calculate total diseases for any given MMWR year (52 or 53 weeks).
#'
#' @param year Epidemologic year.
#'
#' @return Number of MMWR Disease Weeks.
#' @export
#'
#' @examples
#' year_start(2024)
total_weeks <- function(year){
    if(!inherits(year, "numeric")){
      stop("Input not in numeric format.")}
  year_start_ordinal <- year_start(year)
  next_year_start_ordinal = year_start(year + 1)
  weeks = as.numeric((next_year_start_ordinal - year_start_ordinal) / 7)
  return(weeks)
}

#' Convert Disease Week to Week Ending Date
#'
#' When calendar date is unknown, convert disease week to week ending date.
#'
#' @param year MMWR Year.
#' @param week MMWR Week.
#'
#' @return Week ending date (Saturday).
#' @export
#'
#' @examples
#' mmwrweek_to_date(2023, 52)
mmwrweek_to_date <- function(year, week){

  if(!inherits(year, "numeric") | !inherits(week, "numeric")){
    stop("Input not in numeric format.")}

  max_weeks = max(total_weeks(year))

  janstart = year_start(year)
  week_diff = week-1

  date = janstart + week_diff*7 + 6
  date = as.Date(date)
  return(date)
}

#' Create MMWR Calendar
#'
#' Calculate calendar with disease weeks plus start and end dates.
#'
#' @param year Epidemologic year of interest.
#'
#' @return Dataframe.
#' @export
#'
#' @examples
#' mmwr_calendar(2024)
mmwr_calendar <- function(year){

  if(!inherits(year, "numeric")){
    stop("Input not in numeric format.")}

  maxweeks = total_weeks(year)

  df <- data.frame(Year = year, Week = as.numeric(1:maxweeks))
  df$End <- mmwrweek_to_date(df$Year, df$Week)
  df$Start <- df$End - 6
  df <- df[,c("Year","Week","Start","End")]
  return(df)
}
