#' Use Team Colors in Plots
#'
#' Function to call commonly used colors for data visualizations.
#'
#' Use names(team_colors) to return all possible colors. Current options:
#' \code{green}, \code{light blue}, \code{london grey}, \code{london pink}, \code{orange}.
#'
#' @param ... Name of color(s) from team_colors.
#'
#' @return Hex codes.
#' @export
#'
#' @examples
#' cdcd_color("green")
cdcd_color <- function(...){

  team_colors <- c(
    "green" = "#5ea15d",
    "light blue" = "#6da7de",
    "london grey" = "#353d42",
    "london pink" = "#9e0059",
    "orange" = "#eb861e"
  )

  cols <- c(...)
  if(!cols %in% names(team_colors)){
    stop("Color not available.")
  }
  team_colors[cols]
}
