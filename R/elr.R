pos_res <- c("POSITIVE","REACTIVE","DETECTED","10828004","260373001","840533007","PCRP11","PDETD",
             "COVPRE","11214006","Positive for IgG","POS","DECTECTED")

#' @export
pos <- function(collapse = FALSE){
  if(collapse){
    out <- paste0(pos_res, collapse = "|")
  } else {
    out <- pos_res
  }
  return(out)
}

neg_res <- c("NEGATIVE","NON REACTIVE","NON-REACTIVE","NOT REACTIVE","NOT DETECTED","NEG","NDET",
             "NOT DETECT","260385009","26041500","NOTDETECTED","131194007","895231008","NONE DETECTED",
             "NO DETECTED","NOT DETECTABLE","NOT DETECTE","NOT DETECTIVE","NOTDETECT","NOTDETECTED")

#' @export
neg <- function(collapse = FALSE){
  if(collapse){
    out <- paste0(neg_res, collapse = "|")
  } else {
    out <- neg_res
  }
  return(out)
}
