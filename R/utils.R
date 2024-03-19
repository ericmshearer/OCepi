#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`
NULL

#' MMWR Year Start
#'
#' @param year Year
#' @keywords internal
#' @export
#'
#' @return Day one of week one following MMWR schema
year_start <- function(year){
  greg = as.Date("0001-01-01")

  jan1 = as.Date(sprintf("%s-01-01", year))
  jan1_ordinal = as.numeric(jan1 - greg)
  jan1_weekday = as.POSIXlt(jan1)$wday - 1

  week1_start_ordinal = jan1_ordinal - jan1_weekday - 1
  week1_start_ordinal = ifelse(jan1_weekday > 2, week1_start_ordinal + 7, week1_start_ordinal)

  return(as.Date(week1_start_ordinal, origin = "0001-01-01"))
}

#' Retain class with ifelse inside a function
#'
#' @param cond Condition to test
#' @param yes Returned output if true
#' @param no Returned output if false
#'
#' @keywords internal
#' @export
#'
#' @return Tested condition while retaining original class.
safe.ifelse <- function(cond, yes, no){
  class.y <- class(yes)
  X <- ifelse(cond, yes, no)
  class(X) <- class.y;
  return(X)
}

#' Invert Mapping
#'
#' @param map List.
#' @keywords internal
#' @export
#'
#' @return Inverted list/mapping.
invert_map <- function(map) {
  items <- as.character(unlist(map))
  out <- unlist(Map(rep, names(map), sapply(map, length)))
  names(out) <- items
  return(out)
}

#' Simulated outbreak data
#'
#' @name linelist
#' @docType data
#' @keywords data
NULL

"%||%" <- function(a, b) if (!is.null(a)) a else b
