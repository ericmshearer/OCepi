#' Recode VRBIS Census Tract
#'
#' Remove state and county fips code from census tract for matching/joining.
#'
#' @param col Expects "Residence Census Tract 2010" variable from VRBIS dataset.
#'
#' @return Recoded census tract as character.
#' @export
#'
#' @examples
#' recode_ctract("06059099244")
#' recode_ctract(as.numeric("06059099244"))
recode_ctract <- function(col){
  pattern = ifelse(is.numeric(col), paste0("^[0-9][0-9][0-9][0-9]"), paste0("^[0-9][0-9][0-9][0-9][0-9]"))
  col = as.character(trimws(gsub(pattern, "", col)))
  return(col)
}

#' Recode VRBIS Manner of Death
#'
#' Convert single letter to full responses per CCDF data dictionary.
#'
#' @param col Expects "Manner of Death" column from VRBIS dataset.
#'
#' @return Recoded response as character.
#' @export
#'
#' @examples
#' vrbis_manner_death("A")
#' vrbis_manner_death(NA)
vrbis_manner_death <- function(col){
  col = trimws(toupper(col))
  oldvalues <- c("A","S","H","P","C","N",NA)
  newvalues <- c("Accident","Suicide","Homicide","Pending Investigation","Could not determine","Natural","Not specified")
  recode <- newvalues[match(col, oldvalues)]
  return(recode)
}

#' Recode VRBIS Place of Death
#'
#' Convert number to full responses per CCDF data dictionary.
#'
#' @param col Expects "Place of Death (Facility)" column from VRBIS dataset.
#'
#' @return Recoded response as character.
#' @export
#'
#' @examples
#' vrbis_place_death(6)
#' vrbis_place_death("6")
vrbis_place_death <- function(col){
  oldvalues <- c("1","2","3","4","5","6","7","9",NA)
  newvalues <- c("Inpatient","Emergency Room/Outpatient","Dead on Arrival","At Home","Hospice Facility","LTCF","Other","Unknown","Unknown")
  recode <- newvalues[match(col, oldvalues)]
  return(recode)
}

#' #' Recode VRBIS Multi-race Status
#' #'
#' #' @param col Expects "Multi-race Status" column from VRBIS dataset.
#' #'
#' #' @return Recoded response as character.
#' #' @export
#' #'
#' #' @examples
#' #' vrbis_race("3")
#' #' vrbis_race(7)
#' vrbis_race <- function(col){
#'   oldvalues <- c("1","2","3","4","5","6","7","8","9")
#'   newvalues <- c("White","Black/African American","AI/AN","Asian","NHOPI","Other","Multiple Races","Hispanic/Latinx","Unknown")
#'   recode <- newvalues[match(col, oldvalues)]
#'   return(recode)
#' }

#' Algorithm for Death Certificate Inclusion
#'
#' Standardized method to determine if death belongs to local health jurisdiction.
#'
#' @param death_location Expects "Place of Death (Facility)" column from VRBIS dataset.
#' @param county_of_death Expects "County of Death (Code)" column.
#' @param county_fips Expects "Decedents County of Residence (NCHS Code)" column.
#' @param fips County fips code of local health jurisdiction.
#' @param county_code State county code per Appendix G of CCDF data dictionary.
#'
#' @return 0/1, with 1 indicating death belongs to local health jurisdiction.
#' @export
#'
vrbis_resident <- function(death_location, county_of_death, county_fips, fips = "059", county_code = "30"){
  death_location = toupper(death_location)
  cond1 = (death_location %in% c("6","LTCF")) * (county_of_death == county_code) #LTCF residents in OC
  cond2 = (death_location %in% c("6","LTCF")) * (county_of_death != county_code) #LTCF residents in another county
  cond3 = (county_fips %in% fips) #general pop/non LTCF
  count = ifelse(cond1 == 1 | cond3 == 1 & cond2 == 0, 1, 0)
  return(count)
}
