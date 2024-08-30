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

year_start <- function(year){
  greg = as.Date("0001-01-01")

  jan1 = as.Date(sprintf("%s-01-01", year))
  jan1_ordinal = as.numeric(jan1 - greg)
  jan1_weekday = as.POSIXlt(jan1)$wday - 1

  week1_start_ordinal = jan1_ordinal - jan1_weekday - 1
  week1_start_ordinal = ifelse(jan1_weekday > 2, week1_start_ordinal + 7, week1_start_ordinal)

  return(as.Date(week1_start_ordinal, origin = "0001-01-01"))
}

safe.ifelse <- function(cond, yes, no){
  class.y <- class(yes)
  X <- ifelse(cond, yes, no)
  class(X) <- class.y;
  return(X)
}

invert_map <- function(map) {
  items <- as.character(unlist(map))
  out <- unlist(Map(rep, names(map), sapply(map, length)))
  names(out) <- items
  return(out)
}

partial <- function(var, n_char = 4, upper_case = TRUE){
  if(upper_case){
    out <- trimws(substr(var, 1, n_char))
    out <- toupper(out)
  } else{
    out <- trimws(substr(var, 1, n_char))
  }
  return(out)
}

"%||%" <- function(a, b) if (!is.null(a)) a else b

"%|W|%" <- function(a, b) {
  if (!inherits(a, "waiver")) a else b
}
