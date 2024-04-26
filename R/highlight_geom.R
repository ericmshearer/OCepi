#' Highlight Geom Using Expression
#'
#' Highlight a bar, point, or line plot based on an expression.
#'
#' @param expr Expression
#' @param pal color for highlighted geom
#' @param size Point size if using geom_point
#' @param alpha Alpha for transparency
#' @param linewidth Linewidth if using geom_line
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
highlight_geom <- function(expr, pal, size = 3, alpha = 1, linewidth = 1.5) {
  structure(
    list(
      expr = rlang::enquo(expr),
      color = pal,
      size = size,
      alpha = alpha,
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
ggplot_add.highlight <- function(object, plot, object_name) {
  geom_type <- get_geom_type(plot)

  if(!inherits(plot$facet, "FacetNull")){

    if(class(plot$facet)[1] == "FacetWrap"){
      facet_on = unname(sapply(plot$facet$params[1]$facets, rlang::quo_text))
    } else {
      facet_on = unname(sapply(plot$facet$params$cols, rlang::quo_text))
    }

    new_data <- plot$data %>%
      dplyr::group_by_at(facet_on) %>%
      dplyr::filter(!!object$expr) %>%
      dplyr::ungroup()
  } else {
    new_data <- dplyr::filter(plot$data, !!object$expr)
  }

  cloned_layer <- layer(
    data = new_data,
    geom = geom_type,
    stat = "identity",
    position = "identity",
    inherit.aes = TRUE
  )

  cloned_layer$aes_params$fill = object$color
  cloned_layer$aes_params$colour = object$color

  #original
  plot$layers[[1]]$aes_params$colour = "#cccccc"
  plot$layers[[1]]$aes_params$fill = "#cccccc"
  plot$layers[[1]]$aes_params$alpha = object$alpha

  if(geom_type == "point"){
    cloned_layer$aes_params$size = object$size
  }

  if(geom_type == "line"){
    cloned_layer$aes_params$linewidth = object$linewidth
  }

  plot %+% cloned_layer
}
