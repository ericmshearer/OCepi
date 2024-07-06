#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`
NULL

year_start <- function(year){
  greg = as.Date("0001-01-01")

  jan1 = as.Date(sprintf("%s-01-01", year))
  jan1_ordinal = as.numeric(jan1 - greg)
  jan1_weekday = as.POSIXlt(jan1)$wday - 1

  week1_start_ordinal = jan1_ordinal - jan1_weekday - 1
  week1_start_ordinal = ifelse(jan1_weekday > 2, week1_start_ordinal + 7, week1_start_ordinal)

  return(as.Date(week1_start_ordinal, origin = "0001-01-01"))
}

safe.ifelse <- function(cond, yes, no){
  class.y <- class(yes)
  X <- ifelse(cond, yes, no)
  class(X) <- class.y;
  return(X)
}

invert_map <- function(map) {
  items <- as.character(unlist(map))
  out <- unlist(Map(rep, names(map), sapply(map, length)))
  names(out) <- items
  return(out)
}

"%||%" <- function(a, b) if (!is.null(a)) a else b

"%|W|%" <- function(a, b) {
  if (!inherits(a, "waiver")) a else b
}

get_geom_type <- function(plot){
  type = tolower(gsub("Geom", "", sapply(plot$layers, function(x) class(x$geom)[1])))
  type = type[!type %in% c("text","label")]
  return(type)
  }

clone_layer <- function(layer){
  new_layer <- rlang::env_clone(layer)
  class(new_layer) <- class(layer)
  new_layer
}

which_facet <- function(plot){
  if(class(plot$facet)[1] == "FacetWrap"){
    out = unname(sapply(plot$facet$params[1]$facets, rlang::quo_text))
  } else {
    out = unname(sapply(plot$facet$params$cols, rlang::quo_text))
  }
  return(out)
}

lighten_color <- function(color = NULL, amount = 0.5) {
  if(length(color) > 7 | substr(color,1,1)!="#"){
    stop("Invalid color input. Please review hex code.")
  }
  rgb_color <- grDevices::col2rgb(color)

  new_red <- rgb_color[1] + (255 - rgb_color[1]) * amount
  new_green <- rgb_color[2] + (255 - rgb_color[2]) * amount
  new_blue <- rgb_color[3] + (255 - rgb_color[3]) * amount

  new_color <- grDevices::rgb(new_red, new_green, new_blue, maxColorValue = 255)
  return(new_color)
}

get_col <- function(df, type = NULL){
  col_info <- sapply(df, class)
  which_col <- match(type, unname(col_info))
  pull_col <- names(col_info[which_col])
  return(list(pull_col, which_col))
  }

faded_layer <- function(layer, plot){

  geom <- get_geom_type(plot)

  fade_fill = layer$aes_params$fill %||% "#cccccc"
  fade_col = layer$aes_params$colour %||% "#cccccc"
  alpha_lev = layer$aes_params$alpha %||% NULL

  layer$aes_params$fill = fade_fill
  layer$aes_params$colour = fade_col
  layer$aes_params$alpha = alpha_lev

  if("boxplot" %in% geom){
    layer$aes_params$colour = "#000000"
  }

  if("sf" %in% geom){
    layer$aes_params$fill = NULL
    layer$aes_params$colour = NULL
  }

  layer
}

test_run <- function(layer, expr){
  tryCatch({
    data <- layer$data

    new_data <- data %>%
      dplyr::filter(!!expr)

    return(TRUE)
  },
  error = function(e) {
    return(FALSE)
  })
}

style_layer <- function(layer, expr, color, linewidth, size, geom, plot){

  geom <- get_geom_type(plot)

  if(!inherits(plot$facet, "FacetNull")){
    facet_on <- which_facet(plot)

    new_data <- layer$data %>%
      dplyr::group_by_at(facet_on) %>%
      dplyr::filter(!!expr) %>%
      dplyr::ungroup()
  } else {
    new_data <- layer$data %>%
      filter(!!expr)
  }

  layer$data <- new_data
  layer$aes_params$fill = color
  layer$aes_params$colour = color
  layer$geom_params$width = 0.9

  if("point" %in% geom){
    layer$aes_params$size = size
  }

  if("boxplot" %in% geom){
    layer$aes_params$colour = "#000000"
  }

  if("sf" %in% geom){
    layer$aes_params$colour = "#000000"
    layer$aes_params$linewidth = linewidth
  }

  if("line" %in% geom){
    layer$aes_params$linewidth = linewidth
  }
  layer
}
