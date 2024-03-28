#' Subset Data To Label Line Plot
#'
#' Subset dataframe to label last point in geom_line.
#'
#' @param df Dataframe
#' @param date_col Date column to be used in plot - can be date, year, or week.
#'
#' @return Dataframe filtered at maximum (or most recent) date including all groups at that date.
#' @export
#'
#' @examples
#' df <- data.frame(Date = seq.Date(from = as.Date("2023-01-01"), to = as.Date("2023-12-01"),
#' by = "month"), scores = sample(65:99, 12))
#' end_points(df, Date)
end_points <- function(df, date_col){
  date_col <- deparse(substitute(date_col))
  most_recent_date = max(df[[date_col]])
  out = df[df[[date_col]]==most_recent_date,]
  return(out)
}
