#' Recode Sex Column in CalREDIE
#'
#' Made specifically for CaLREDIE UDF data export. Recode abbreviations to full names. Future iterations may be applicable to non-CalREDIE datasets.
#'
#' @param gender_var "Sex" column in CalREDIE.
#' @param ordered Return output as factor. Default set to TRUE.
#'
#' @return Recoded input column.
#' @export
#'
#' @examples
#' example = c("F","F","TF",NA)
#' recode_gender(example, ordered = FALSE)
recode_gender <- function(gender_var, ordered = NULL){

  if(missing(gender_var)){
    stop("Gender variable not specified.")
  }

  if(missing(ordered)){
    ordered = TRUE
  }

  oldvalues <- c("F","M","TF","TM","U","D","I","G",NA) #current options in CalREDIE

  if(ordered == TRUE){
    newvalues <- factor(c("Female","Male","Transgender woman","Transgender man","Missing/Unknown","Missing/Unknown","Identity Not Listed","Genderqueer/Non-binary","Missing/Unknown"))
  } else{
    newvalues <- c("Female","Male","Transgender woman","Transgender man","Missing/Unknown","Missing/Unknown","Identity Not Listed","Genderqueer/Non-binary","Missing/Unknown")
  }

  recode <- newvalues[match(gender_var, oldvalues)]
  return(recode)

}
