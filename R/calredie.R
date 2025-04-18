#' Recode Gender/Sex in CalREDIE
#'
#' Made specifically for CaLREDIE UDF data export. Recode abbreviations to full names.
#'
#' @param col Input column from CalREDIE.
#'
#' @return Recoded input column as character.
#' @export
#'
#' @examples
#' example = c("F","F","TF",NA)
#' recode_gender(example)
recode_gender <- function(col){
  oldvalues <- c("F","M","TF","TM","U","D","I","G",NA)
  newvalues <- c("Female","Male","Transgender woman","Transgender man","Missing/Unknown","Missing/Unknown","Identity Not Listed","Genderqueer/Non-binary","Missing/Unknown")
  recode <- newvalues[match(col, oldvalues)]
  return(recode)
}

#' Recode Sexual Orientation in CalREDIE
#'
#' Made specifically for CaLREDIE UDF data export. Recode abbreviations to full names.
#'
#' @param col CTCIAdtlDemOrient column from CalREDIE.
#'
#' @return Recoded column as character.
#' @export
#'
#' @examples
#' recode_orientation("BIS")
#' recode_orientation(NA)
recode_orientation <- function(col){
  oldvalues <- c("BIS","HET","HOM","DNK","UNK","NOT","DEC",NA) #current options in CalREDIE
  newvalues <- c("Bisexual","Heterosexual or straight","Gay, lesbian, or same gender-loving",
                 "Missing/Unknown","Missing/Unknown","Missing/Unknown","Missing/Unknown","Missing/Unknown")
  recode <- newvalues[match(col, oldvalues)]
  return(recode)
}

#' Recode Race/Ethnicity
#'
#' Simplify race/ethnicity patient data to one variable using data from CalREDIE, CAIR2, VRBIS, or LOINC codes. Hierarchy defaults to Hispanic/Latinx regardless of reported race. Function can handle one (e.g. CAIR2) or two inputs (e.g. CalREDIE). If using with VRBIS dataset, expected input is "Multi-status Race" column.
#'
#' @param ethnicity Patient ethnicity variable.
#' @param race Patient race variable.
#' @param abbr_names TRUE/FALSE, option to abbreviate long category names.
#'
#' @return Merged race/ethnicity variable.
#' @export
#'
#' @examples
#' recode_race("Hispanic","Black or African American")
#' recode_race("Native Hawaiian or Other Pacific Islander", abbr_names = FALSE)
#' recode_race("1")
recode_race <- function(ethnicity, race, abbr_names = FALSE){

  race_list = list(
    Full = list(
      `American Indian/Alaska Native` = c("American Indian or Alaska Native","1002-5","3"),
      Asian = c("Asian","2028-5","2028-9","2034-7","2036-2","2039-6","2040-4","2047-9","4"),
      `Black/African American` = c("Black or African American","Black","2054-5","2"),
      `Not Hispanic or Latino` = c("Not Hispanic or Latino","2186-5"),
      `Hispanic/Latinx` = c("Hispanic or Latino","Hispanic/Latinx","Latino","Hispanic","2135-2","8"),
      `Multiple Races` = c("Multiracial","Multiple Races","7"),
      `Native Hawaiian/Other Pacific Islander` = c("Native Hawaiian or Other Pacific Islander","Native Hawaiian","Other Pacific Islander","2076-8","2079-2","2087-5","2088-3","2080-0","2500-7","5"),
      White = c("White","2106-3","1"),
      Other = c("Other","Other race","6","2131-1"),
      `Missing/Unknown` = c(NA_character_,"Unknown","Unknown race","9","NR","PHC1175","POL","UNK")
    ),
    Abbr = list(
      `AI/AN` = c("American Indian or Alaska Native","1002-5","3"),
      Asian = c("Asian","2028-5","2028-9","2034-7","2036-2","2039-6","2040-4","2047-9","4"),
      `Black/African American` = c("Black or African American","Black","2054-5","2"),
      `Not Hispanic or Latino` = c("Not Hispanic or Latino","2186-5"),
      `Hispanic/Latinx` = c("Hispanic or Latino","Hispanic/Latinx","Latino","Hispanic","2135-2","8"),
      `Multiple Races` = c("Multiracial","Multiple Races","7"),
      NHOPI = c("Native Hawaiian or Other Pacific Islander","Native Hawaiian","Other Pacific Islander","2076-8","2079-2","2087-5","2088-3","2080-0","2500-7","5"),
      White = c("White","2106-3","1"),
      Other = c("Other","Other race","6","2131-1"),
      `Missing/Unknown` = c(NA_character_,"Unknown","Unknown race","9","NR","PHC1175","POL","UNK")
    )
  )
  if(abbr_names){
    names = "Abbr"
  }else {
    names = "Full"
  }
  if(missing(race)){
    ethnicity = trimws(ethnicity)
    combo_var = ethnicity
    race_list <- race_list[names][[1]]
    mapping <- invert_map(race_list)
    vec_pos <- match(combo_var, names(mapping))
    out <- mapping[vec_pos]
    out <- unname(out)
    out <- ifelse(is.na(out), "Unknown", out)
  } else{
    ethnicity = trimws(ethnicity)
    race = trimws(race)
    combo_var = ifelse(ethnicity %in% c("Hispanic or Latino","Hispanic/Latinx","Latino","Hispanic","2135-2"), ethnicity, race)
    race_list <- race_list[names][[1]]
    mapping <- invert_map(race_list)
    vec_pos <- match(combo_var, names(mapping))
    out <- mapping[vec_pos]
    out <- unname(out)
    out <- ifelse(is.na(out), "Unknown", out)
  }
  return(out)
}

#' Clean Phone Number
#'
#' Reformat phone number column to 10 digit U.S. format. If international or invalid phone number (e.g. not 10 digits), returns NA.
#'
#' @param phone_var Phone number variable.
#'
#' @return Reformatted phone number.
#' @export
#'
#' @examples
#' clean_phone("1-714-834-8180")
clean_phone <- function(phone_var){
  phone_var = gsub("\\-|\\+|\\(|\\)|\\s+", "", phone_var)
  phone_var = ifelse(startsWith(phone_var, "1"), substr(phone_var, 2, nchar(phone_var)), phone_var)
  out = ifelse(nchar(phone_var) == 10, phone_var, NA)
  return(out)
}
