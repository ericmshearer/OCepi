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

faded_layer <- function(layer, plot, desaturate){

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

desaturate_layer <- function(layer, plot, color, desaturate){

  geom <- get_geom_type(plot)

  fade_fill = lighten_color(color, amount = desaturate)
  fade_col = lighten_color(color, amount = desaturate)
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

get_interval <- function(data){
  var_check <- sapply(data, function(x) !all(is.na(as.Date(as.character(x), format = "%Y-%m-%d"))))
  date_var <- names(which(var_check))

  if(length(date_var)==1){
    dates <- data[[date_var]]
    factor <- as.numeric(min(dates - lag(dates), na.rm = TRUE))
  } else {
    factor <- 1
  }
  return(factor)
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

  int_factor <- get_interval(layer$data)

  layer$data <- new_data
  layer$aes_params$fill = color
  layer$aes_params$colour = color
  layer$geom_params$width = 0.9 * int_factor

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
