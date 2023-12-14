#' Retain class with ifelse inside a function
#'
#' @param cond Condition to test
#' @param yes Returned output if true
#' @param no Returned output if false
#'
#' @return Tested condition while retaining original class.
#'
#' @examples
#' test_date = as.Date("2023-01-01)
#' safe.ifelse(test_date < as.Date("2023-01-02), test_date, test_date - 5)
safe.ifelse <- function(cond, yes, no){
  class.y <- class(yes)
  X <- ifelse(cond, yes, no)
  class(X) <- class.y;
  return(X)
}

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

  init_week_num = OCepi::to_mmwr_date(OCepi::week_ending_date(date), "week")

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
