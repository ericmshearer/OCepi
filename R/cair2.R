baby_name <- function(name){
  combined_pattern <- "(?i)(.*baby.*|bab(\\s)?boy|babyboy|mom|infant|bab|\\bmother\\b|\\bmomma\\b|\\bmama\\b|babygirl|girl|boy|twin|baby girl|a twin|boy a|girl a|boy b|girl b)"
  name = ifelse(grepl(combined_pattern, name, perl = TRUE), NA, name)
  return(name)
}
