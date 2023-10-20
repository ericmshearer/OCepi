#' Create age groups.
#'
#' Add age groups column using common age grouping presets. R Markdown documentation has list of presets.
#'
#' @param age_var Age variable in numeric format.
#' @param type Specify which preset to use. Default set to decade when not specified.
#'
#' @return Age groups as factor. Useful for maintaining proper order when plotting or sorting.
#' @export
#'
#' @examples
#'df <- data.frame(Age = floor(runif(100, min = 0, max, 99)))
#'df$agegrps <- age_groups(df$Age, type = "covid")
age_groups <- function(age_var, type = NULL){

  #presets
  types <- list(
    decade = list(c(0,9,19,29,39,49,59,69,79,Inf), c("0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80+")),
    school = list(c(0,4,11,17,64,Inf), c("0-4","5-11","12-17","18-64","65+")),
    wnv = list(c(0,17,24,34,44,54,64,Inf), c("0-17","18-24","25-34","35-44","45-54","55-64","65+")),
    covid = list(c(0,17,24,34,44,54,64,74,84,Inf), c("0-17","18-24","25-34","35-44","45-54","55-64","65-74","75-84","85+")),
    hcv = list(c(0,17,29,39,49,Inf), c("0-17","18-29","30-39","40-49","50+")),
    enteric = list(c(0,4,14,24,44,64,Inf), c("0-4","5-14","15-24","25-44","45-64","65+")),
    `flu vax` = list(c(0,18,49,64,Inf), c("0-18","19-49","50-64","65+")),
    mpox = list(c(0,15,24,34,44,54,64,Inf), c("0-15","16-24","25-34","35-44","45-54","55-64","65+"))
  )

  #error messages
  if(missing(type)){
    type = "decade"
  }

  if(!class(age_var) %in% c("numeric","integer")){
    stop("Age variable is not numeric format.")
  }

  if(!type %in% names(types)){
    stop("Age grouping not found.")
  }

  #create age groups
  choice <- types[[type]]
  x = cut(age_var, breaks = choice[[1]], labels = choice[[2]], include.lowest = TRUE)
  x = factor(x, exclude = NULL, levels = c(levels(x), NA), labels = c(levels(x), "Missing/Unknown"))
  return(x)
}
