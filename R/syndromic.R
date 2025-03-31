#' Adjust NSSP API Date Range
#'
#' Customize date range in API URL without having to recreate within ESSENCE.
#'
#' @param url ESSENCE API URL.
#' @param start Start date for data extraction, date format.
#' @param end End date for data extraction, date format.
#'
#' @return String API URL with new date range.
#' @rdname nssp_date_range
#' @export
nssp_date_range <- function(url, start = NULL, end = NULL){
  if(missing(end)){
    end <- Sys.Date()
  }

  if(missing(start)){
    stop("Missing start date. Please provide start date.")
  }

  if(!inherits(start, "Date") | !inherits(end, "Date")){
    stop("Start/End date not in date format.")
  }

  start_new <- trimws(strftime(start, "%e%b%Y"))
  end_new <- trimws(strftime(end, "%e%b%Y"))

  start_old <- gsub(".*startDate=(.+)&medicalGroupingSystem.*", "\\1", url)
  end_old <- gsub(".*endDate=(.+)&percentParam.*", "\\1", url)

  url <- gsub(start_old, start_new, url)
  url <- gsub(end_old, end_new, url)
  return(url)
}
