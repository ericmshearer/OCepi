#' Redact HIV/AIDS from Dataframe
#'
#' Convert manual process of redacting sensitive health information. Works exclusively on dataframes.
#'
#' @param df Dataframe with HIV/AIDS removed.
#'
#' @return Dataframe. Warning message printed to console if HIV/AIDS data detected.
#' @export
#'
#' @examples
#' df <- data.frame(cause = c("cancer","hepatitis","COVID-19","HIV"))
#' hiv_redact(df)
hiv_redact <- function(df){

  terms = c("\\bHIV\\b","\\bAIDS\\b","HUMAN IMMUNODEFICIENCY VIRUS","Human Immunodeficiency Virus",
            "Human immunodeficiency virus","human immunodeficiency virus","ACQUIRED IMMUNODEFICIENCY SYNDROME",
            "Acquired Immunodeficiency Syndrome","acquired immunodeficiency syndrome","HUMAN IMMUNEDEFICENCY VIRUS",
            "HUMAN IMMUNODEFICIENCY VIRAL","ACQUIRED IMMUNE DEFICIENCY SYNDROME","ACQUIRED IMMUNEDEFICIENCY SYNDROME",
            "HUMAN IMMUNO DEFICIENCY VIRUS")

  x = sapply(colnames(df), function(x) grepl(paste0(terms, collapse = "|"), df[,x]))

  if(TRUE %in% x){
    warning("HIV/AIDS data detected.")
    df <- as.data.frame(lapply(df, function(x){x <- gsub(paste0(terms, collapse = "|"), "", x)}))
    df <- as.data.frame(lapply(df, function(x){x <- gsub("^, ", "", x)}))
    return(df)
  } else{
    print("No HIV/AIDS data found.")
    return(df)
  }
}
