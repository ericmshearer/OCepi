#' Remove Empty Columns
#'
#' Ability to drop columns when either completely NA or "".
#'
#' @param df Input dataframe.
#'
#' @return Clean dataframe with removed columns.
#' @export
#'
#' @examples
#' test <- data.frame(a = c(NA,NA,NA), b = c("","",""), c = c(1,2,3))
#' remove_empty_cols(test)
remove_empty_cols <- function(df){
  df = df[!sapply(df, function(x) all(x == ""| is.na(x)))]
  return(df)
}
