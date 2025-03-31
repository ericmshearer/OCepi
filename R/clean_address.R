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

  #extra
  address_var = gsub("\\bAPT\\b", "APARTMENT", address_var)
  address_var = gsub("\\bRM\\b", "ROOM", address_var)
  address_var = gsub("\\bSPC\\b", "SPACE", address_var)

  if(keep_extra){
    return(pretty_words(address_var))
  } else{
    address_var = gsub(" (APARTMENT|#|ROOM|SPACE|ROOM|UNIT)(| )\\w+", "", address_var) #remove extra info i.e. APT, Unit, etc.
    return(pretty_words(address_var))
  }
}
