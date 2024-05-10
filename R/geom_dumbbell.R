#' Dumbbell Plot
#'
#' Line plot with two points at each end representing different values.
#'
#' @param data Dataframe.
#' @param mapping Requires following aesthetics: x = starting point, xend = ending point, y = category/factor.
#' @param show.legend Boolean.
#' @param inherit.aes If TRUE combine with default mapping at the top level of the plot.
#' @param position Default set to "identity".
#' @param na.rm Boolean to remove NA values.
#' @param colour Line color.
#' @param colour_x Color of starting point.
#' @param colour_xend Color of ending point.
#' @param size Size of points.
#' @param linewidth Line thickness.
#' @param ... Other args, man.
#'
#' @return Dumbbell plot.
#' @export
#' @import ggplot2
#' @importFrom grid gList
#' @importFrom grid gTree
#' @importFrom ggplot2 layer
#'
#' @examples
#' library(ggplot2)
#' df <- data.frame(Country = c("UK-A","US-A","UK-B","US-B"), PRE = c(0,1,2,3), POST = c(4,5,6,7))

#'ggplot(data = df, aes(x = PRE, xend = POST, y = Country)) +
#'  geom_dumbbell(colour_x = "blue", colour_xend = "red", size = 3, linewidth = 3, colour = "black") +
#'  labs(title = "Dumbbell Plot", x = "Pre/Post Scores", y = "Country")
geom_dumbbell <- function(data = NULL, mapping = NULL, show.legend = NA, inherit.aes = TRUE, position = "identity", na.rm = FALSE,
                           colour_x = NULL, colour_xend = NULL, size = NULL, linewidth = NULL, colour = NULL, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomDumbbell,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      colour_x = colour_x,
      colour_xend = colour_xend,
      size = size,
      linewidth = linewidth,
      colour = colour,
      na.rm = na.rm,
      ...
    )
  )
}

#' geom_dumbell proto
#' @rdname geom_dumbbell
#' @export
GeomDumbbell <- ggproto("GeomDumbbell", Geom,
                         required_aes = c("x","xend","y"),
                         non_missing_aes = c("size","shape","colour_x","colour_xend","linewidth"),
                         default_aes = aes(shape = 19, colour = "black", linewidth = 1, size = 3, fill = NA, alpha = NA, stroke = 0.5),

                         draw_key = draw_key_point,

                         setup_data = function(data, params){
                           transform(data, yend = y)
                         },

                         draw_group = function(data, panel_scales, coord, colour_x = NULL, colour_xend = NULL, size = NULL,
                                               linewidth = NULL, colour = NULL) {
                           points1 <- data
                           points1$xend <- NULL
                           points1$size <- size %||% data$size
                           points1$colour <- colour_x %||% data$colour
                           points1 <- ggplot2::GeomPoint$draw_panel(points1, panel_scales, coord)

                           points2 <- data
                           points2$x <- points2$xend
                           points2$size <- size %||% data$size
                           points2$colour <- colour_xend %||% data$colour
                           points2 <- ggplot2::GeomPoint$draw_panel(points2, panel_scales, coord)

                           line <- data
                           line$linewidth <- linewidth %||% data$linewidth
                           line$colour <- colour %||% data$colour
                           line <- ggplot2::GeomSegment$draw_panel(data, panel_scales, coord)

                           grid::gTree("dumbbell", children = grid::gList(line, points1, points2))
                         }
)
