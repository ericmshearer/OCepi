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
highlight_geom <- function(expr, pal = NULL, size = 3.14, linewidth = 1.2) {
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
ggplot_add.highlight <- function(object, plot, ...) {

  factor <- get_interval(plot$data) #for time series

  style <- list(
    color = object$color,
    linewidth = object$linewidth,
    size = object$size
  )

  group <- rlang::quo_text(plot$mapping$colour)

  if(group != "NULL"){
    plot$data$group_no = as.integer(factor(plot$data[[group]]))
    plot$layers[[1]]$mapping <- plot$mapping
    plot$layers[[1]]$mapping$group <- rlang::sym("group_no")
  }

  #clone all layers
  cloned_layers <- lapply(plot$layers, clone_layer)

  # geoms <- sapply(plot$layers, get_geom_type)
  # position <- which(geoms %in% c("text","label"), arr.ind = TRUE)
  # text_layers <- cloned_layers[position]

  #assign data and aes mapping to original and cloned layers
  cloned_layers <- lapply(cloned_layers, layer_setup, data = plot$data, mapping = plot$mapping)
  plot$layers <- lapply(plot$layers, layer_setup, data = plot$data, mapping = plot$mapping)

  #test expression on each layer
  filter_test <- sapply(cloned_layers, test_run, expr = object$expr)

  #keep only layers that passed expression test
  position <- which(filter_test, arr.ind = TRUE)
  hi_layers <- cloned_layers[position]
  hi_layers <- lapply(hi_layers, layer_setup, data = plot$data, mapping = plot$mapping)

  #assign filtered date to hi_layers
  hi_layers <- lapply(hi_layers, new_layer_data, expr = object$expr, plot = plot)
  plot$data <- hi_layers[[1]]$data

  #style hi_layers
  hi_layers <- lapply(hi_layers, style_layer, width = factor, style = style)

  #fade original layer
  plot$layers <- lapply(plot$layers, faded_layer)

  #final output
  plot + hi_layers
}
