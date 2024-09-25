#' Wrap Long Axis Labels
#'
#' Wrap long axis labels to avoid overcrowding.
#'
#' @param width Higher value = less wrapping, lower value = more wrapping. Recommended width is 15.
#'
#' @return Wrapped labels.
#' @export
#'
#' @examples
#' df <- data.frame(group = c("Native Hawaiian or Other Pacific Islander",
#' "Black or African American","American Indian or Alaska Native"), score = c(89.5, 84, 73))
#'
#' ggplot(data = df, aes(x = group, y = score)) +
#'  geom_col() +
#'  scale_x_discrete(labels = wrap_labels(width = 15))
wrap_labels <- function(width) {
  function(x) {
    lapply(strwrap(gsub("\\/","\\/ ", x), width = width, simplify = FALSE), paste, collapse = "\n")
  }
}
