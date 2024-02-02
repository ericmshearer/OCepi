#' Apollo Theme
#'
#' @param direction If using coord_flip, specify "horizontal". Otherwise use "vertical".
#' @return Theme for standard ggplots.
#' @export
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_rect

theme_apollo <- function(direction = c("vertical","horizontal")) {
  orient = match.arg(direction)

  text_color = "#231f20"

  if(orient == "horizontal"){
    theme(

      plot.title = element_text(size = 24, hjust = 0, face = "bold", color = text_color, margin = margin(10, 0, 0, 0)),

      plot.subtitle = element_text(size = 20, hjust = 0, margin = margin(5, 0, 5, 0), color = text_color),

      legend.title = element_blank(),
      legend.text = element_text(size = 12, color = text_color),
      legend.position = "top",
      legend.text.align = 0,
      legend.background = element_blank(),
      legend.key = element_blank(),

      axis.title = element_text(size = 15, color = text_color),
      axis.text = element_text(size = 15, color = text_color),
      axis.text.x = element_text(margin = margin(5, 0, 10, 0), color = text_color),
      axis.text.y = element_text(margin = margin(0, 0, 0, 10), color = text_color),
      axis.ticks = element_blank(),
      axis.line = element_blank(),

      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_line(color = "#E8EDEE"),

      panel.background = element_blank(),

      strip.text = element_text(size = 22, hjust = 0),
      strip.background = element_rect(fill = "white")
    )
  } else {
    theme(

      plot.title = element_text(size = 24, hjust = 0, face = "bold", color = text_color, margin = margin(10, 0, 0, 0)),

      plot.subtitle = element_text(size = 20, hjust = 0, margin = margin(5, 0, 5, 0), color = text_color),

      legend.title = element_blank(),
      legend.text = element_text(size = 12, color = text_color),
      legend.position = "top",
      legend.text.align = 0,
      legend.background = element_blank(),
      legend.key = element_blank(),

      axis.title = element_text(size = 15, color = text_color),
      axis.text = element_text(size = 15, color = text_color),
      axis.text.x = element_text(margin = margin(5, 0, 10, 0), color = text_color),
      axis.text.y = element_text(margin = margin(0, 0, 0, 10), color = text_color),
      axis.ticks = element_blank(),
      axis.line = element_blank(),

      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_line(color = "#E8EDEE"),
      panel.grid.major.x = element_blank(),

      panel.background = element_blank(),

      strip.text = element_text(size = 22, hjust = 0),
      strip.background = element_rect(fill = "white")
    )
  }
}

#' Apollo Label
#'
#' @param direction If using coord_flip, specify "horizontal". Otherwise use "vertical".
#' @param ... Other arguments available from geom_text.
#'
#' @return Standard label for plots.
#' @export
#'

apollo_label <- function(direction = c("vertical","horizontal"), ...){
  orient = match.arg(direction)

  if(orient == "horizontal"){
    geom_text(size = 4.5, hjust = -0.3, color = "#231f20", ...)
  } else {
    geom_text(size = 4.5, vjust = -0.5, color = "#231f20", ...)
  }
}
