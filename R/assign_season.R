#' Assign Respiratory Season
#'
#' Calculate respiratory season based on laboratory or episode date. Respiratory season is defined as week 40 through week 39.
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

  if(!inherits(date, "Date")){
    stop("Input not in date format.")
  }

  init_week_num = OCepi::mmwr_week(OCepi::week_ending_date(date))

  adjust = ifelse(init_week_num %in% c(40:53), init_week_num - 40, 40 - init_week_num) * 7

  # init_season_start = OCepi::week_ending_date(date + adjust) - 6
  init_season_start = safe.ifelse(
    init_week_num %in% c(40:53),
    OCepi::week_ending_date(date - adjust) - 6,
    OCepi::week_ending_date(date + adjust) - 6
  )

  season_start = safe.ifelse(date < init_season_start, init_season_start - 364, init_season_start)

  season_end = season_start + 363

  year1 = as.numeric(strftime(season_start, "%Y"))
  year2 = as.numeric(strftime(season_end, "%Y"))

  return(paste(year1,substr(year2,3,4), sep = "-"))
}
