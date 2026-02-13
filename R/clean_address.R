#' Clean patient/record address
#'
#' Recode common address issues such as cardinal directions and street names, and removes extra location information such as unit or apartment number.
#'
#' @param address_var Address variable.
#' @param keep_extra Defaults to TRUE. Option to keep/remove extra address components (e.g. Apartment, Unit, Space).
#'
#' @return Address as character.
#' @export
#'
#' @examples
#' x = "1234 N Main St Apt 405"
#' clean_address(x, keep_extra = TRUE)
#' clean_address(x, keep_extra = FALSE)
clean_address <- function(address_var, keep_extra = TRUE){

  address_var = toupper(address_var) #convert to upper case
  address_var = gsub("\\.", "", address_var) #remove any periods

  #cardinal directions
  address_var = gsub("\\bN\\b", "NORTH", address_var)
  address_var = gsub("\\bS\\b", "SOUTH", address_var)
  address_var = gsub("\\bE\\b", "EAST", address_var)
  address_var = gsub("\\bW\\b", "WEST", address_var)
  address_var = gsub("\\bSW\\b", "SOUTHWEST", address_var)
  address_var = gsub("\\bNW\\b", "NORTHWEST", address_var)
  address_var = gsub("\\bSE\\b", "SOUTEAST", address_var)
  address_var = gsub("\\bNE\\b", "NORTHEAST", address_var)

  #common street names
  address_var = gsub("\\bHWY\\b", "HIGHWAY", address_var)
  address_var = gsub("\\bRD\\b", "ROAD", address_var)
  address_var = gsub("\\bCIR\\b", "CIRCLE", address_var)
  address_var = gsub("\\bST\\b", "STREET", address_var)
  address_var = gsub("\\bAVE\\b", "AVENUE", address_var)
  address_var = gsub("\\bAV\\b", "AVENUE", address_var)
  address_var = gsub("\\bBLVD\\b", "BOULEVARD", address_var)
  address_var = gsub("\\bDR\\b", "DRIVE", address_var)
  address_var = gsub("\\bLN\\b", "LANE", address_var)
  address_var = gsub("\\bCT\\b", "COURT", address_var)
  address_var = gsub("\\bPL\\b", "PLACE", address_var)
  address_var = gsub("\\bPLZ\\b", "PLAZA", address_var)
  address_var = gsub("\\bHTS\\b", "HEIGHTS", address_var)
  address_var = gsub("\\bRDG\\b", "RIDGE", address_var)
  address_var = gsub("\\bCV\\b", "COVE", address_var)
  address_var = gsub("\\bTER\\b", "TERRACE", address_var)

  #extra
  address_var = gsub("\\bAPT\\b", "APARTMENT", address_var)
  address_var = gsub("\\bRM\\b", "ROOM", address_var)
  address_var = gsub("\\bSPC\\b", "SPACE", address_var)
  address_var = gsub("\\bTRLR\\b", "TRAILER", address_var)
  address_var = gsub("\\bSTE\\b", "SUITE", address_var)

  if(keep_extra){
    return(pretty_words(address_var))
  } else{
    address_var = gsub(" (APARTMENT|#|ROOM|SPACE|ROOM|UNIT|TRAILER|SUITE)(| )\\w+", "", address_var) #remove extra info i.e. APT, Unit, etc.
    return(pretty_words(address_var))
  }
}

