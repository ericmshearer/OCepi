#' Apollo Theme
#'
#' @param direction If using coord_flip, specify "horizontal". Otherwise use "vertical".
#' @param font Option to specify font, either system or Google fonts.
#' @param legend Option to display legend ("Show") or hide ("Hide").
#' @return Theme for standard ggplots.
#' @export
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 margin
#' @importFrom ggplot2 element_line
#' @importFrom grid unit

theme_apollo <- function(direction = c("vertical","horizontal"), font = NULL, legend = c("Show","Hide")) {
  orient = match.arg(direction)
  leg = match.arg(legend)

  title_color = "#231f20"
  axis_color = "#353d42"
  grid_color = "#E8EDEE"

  if(leg == "Show"){
    legend_loc = "top"
  } else {
    legend_loc = "none"
  }

  if(missing(font)){
    font = NULL
  } else {
    font = font
  }

  if(orient == "horizontal"){
    theme(

      plot.title = element_text(family = font, size = 24, hjust = 0, face = "bold", color = title_color, margin = margin(10, 0, 0, 0)),
      plot.subtitle = element_text(family = font, size = 20, hjust = 0, margin = margin(5, 0, 20, 0), color = title_color),
      plot.caption = element_text(family = font, size = 12, color = axis_color),

      legend.title = element_blank(),
      legend.text = element_text(family = font, size = 12, color = axis_color),
      legend.position = legend_loc,
      # legend.text = element_text(hjust = 0),
      legend.background = element_blank(),
      legend.key = element_blank(),

      axis.title = element_text(family = font, size = 15, color = axis_color),
      axis.text = element_text(family = font, size = 15, color = axis_color),
      axis.text.x = element_text(family = font, margin = margin(5, 0, 10, 0), color = axis_color),
      axis.text.y = element_text(family = font, margin = margin(0, 5, 0, 10), color = axis_color),
      axis.ticks = element_line(color = grid_color, linewidth = 0.1),
      axis.ticks.length.y = unit(0.15, "cm"),
      axis.ticks.length.x = unit(0, "cm"),
      axis.line = element_blank(),

      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_line(color = grid_color),
      panel.spacing.x = unit(0.85, "cm"),

      panel.background = element_blank(),

      strip.text = element_text(family = font, size = 20, hjust = 0, margin = margin(0,0,15,0), color = title_color),
      strip.background = element_rect(fill = "#FFFFFF")
    )
  } else {
    theme(

      plot.title = element_text(family = font, size = 24, hjust = 0, face = "bold", color = title_color, margin = margin(10, 0, 0, 0)),
      plot.subtitle = element_text(family = font, size = 20, hjust = 0, margin = margin(5, 0, 5, 0), color = title_color),
      plot.caption = element_text(family = font, size = 12, color = title_color),

      legend.title = element_blank(),
      legend.text = element_text(family = font, size = 12, color = axis_color),
      legend.position = legend_loc,
      # legend.text = element_text(hjust = 0),
      legend.background = element_blank(),
      legend.key = element_blank(),

      axis.title = element_text(family = font, size = 15, color = axis_color),
      axis.text = element_text(family = font, size = 15, color = axis_color),
      axis.text.x = element_text(family = font, margin = margin(5, 0, 10, 0), color = axis_color),
      axis.text.y = element_text(family = font, margin = margin(0, 0, 0, 10), color = axis_color),
      axis.ticks = element_line(color = grid_color, linewidth = 0.1),
      axis.ticks.length.x = unit(0.15, "cm"),
      axis.ticks.length.y = unit(0, "cm"),
      axis.line = element_blank(),

      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_line(color = grid_color, linewidth = 0.20),
      panel.grid.major.x = element_blank(),

      panel.background = element_blank(),
      panel.spacing.x = unit(0.85, "cm"),

      strip.text = element_text(family = font, size = 20, hjust = 0, margin = margin(0,0,15,0), color = title_color),
      strip.background = element_rect(fill = "#FFFFFF")
    )
  }
}

#' Apollo Label
#'
#' Labels to match the style in theme_apollo.
#'
#' Recommended settings:
#' bar plot hjust = -0.3
#' horizontal bar plot vjust = -0.5.
#'
#' @param direction If using coord_flip, specify "horizontal". Otherwise use "vertical".
#' @param ... Other arguments available from geom_text.
#'
#' @return Standard label for plots.
#' @importFrom ggplot2 geom_text
#' @export
#'

apollo_label <- function(direction = c("vertical","horizontal"), ...){
  orient = match.arg(direction)

  if(orient == "horizontal"){
    geom_text(size = 4.5, color = "#231f20", ...)
  } else {
    geom_text(size = 4.5, color = "#231f20", ...)
  }
}
