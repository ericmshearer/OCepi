#' Remove Empty Columns
#'
#' Ability to drop columns when either completely NA or "".
#'
#' @param df Input dataframe.
#'
#' @return Dataframe with blank/empty columns removed. Message printed to console with total columns removed.
#' @export
#'
#' @examples
#' test <- data.frame(a = c(NA,NA,NA), b = c("","",""), c = c(1,2,3))
#' test <- remove_empty_cols(test)
#' test
remove_empty_cols <- function(df){
  og_col_total = ncol(df)

  df = df[!sapply(df, function(x) all(x == ""| is.na(x)))]

  new_col_total = ncol(df)
  col_diff = og_col_total - new_col_total
  message(sprintf("%s columns dropped.", col_diff))

  return(df)
}
