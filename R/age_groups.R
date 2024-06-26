#' Create age groups.
#'
#' Add age groups column using common age grouping presets. R Markdown documentation has list of presets.
#'
#' @param age_var Age variable in numeric format.
#' @param type Specify which preset to use.
#'
#' @return Age groups as factor.
#' @export
#'
#' @examples
#'df <- data.frame(Age = sample(0:99, 100))
#'df$agegrps <- age_groups(df$Age, type = "covid")
#'head(df)
age_groups <- function(age_var, type = "decade"){
  types <- list(
    `cair2 peds` = list(c(0,11,15,23,24,47,72,Inf), c("<12 M","12-15 M","16-23 M","24 M","25-47 M","4-6 Years","+6 Years")),
    `census zip` = list(c(0,4,9,14,17,19,20,21,24,29,34,39,44,49,54,59,61,64,66,69,74,79,84,Inf), c("0-4","5-9","10-14","15-17","18-19","20","21","22-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-61","62-64","65-66","67-69","70-74","75-79","80-84","85+")),
    covid = list(c(0,17,24,34,44,54,64,74,84,Inf), c("0-17","18-24","25-34","35-44","45-54","55-64","65-74","75-84","85+")),
    decade = list(c(0,9,19,29,39,49,59,69,79,Inf), c("0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80+")),
    enteric = list(c(0,4,14,24,44,64,Inf), c("0-4","5-14","15-24","25-44","45-64","65+")),
    `flu vax` = list(c(0,18,49,64,Inf), c("0-18","19-49","50-64","65+")),
    hcv = list(c(0,17,39,59,Inf), c("0-17","18-39","40-59","60+")),
    infant = list(c(0,2,4,6,8,10,12), c("0-2M","3-4M","5-6M","7-8M","9-10M","11-12M")),
    mpox = list(c(0,15,24,34,44,54,64,Inf), c("0-15","16-24","25-34","35-44","45-54","55-64","65+")),
    `mmr vax` = list(c(0,4,18,Inf), c("0-4","5-18","18+")),
    pertussis = list(c(0,0.9,6,10,19,Inf), c("<1","1-6","7-10","11-19","20+")),
    `rsv vax` = list(c(0,0.9,1.9,5,12,17,59,Inf), c("<1","1","2-5","6-12","13-17","18-59","60+")),
    school = list(c(0,4,11,17,64,Inf), c("0-4","5-11","12-17","18-64","65+")),
    wnv = list(c(0,17,24,34,44,54,64,Inf), c("0-17","18-24","25-34","35-44","45-54","55-64","65+"))
  )
  if(!class(age_var) %in% c("numeric","integer")){
    stop("Age variable is not numeric format.")
  }
  if(!type %in% names(types)){
    stop("Age grouping not found.")
  }
  choice <- types[[type]]
  x = cut(age_var, breaks = choice[[1]], labels = choice[[2]], include.lowest = TRUE)
  x = factor(x, exclude = NULL, levels = c(levels(x), NA), labels = c(levels(x), "Missing/Unknown"))
  return(x)
}
