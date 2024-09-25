#' Use Team Colors in Plots
#'
#' Function to call commonly used colors for data visualizations.
#'
#' @param ... Vector of color names. Run cdcd_color() to view all options.
#'
#' @return Hex codes.
#' @export
#'
#' @examples
#' cdcd_color()
#' cdcd_color("green")
cdcd_color <- function(...){
  cols <- c(...)

  if(is.null(cols)){
    return(cd_cols)
  }
  out <- unname(cd_cols[cols])
  return(out)
}

cd_cols <- c(
  "green" = "#5ea15d",
  "turquoise" = "#63c5b5",
  "light blue" = "#6da7de",
  "london pink" = "#9e0059",
  "orange" = "#F28C28",
  `title color` = "#231f20",
  `axis color` = "#353d42",
  `grid color` = "#E8EDEE",
  "plum" = "#b366a4",
  "mustard" = "#da9400",
  "dodgers"= "#005A9C"
 )
