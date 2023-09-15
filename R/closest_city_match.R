#' Find Closest City Match
#'
#' Find the closest matching city name by calculating string distance and selecting results when distance is below threshold. String distance calculated using Jaro-Winkler distance method, which measures edit distance or the number of operations required to transform one string to another. Function requires both stringdist package and a vector or dataframe of clean Orange County cities.
#'
#' Common city abbreviations/neighborhood names are fixed prior to string comparison i.e. Capo Beach/Capistrano Beach recoded to Dana Point.
#'
#' @param city Patient/record city variable.
#' @param possible_matches List of clean city names for matching. Can be a vector or dataframe column.
#' @param threshold Numeric value ranging 0 to 1. Default set to 0.15.
#'
#' @return Column with closest match.
#' @export
#' @importFrom stringdist stringdist
#'
#' @examples
#' library(dplyr)
#' df <- data.frame(City = c("Anahem","El Toro","Hntington Bch","Westminister"))
#'
#' df <- df %>% rowwise() %>% mutate(recoded_city = closest_city_match(City, oc_cities))
closest_city_match <- function(city, possible_matches, threshold = 0.15){

  #First pass - persons experiencing homelessness
  # if(grepl("homeless", address, ignore.case = TRUE) | grepl("homeless", city, ignore.case = TRUE)){
  #   return("Homeless")
  # }

  if(grepl("homeless", city, ignore.case = TRUE)){
    return("Homeless")
  }

  #Second pass - records with missing city or unknown filled in
  if(is.na(trimws(city)) | tolower(trimws(city)) %in% c("un","unk","unknown","na","n/a","null","not provided","none")){
    return(NA_character_)
  }

  #Third pass - convert old city names/neighborhood names/abbreviations
  if(tolower(trimws(city)) %in% c("capo beach","capistrano beach","monarch beach")){
    return("Dana Point")}

  if(tolower(trimws(city)) %in% c("gg")){
    return("Garden Grove")}

  if(tolower(trimws(city)) %in% c("hb")){
    return("Huntington Beach")}

  if(tolower(trimws(city)) %in% c("el toro","foothill ranch","foothill rnch","portola hills")){
    return("Lake Forest")}

  if(tolower(trimws(city)) %in% c("corona del mar","balboa island","corona dl mar","newport coast")){
    return("Newport Beach")}

  if(tolower(trimws(city)) %in% c("rsm","rcho sta marg","dove canyon")){
    return("Rancho Santa Margarita")}

  if(tolower(trimws(city)) %in% c("surfside")){
    return("Seal Beach")}

  if(tolower(trimws(city)) %in% c("north tustin","cowan heights")){
    return("Tustin")}

  #Final pass - find closest string match
  matches = stringdist(tolower(city), tolower(possible_matches), method = "jw")

  best = which.min(matches)

  if(min(matches) <= threshold){
    return(possible_matches[best])}
  else{
    return(NA_character_)
  }
}
