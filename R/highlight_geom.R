#' Highlight Geom Using Expression
#'
#' Highlight a bar, point, or line plot based on an expression.
#'
#' @param expr Expression
#' @param pal color for highlighted geom
#' @param size Point size if using geom_point
#' @param linewidth Linewidth if using geom_line or geom_sf
#'
#' @return ggplot2 with highlighted layer
#' @export
#' @importFrom rlang enquo
#'
#' @examples
#' df <- data.frame(locations = letters[1:5], scores = c(80,84,91,89,80))
#' ggplot(data = df, aes(x = locations, y = scores)) +
#' geom_col() +
#' highlight_geom(scores==max(scores), pal = "#9E0059")
highlight_geom <- function(expr, pal, size = 5, linewidth = 1.2) {
  structure(
    list(
      expr = rlang::enquo(expr),
      color = pal,
      size = size,
      linewidth = linewidth
    ),
    class = "highlight"
  )
}

#' ggplot_add.highlight
#' @rdname highlight_geom
#' @usage NULL
#' @export
#' @import dplyr
#' @importFrom purrr walk
ggplot_add.highlight <- function(object, plot, object_name) {

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

  #original base layer
  plot$layers <- lapply(plot$layers, faded_layer, plot = plot)

  plot %+% hi_layers
}
