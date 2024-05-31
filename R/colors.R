#' Use Team Colors in Plots
#'
#' Function to call commonly used colors for data visualizations.
#'
#' Use names(cd_cols) to return all possible colors.
#'
#' @param ... Name of color(s) from cd_cols.
#'
#' @return Hex codes.
#' @export
#'
#' @examples
#' cdcd_color("green")
cdcd_color <- function(...){
  cols <- c(...)

  if(is.null(cols)){
    return(cd_cols)
  }
  out <- unname(cd_cols[cols])
  return(out)
}

# List of colors and the order in which they are printed.
#' Complete list of colors.
#' @export
cd_cols <- c(
  "green" = "#5ea15d",
  "turquoise" = "#63c5b5",
  "light blue" = "#6da7de",
  "london pink" = "#9e0059",
  "orange" = "#F28C28",
  `title color` = "#231f20",
  `axis color` = "#353d42",
  `grid color` = "#E8EDEE"
)
