#' Remove Baby-variant name from CAIR2
#'
#' @param name First name field from CAIR2.
#'
#' @return Clean first name with baby and variants removed.
#' @export
#'
#' @examples
#' baby_name("BABYBOY")
#'
#' baby_name("Twin Girl")
baby_name <- function(name){
  combined_pattern <- "(?i)(.*baby.*|bab(\\s)?boy|babyboy|mom|infant|bab|\\bmother\\b|\\bmomma\\b|\\bmama\\b|babygirl|girl|boy|twin|baby girl|a twin|boy a|girl a|boy b|girl b)"
  name = ifelse(grepl(combined_pattern, name, perl = TRUE), NA, name)
  return(name)
}
