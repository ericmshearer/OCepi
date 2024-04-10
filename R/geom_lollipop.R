#' Lollipop Plot
#'
#' Point plot with stem.
#'
#' @param data Dataframe
#' @param mapping x and y mapping.
#' @param show.legend Boolean.
#' @param inherit.aes If TRUE combine with default mapping at the top level of the plot.
#' @param position Default set to "identity".
#' @param na.rm Boolean to remove NA values.
#' @param linewidth Change linewidth.
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
#'ggplot(data = df, aes(x = locations, y = scores)) +
#'  geom_lollipop(size = 10, linewidth = 2, color = "red")
geom_lollipop <- function(data = NULL, mapping = NULL, show.legend = NA, inherit.aes = TRUE, position = "identity", na.rm = FALSE,
                           linewidth = NULL, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomLollipop,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      linewidth = linewidth,
      na.rm = na.rm,
      ...
    )
  )
}

#' geom_lollipop proto
#' @rdname OCgeom
#' @format NULL
#' @usage NULL
#' @export
GeomLollipop <- ggproto("GeomLollipop", Geom,
                         required_aes = c("x","y"),
                         non_missing_aes = c("shape","colour","linewidth"),
                         default_aes = aes(shape = 19, colour = "black", linewidth = 1, size = 3, fill = NA, alpha = NA, stroke = 0.5),

                         draw_key = draw_key_point,

                         setup_data = function(data, params){
                           transform(data, yend = 0)
                         },

                         draw_group = function(data, panel_scales, coord, colour = NULL, size = NULL, linewidth = NULL) {
                           points <- data
                           points$size <- size %||% data$size
                           points$colour <- colour %||% data$colour
                           points <- ggplot2::GeomPoint$draw_panel(points, panel_scales, coord)

                           line <- data
                           line$linewidth <- linewidth %||% data$linewidth
                           line$colour <- "#000000"
                           line <- ggplot2::GeomSegment$draw_panel(line, panel_scales, coord)

                           grid::gTree("lollipop", children = grid::gList(points, line))
                         }
)