#' Find Closest City Match
#'
#' Instead of hard coding spelling on city names, use string distance to find the closest match and recode. For OC users, a reference list of correctly spelled city names have been included, as well as hard coding of common abbreviations/nicknames. For non-OC users, you will need to provide a vector or data.frame of correctly spelled city names for string distance matching.
#'
#' @param x Character, input city data.
#' @param reference Character, provide your own vector of correctly spelled city names for reference. For OC users, leave blank to use internal vector of OC city names.
#' @param threshold Numeric, range 0 to 1. Controls sensitivity/specificity of string distance matching. Default set to 0.15.
#' @param redcap Logical, convert character to numeric mapping for REDCap bulk upload.
#' @param ooc Logical, choice to keep or recode out of county cities to NA.
#'
#' @returns Character, returned city names with closest match to reference vector.
#' @export
#' @importFrom stringdist stringdist
#'
#' @examples
#' clean_city("Anahim")
#' clean_city("Anahim", redcap = TRUE)
clean_city <- function(x, reference, threshold = 0.15, redcap = FALSE, ooc = TRUE) {
  #specific to oc
  if(missing(reference)){
    reference <- c("Aliso Viejo","Anaheim","Brea","Buena Park","Costa Mesa","Coto de Caza","Cypress","Dana Point","Fountain Valley","Fullerton",
                   "Garden Grove","Huntington Beach","Irvine","La Habra","La Palma","Ladera Ranch","Laguna Beach","Laguna Hills","Laguna Niguel",
                   "Laguna Woods","Lake Forest","Los Alamitos","Midway City","Mission Viejo","Newport Beach","Orange","Placentia","Rancho Mission Viejo",
                   "Rancho Santa Margarita","Rossmoor","San Clemente","San Juan Capistrano","Santa Ana","Seal Beach","Silverado","Stanton","Trabuco Canyon",
                   "Tustin","Villa Park","Westminster","Yorba Linda")
  }

  #specific to oc
  num_map <- list(
    `1` = c("Anaheim"),
    `2` = c("Aliso Viejo"),
    `3` = c("Brea"),
    `4` = c("Buena Park"),
    `5` = c("Costa Mesa"),
    `6` = c("Cypress"),
    `7` = c("Dana Point"),
    `8` = c("Foothill Ranch"),
    `9` = c("Fountain Valley"),
    `10` = c("Fullerton"),
    `11` = c("Garden Grove"),
    `12` = c("Huntington Beach"),
    `13` = c("Irvine"),
    `14` = c("La Habra"),
    `15` = c("La Palma"),
    `16` = c("Ladera Ranch"),
    `17` = c("Laguna Beach"),
    `18` = c("Laguna Hills"),
    `19` = c("Laguna Niguel"),
    `20` = c("Laguna Woods"),
    `21` = c("Lake Forest"),
    `22` = c("Los Alamitos"),
    `23` = c("Midway City"),
    `24` = c("Mission Viejo"),
    `25` = c("Newport Beach"),
    `26` = c("Orange"),
    `27` = c("Placentia"),
    `28` = c("Rancho Santa Margarita"),
    `29` = c("San Clemente"),
    `30` = c("San Juan Capistrano"),
    `31` = c("Santa Ana"),
    `32` = c("Seal Beach"),
    `33` = c("Silverado"),
    `34` = c("Stanton"),
    `35` = c("Trabuco Canyon"),
    `36` = c("Tustin"),
    `37` = c("Villa Park"),
    `38` = c("Westminster"),
    `39` = c("Yorba Linda")
  )

  x <- tolower(x)

  #specific to oc
  nicknames <- list(
    "anaheim" = c("anaheim hills"),
    "dana point" = c("capo beach","capistrano beach","monarch beach"),
    "garden grove" = "gg",
    "huntington beach" = c("hb","sunset beach"),
    "irvine" = c("east irvine"),
    "lake forest" = c("el toro","foothill ranch","foothill rnch","portola hills"),
    "newport beach" = c("balboa island","corona del mar","corona dl mar","newport coast"),
    "placentia" = c("atwood"),
    "rancho mission viejo" = c("rmv"),
    "rancho santa margarita" = c("rsm","rcho sta marg","dove canyon","rancho sta marg"),
    "san juan capistrano" = c("san juan capo","san juan capistr","san juan cap"),
    "seal beach" = "surfside",
    "tustin" = c("north tustin","cowan heights")
  )

  for(nick in names(nicknames)){
    x[x %in% nicknames[[nick]]] <- nick
  }

  sapply(x, function(city) {
    matches <- stringdist::stringdist(city, tolower(reference), method = "jw")

    if(all(is.na(matches))) {
      return(OCepi::pretty_words(city))
    }

    best <- which.min(matches)

    if(min(matches, na.rm = TRUE) <= threshold){
      out <- reference[best]
      if(redcap){
        cap_map <- invert_map(num_map)
        vec_pos_redcap <- match(out, names(cap_map))
        out <- unname(cap_map[vec_pos_redcap])
        out <- ifelse(is.na(out), NA, out)
      }
      return(out)
    }
    else{
      if(!ooc){
        return(NA_character_)
      } else {
        return(OCepi::pretty_words(city))
      }
    }
  }, USE.NAMES = FALSE)
}
