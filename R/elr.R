pos_res <- c("POSITIVE","REACTIVE","DETECTED","10828004","260373001","840533007","PCRP11","PDETD",
             "COVPRE","11214006","Positive for IgG","POS","DECTECTED","REA","PPOSI","REAC")

#' ELR Terms
#'
#' A vector of SNOMED codes and keywords to be used with ELR recoding.
#'
#' @param collapse Boolean to collapse string separated by "|".
#' @param add_in Vector of additional lab results.
#'
#' @return Vector of characters.
#' @export
#'
#' @rdname elr
#' @examples
#' pos(collapse = TRUE)
#' pos()
pos <- function(collapse = FALSE, add_in = NULL){
  if(collapse){
    out <- paste0(c(pos_res, add_in), collapse = "|")
  } else {
    out <- c(pos_res, add_in)
  }
  return(out)
}

neg_res <- c("NEGATIVE","NON REACTIVE","NON-REACTIVE","NOT REACTIVE","NOT DETECTED","NEG","NDET",
             "NOT DETECT","260385009","26041500","NOTDETECTED","131194007","895231008","NONE DETECTED",
             "NO DETECTED","NOT DETECTABLE","NOT DETECTE","NOT DETECTIVE","NOTDETECT","NOTDETECTED",
             "NR","NONREACTIVE","NOTREACTIVE")

#' @export
#'
#' @rdname elr
#' @examples
#' neg(collapse = TRUE)
#' neg()
neg <- function(collapse = FALSE, add_in = NULL){
  if(collapse){
    out <- paste0(c(neg_res, add_in), collapse = "|")
  } else {
    out <- c(neg_res, add_in)
  }
  return(out)
}
