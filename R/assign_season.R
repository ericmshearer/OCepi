#' Assign Respiratory Season
#'
#' @param date Input date.
#'
#' @return Character in format XXXX-XX.
#' @export
#'
#' @examples
#' x = as.Date("2023-10-01")
#' assign_season(x)
assign_season <- function(date){

  if(class(date)!="Date"){
    stop("Input not in date format.")
  }

  year = to_mmwr_date(date, type = "year")
  week = to_mmwr_date(date, type = "week")

  if(week %in% c(40:53)){
    season = paste(year, substr(year+1,3,4), sep = "-")
  } else {
    season = paste(year-1, substr(year,3,4), sep = "-")
  }

  return(season)
}
