#' Desaturate Geom Using Expression
#'
#' Highlight a bar, point, or line plot based on an expression while desaturating all other data points.
#'
#' @param expr Expression
#' @param pal Color for highlighted data point
#' @param size Point size if using geom_point
#' @param desaturate Level of desaturation for non-highlighted data points, ranges from 0-1 with 1 equal to highest level of desaturation
#' @param linewidth Linewidth if using geom_line or geom_sf
#' @param stroke Outline linewidth when using geom_point
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
desaturate_geom <- function(expr, pal, size = 3, desaturate = 0.5, linewidth = 1.5, stroke = 1.3){
  structure(
    list(
      expr = rlang::enquo(expr),
      color = pal,
      size = size,
      desaturate = desaturate,
      linewidth = linewidth,
      stroke = stroke
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
  geom_type <- get_geom_type(plot)

  if(!inherits(plot$facet, "FacetNull")){
    facet_on <- which_facet(plot)

    new_data <- plot$data %>%
      dplyr::group_by_at(facet_on) %>%
      dplyr::filter(!!object$expr) %>%
      dplyr::ungroup()
  } else {
    new_data <- dplyr::filter(plot$data, !!object$expr)
  }

  #cloned layer
  cloned_layer <- clone_layer(plot$layers[[1]])

  cloned_layer$data <- new_data
  cloned_layer$mapping <- plot$mapping
  cloned_layer$aes_params$fill = object$color
  cloned_layer$aes_params$colour = object$color
  cloned_layer$aes_params$alpha = NULL
  cloned_layer$geom_params$na.rm = TRUE

  #original
  plot$layers[[1]]$aes_params$colour = lighten_color(object$color, amount = object$desaturate)
  plot$layers[[1]]$aes_params$fill = lighten_color(object$color, amount = object$desaturate)

  if(geom_type == "point"){
    cloned_layer$aes_params$size = object$size
    plot$layers[[1]]$aes_params$shape = 21
    plot$layers[[1]]$aes_params$colour = object$color
    plot$layers[[1]]$aes_params$stroke = object$stroke
  }

  if(geom_type %in% c("bar","col")){
    cloned_layer$geom_params$width = 0.9
  }

  if(geom_type == "line"){
    cloned_layer$aes_params$linewidth = object$linewidth
  }

  plot %+% cloned_layer
}
