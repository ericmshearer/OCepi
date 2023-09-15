#' Add Proportion Column
#'
#' Add proportion column quickly to frequency table. Plays nice with pipe operator following count function.
#'
#' @param df Dataframe to add proportion column.
#' @param digits Number of digits to round proportion. Default set to 1.
#' @param multiply Option to multiply proportion by 100. Default set to TRUE.
#'
#' @return Proportion. Use multiply argument to specify if output should be multiplied by 100.
#' @export
#'
#' @examples
#' library(dplyr)
#' df <- data.frame(location = c("a","b","c","d","e"), patients = c(10, 12, 6, 20, 2))
#' df %>% add_percent(digits = 1, multiply = TRUE)
add_percent <- function(df, digits = NULL, multiply = NULL){

  #defaults
  if(missing(digits)){
    digits = 1
  }

  if(missing(multiply)){
    multiply = TRUE
  }

  #calculate proportion and add to dataframe
  temp_data <- as.data.frame(df) #convert from tibble to dataframe

  count_col = which(vapply(temp_data, is.numeric, logical(1))) #find position of numeric column

  proportion = temp_data[,count_col]/sum(temp_data[,count_col])

  if(multiply == TRUE){
    proportion = round(proportion * 100, digits = digits)
  }

  if(multiply == FALSE){
    proportion = round(proportion, digits = digits)
  }

  return(cbind(df, proportion))
}
