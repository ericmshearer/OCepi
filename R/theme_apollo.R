#' Apollo Theme
#'
#' @param direction If using coord_flip, specify horizontal. Otherwise use vertical.
#' @param font Option to specify font otherwise set to default.
#' @param legend Set legend position to top, right, bottom, or left. To hide, use none.
#' @return Theme for standard ggplots.
#' @export
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 margin
#' @importFrom ggplot2 element_line
#' @importFrom grid unit

theme_apollo <- function(direction = c("vertical","horizontal","map"), font = NULL, legend = "top") {

  if(missing(direction)) {
    direction <- "vertical"
  }

  orient = match.arg(direction)
  legend_loc = legend

  title_color = cdcd_color("title color")
  axis_color = cdcd_color("axis color")
  grid_color = cdcd_color("grid color")

  if(missing(font)){
    font = NULL
  } else {
    font = font
  }

  switch(direction,
         vertical = {
           ticks_x = unit(0.15, "cm")
           ticks_y = unit(0, "cm")
           panel_y = element_line(color = grid_color, linewidth = 0.20)
           panel_x = element_blank()
           title_loc = 0
           axis_title = element_text(family = font, size = 15, color = axis_color)
           axis_text = element_text(family = font, size = 15, color = axis_color)
           axis_text_x = element_text(family = font, margin = margin(t = 5, r = 0, b = 10, l = 0), color = axis_color)
           axis_text_y = element_text(family = font, margin = margin(t = 0, r = 0, b = 0, l = 10), color = axis_color)
         },
         horizontal = {
           ticks_x = unit(0, "cm")
           ticks_y = unit(0.15, "cm")
           panel_y = element_blank()
           panel_x = element_line(color = grid_color, linewidth = 0.20)
           title_loc = 0
           axis_title = element_text(family = font, size = 15, color = axis_color)
           axis_text = element_text(family = font, size = 15, color = axis_color)
           axis_text_x = element_text(family = font, margin = margin(t = 5, r = 0, b = 10, l = 0), color = axis_color)
           axis_text_y = element_text(family = font, margin = margin(t = 0, r = 5, b = 0, l = 10), color = axis_color)
         },
         map = {
           ticks_x = NULL
           ticks_y = NULL
           panel_y = NULL
           panel_x = NULL
           axis_title = element_blank()
           axis_text = element_blank()
           axis_text_x = element_blank()
           axis_text_y = element_blank()
           title_loc = 0.5
           # axis_title = element_text(family = NULL, size = 15, color = "#FFFFFF")
           # axis_text = element_text(family = NULL, size = 15, color = "#FFFFFF")
           # axis_text_x = element_text(family = NULL, margin = margin(t = 1, r = 1, b = 1, l = 1), color = "#FFFFFF")
           # axis_text_y = element_text(family = NULL, margin = margin(t = 1, r = 1, b = 1, l = 1), color = "#FFFFFF")
         }
  )

  theme(

    plot.title = element_text(family = font, size = 24, hjust = title_loc, face = "bold", color = title_color, margin = margin(t = 10, r = 0, b = 0, l = 0)),
    plot.subtitle = element_text(family = font, size = 20, hjust = title_loc, margin = margin(t = 5, r = 0, b = 27, l = 0), color = title_color),
    plot.caption = element_text(family = font, size = 12, color = title_color),

    legend.title = element_text(family = font, size = 12, color = axis_color),
    legend.text = element_text(family = font, size = 12, color = axis_color),
    legend.position = legend_loc,
    legend.background = element_blank(),
    legend.key = element_blank(),

    axis.title = axis_title,
    axis.text = axis_text,
    axis.text.x = axis_text_x,
    axis.text.y = axis_text_y,
    axis.ticks = element_line(color = grid_color, linewidth = 0.1),
    axis.ticks.length.x = ticks_x,
    axis.ticks.length.y = ticks_y,
    axis.line = element_blank(),

    panel.grid.minor = element_blank(),
    panel.grid.major.y = panel_y,
    panel.grid.major.x = panel_x,

    panel.background = element_blank(),
    panel.spacing.x = unit(0.85, "cm"),
    panel.spacing.y = unit(1, "cm"),

    strip.text = element_text(family = font, size = 20, vjust = 0.5, hjust = 0.5, margin = margin(t = 0, r = 0, b = 15, l = 0), color = title_color),
    strip.background = element_rect(fill = "#FFFFFF")
  )
}

#' Apollo Label
#'
#' Labels to match the style in theme_apollo.
#'
#' Recommended settings:
#' bar plot vjust = -0.3
#' horizontal bar plot hjust = -0.5.
#'
#' @param size Font size, preset to 4.5
#' @param color Font color, preset to #231f20
#' @param ... Other arguments available from geom_text.
#'
#' @return Standard label for plots.
#' @importFrom ggplot2 geom_text
#' @export
#'

apollo_label <- function(..., size = 4.5, color = "#231f20"){
  geom_text(size = size, color = color, ...)
  }
