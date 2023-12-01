#' Complete Time Series
#'
#' Complete time series data at the day, week, or month level starting at a specified date. Useful for filling in missing dates when preparing for plotting or export to Tableau.
#'
#' @param df Dataframe of initial time series data.
#' @param start_date Specify date to start time series. Last date in series is oldest/most recent date.
#' @param level Options to complete time series at the day, week, or month level. When using week, be mindful you are completing sequence using MMWR week ending date. For month, works best when date is M/1/YYYY.
#'
#' @return Dataframe of complete time series starting at specified start date.
#' @export
#'
#' @examples
#' df <- complete_dates(df, start_date = min(df$Dates), level = "month")
complete_dates <- function(df, start_date = NULL, level = c("day","week","month")){

  if(missing(level)){
    stop("Level not specified, please choose: day, week, month.")
  }

  if(missing(start_date)){
    stop("Start date not specified.")
  }

  df <- data.frame(df)
  namez <- colnames(df)
  start_date <- as.Date(start_date, tryFormats = c("%Y-%m-%d","%m/%d/%Y"))

  possible_dates <- seq.Date(min(start_date), max(df[,1]), by = level)
  add_dates <- data.frame(date = possible_dates[!possible_dates %in% df[,1]], n = NA)
  colnames(add_dates) <- namez

  df <- rbind(df, add_dates)

  colnames(df) <- c("date","n")
  df <- df[order(df$date),]

  colnames(df) <- namez
  rownames(df) <- NULL

  return (df)
}
