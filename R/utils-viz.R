"%||%" <- function(a, b) if (!is.null(a)) a else b

"%|W|%" <- function(a, b) {
  if (!inherits(a, "waiver")) a else b
}

get_geom_type <- function(layer){
  type = tolower(gsub("Geom", "", class(layer$geom)[1]))
  return(type)
}

clone_layer <- function(layer){
  new_layer <- rlang::env_clone(layer)
  class(new_layer) <- class(layer)
  new_layer
}

layer_setup <- function(layer, data, mapping, plot){
  layer$data <- layer$data %|W|% plot$data
  layer$mapping <- layer$mapping %|W|% plot$mapping
  return(layer)
}

which_facet <- function(plot){
  if(class(plot$facet)[1] == "FacetWrap"){
    out = unname(sapply(plot$facet$params[1]$facets, rlang::quo_text))
  } else if(class(plot$facet)[1] == "FacetGrid") {
    out = unname(sapply(plot$facet$params$cols, rlang::quo_text))
  } else {
    out = NULL
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

faded_layer <- function(layer){

  geom <- get_geom_type(layer)

  fade_fill = layer$aes_params$fill %||% "#cccccc"
  fade_col = layer$aes_params$colour  %||% "#cccccc"

  layer$aes_params$fill = fade_fill
  layer$aes_params$colour = fade_col

  if(geom %in% c("bar","col")){
    layer$aes_params$colour = NULL
  }

  if(geom %in% c("sf")){
    layer$aes_params$colour = NULL
  }

  return(layer)
}

desaturate_layer <- function(layer, style){

  fade_fill = lighten_color(style$color, amount = style$desaturate)
  fade_col = lighten_color(style$color, amount = style$desaturate)
  alpha_lev = layer$aes_params$alpha %||% NULL

  layer$aes_params$fill = fade_fill
  layer$aes_params$colour = fade_col
  layer$aes_params$alpha = alpha_lev

  return(layer)
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

get_interval <- function(data){
  date_var <- get_col(data, type = "Date")[[1]]

  if(!is.na(date_var)){
    dates <- unique(data[[date_var]])
    factor <- as.numeric(min(dates - dplyr::lag(dates), na.rm = TRUE))
  } else {
    factor <- 1
  }
  return(factor)
}

new_layer_data <- function(layer, expr, plot){

  geom <- get_geom_type(layer)

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

  layer$name <- "hi_layer"

  return(layer)
}

style_layer <- function(layer, style, width){

  geom <- get_geom_type(layer)

  layer$aes_params$fill = style$color %||% NULL
  layer$aes_params$colour = style$color %||% NULL
  layer$geom_params$width = 0.9 * width

  if(geom %in% c("line")){
    layer$aes_params$linewidth = style$linewidth
    # layer$aes_params$linetype = style$linetype
  }

  if(geom %in% c("bar","col")){
    layer$aes_params$colour = NULL
  }

  if(geom %in% c("point")){
    layer$aes_params$size = style$size
  }

  if(geom %in% c("sf")){
    layer$aes_params$colour = NULL
  }

  return(layer)
}
