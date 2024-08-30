#' Lollipop Plot
#'
#' Point plot with stem. Custom aesthetics via: linetype (stem), linewidth (stem), color (point), size (point).
#'
#' @param data Dataframe
#' @param mapping x and y mapping.
#' @param show.legend Boolean.
#' @param inherit.aes If TRUE combine with default mapping at the top level of the plot.
#' @param position Default set to "identity".
#' @param na.rm Boolean to remove NA values.
#' @param line.colour Hex code to override line color
#' @param ... The other arguments!
#'
#' @return Lollipop plot.
#' @export
#' @import ggplot2
#' @importFrom grid gList
#' @importFrom grid gTree
#' @importFrom ggplot2 layer
#'
#' @examples
#' df <- data.frame(locations = letters[1:5], scores = c(90,82,87,91,74))
#'
#'ggplot(data = df, aes(x = locations, y = scores, yend = 0)) +
#'  geom_lollipop(size = 10, linewidth = 2, linetype = "dashed", color = "red")
geom_lollipop <- function(data = NULL, mapping = NULL, show.legend = NA, inherit.aes = TRUE, position = "identity", line.colour = NULL, na.rm = FALSE, ...){

  layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomLollipop,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      line.colour = line.colour,
      ...
    )
  )
}

#' geom_lollipop proto
#' @rdname geom_lollipop
#' @export
GeomLollipop <- ggproto(
  "GeomLollipop",
  Geom,
  required_aes = c("x","y","yend"),
  non_missing_aes = c("shape","colour","linewidth","linetype","line.colour"),
  default_aes = aes(shape = 19, colour = "black", linewidth = 1, linetype = "solid", size = 3, fill = NA, alpha = NA, stroke = 0.5),

  draw_key = draw_key_point,

  setup_data = function(data, params, yend){
    transform(data, yend = yend)
  },

  draw_group = function(data, panel_scales, coord, size = NULL, line.colour = NULL, linewidth = NULL, linetype = NULL){
    points <- data
    points$size <- size %||% data$size
    points$colour <- data$colour
    points <- ggplot2::GeomPoint$draw_panel(points, panel_scales, coord)

    line <- data
    line$colour <- line.colour %||% data$colour
    line$linewidth <- linewidth %||% data$linewidth
    line$linetype <- linetype %||% data$linetype
    line <- ggplot2::GeomSegment$draw_panel(line, panel_scales, coord)

    grid::gTree("lollipop", children = grid::gList(line, points))
  }
)
