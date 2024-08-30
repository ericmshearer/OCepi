#' Desaturate Geom Using Expression
#'
#' Highlight a bar, point, or line plot based on an expression while desaturating all other data points.
#'
#' @param expr Expression
#' @param pal Color for highlighted data point
#' @param size Point size if using geom_point
#' @param desaturate Level of desaturation for non-highlighted data points, ranges from 0-1 with 1 equal to highest level of desaturation
#' @param linewidth Linewidth if using geom_line or geom_sf
#'
#' @return Desaturated geon
#' @export
#' @importFrom rlang enquo
#'
#' @examples
#' df <- data.frame(locations = letters[1:5], scores = c(80,84,91,89,80))
#' ggplot(data = df, aes(x = locations, y = scores)) +
#' geom_col() +
#' desaturate_geom(scores==max(scores), pal = "#d55c19", desaturate = 0.7)
desaturate_geom <- function(expr, pal, size = 3, desaturate = 0.5, linewidth = 1.5){
  structure(
    list(
      expr = rlang::enquo(expr),
      color = pal,
      size = size,
      desaturate = desaturate,
      linewidth = linewidth
    ),
    class = "desaturate"
  )
}

#' ggplot_add.desaturate
#' @rdname desaturate_geom
#' @usage NULL
#' @export
#' @import dplyr
ggplot_add.desaturate <- function(object, plot, object_name){

  hi_layers <- lapply(plot$layers, clone_layer)

  for(i in 1:length(hi_layers)){
    hi_layers[[i]]$data <- hi_layers[[i]]$data %|W|% plot$data
    hi_layers[[i]]$mapping <- hi_layers[[i]]$mapping %||% plot$mapping
  }

  attempt_filter <- sapply(hi_layers, test_run, expr = object$expr)
  position <- which(attempt_filter, arr.ind = TRUE)
  hi_layers <- hi_layers[position]

  purrr::walk(hi_layers, style_layer, expr = object$expr, color = object$color, linewidth = object$linewidth,
              size = object$size, plot = plot)

  purrr::walk(plot$layers, desaturate_layer, plot = plot, color = object$color, desaturate = object$desaturate)

  plot %+% hi_layers
}
