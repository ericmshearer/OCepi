#' Cleveland Dot Plot
#'
#' Cleveland dot plot (or dumbbell plot) using ggplot2. Arose out of need to create timelines. Work in progress.
#'
#' @param data Dataframe.
#' @param mapping Requires following aesthetics: x = starting point, xend = ending point, y = category/factor.
#' @param show.legend Boolean.
#' @param inherit.aes If TRUE combine with default mapping at the top level of the plot.
#' @param position Default set to "identity".
#' @param na.rm Boolean to remove NA values.
#' @param colour_x Color of starting point.
#' @param colour_xend Color of ending point.
#' @param size_x Size of points.
#' @param linewidth Line thickness.
#' @param ... Other args, man.
#'
#' @return Cleveland dot plot.
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
#'  geom_cleveland(colour_x = "blue", colour_xend = "red") +
#'  labs(title = "Cleveland Dot Plot", x = "Pre/Post Scores", y = "Country")
geom_cleveland <- function(data = NULL, mapping = NULL, show.legend = NA, inherit.aes = TRUE, position = "identity", na.rm = FALSE,
                          colour_x = NULL, colour_xend = NULL, size_x = NULL, linewidth = NULL, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = "identity",
    geom = GeomCleveland,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      colour_x = colour_x,
      colour_xend = colour_xend,
      size_x = size_x,
      na.rm = na.rm,
      ...
    )
  )
}

#' geom_cleveland proto
#' @rdname OCgeom
#' @format NULL
#' @usage NULL
#' @export
GeomCleveland <- ggproto("GeomCleveland", Geom,
                         required_aes = c("x","xend","y"),
                         non_missing_aes = c("size","shape","size","colour_x","colour_xend","size_x","linewidth"),
                         default_aes = aes(shape = 19, colour = "black", linewidth = 1, size = 3, fill = NA, alpha = NA, stroke = 0.5),

                         draw_key = draw_key_point,

                         setup_data = function(data, params){
                           transform(data, yend = y)
                         },

                         draw_group = function(data, panel_scales, coord, colour_x = NULL, colour_xend = NULL, size_x = NULL,
                                                linewidth = NULL) {
                          points1 <- data
                            points1$xend <- NULL
                            points1$size <- size_x %||% data$size
                            points1$colour <- colour_x %||% data$colour
                            points1 <- ggplot2::GeomPoint$draw_panel(points1, panel_scales, coord)

                            points2 <- data
                            points2$x <- points2$xend
                            points2$size <- size_x %||% data$size
                            points2$colour <- colour_xend %||% data$colour
                            points2 <- ggplot2::GeomPoint$draw_panel(points2, panel_scales, coord)

                            line <- data
                            line$linewidth <- linewidth %||% data$linewidth
                            line <- ggplot2::GeomSegment$draw_panel(data, panel_scales, coord)

                            grid::gTree("dumbbell", children = grid::gList(points1, points2, line))
                          }
                        )
