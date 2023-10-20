#' Recode Race/Ethnicity in CalREDIE or CAIR2
#'
#' Simplify race/ethnicity patient data to one variable. Hierarchy defaults to Hispanic/Latinx regardless of reported race. Function can handle one (e.g. CAIR2) or two inputs (e.g. CalREDIE).
#'
#' @param ethnicity Patient ethnicity variable.
#' @param race Patient race variable.
#'
#' @return Merged race/ethnicity variable.
#' @export
#'
#' @examples
#' recode_race("Hispanic","Black or African American")
#' recode_race("Native Hawaiian or Other Pacific Islander")
recode_race <- function(ethnicity, race){

  if(missing(race)){
    ethnicity = pretty_words(trimws(ethnicity))
    combo_var = ethnicity
  } else{
    ethnicity = pretty_words(trimws(ethnicity))
    race = pretty_words(trimws(race))
    combo_var = ifelse(ethnicity %in% c("Hispanic Or Latino","Latino","Hispanic"), ethnicity, race)
  }

  oldvalues <- c("American Indian Or Alaska Native","Asian","Black Or African American","Hispanic Or Latino","Latino","Hispanic","Multiracial","Multiple Races","Native Hawaiian Or Other Pacific Islander","Other Race","Other","Unknown",NA,"White")
  newvalues <- c("AI/AN","Asian","Black/African American","Hispanic/Latinx","Hispanic/Latinx","Hispanic/Latinx","Multiple Races","Multiple Races","NHOPI","Other","Other","Unknown","Unknown","White")

  recode <- newvalues[match(combo_var, oldvalues)]

  return(recode)

}
