#' Subset Data To Label Line Plot
#'
#' Subset dataframe to label last point in geom_line. Function takes into account time series that don't end at the same time point.
#'
#' @param df Dataframe
#' @param date Date column to be used in plot - can be date, year, or week.
#' @param group_by For time series that end at different dates, specify group variable.
#'
#' @return Dataframe filtered at maximum (or most recent) date including all groups at that date.
#' @export
#'
#' @examples
#' df <- data.frame(Date = seq.Date(from = as.Date("2023-01-01"), to = as.Date("2023-12-01"),
#' by = "month"), scores = sample(65:99, 12))
#' end_points(df, Date)
end_points <- function(df, date = NULL, group_by = NULL){
  if(missing(date)){
    stop("Please enter date variable.")
  }

  date <- deparse(substitute(date))

  if(!missing(group_by)){
    group <- deparse(substitute(group_by))
    df <- df[with(df, order(df[[group]], df[[date]])), ]
    df <- df[!is.na(df[[date]]),]
    out <- df[cumsum(table(df[[group]])), ]
  } else{
    most_recent_date = max(df[[date]])
    out = df[df[[date]]==most_recent_date,]
  }
  return(out)
}
