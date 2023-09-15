#' Find Week Ending Date
#'
#' Calculate week ending date following CDC MMWR schema.
#'
#' @param x Input date.
#'
#' @return Output date.
#' @export
#'
#' @examples
#' episode_date = as.Date("2020-01-14)
#' week_ending_date(episode_date)
week_ending_date = function(x){

  if(class(x) != "Date"){
    stop("Date variable is not in date format.")
  }

  # x = as.Date(x, tryFormats = c("%m/%d/%Y","%Y-%m-%d"))
  week_day = as.numeric(strftime(x, "%w"))
  diff = 6 - week_day
  return(x + diff)
}
