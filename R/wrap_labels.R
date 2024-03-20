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
#' \dontrun{
#' df <- data.frame(group = c("Native Hawaiian or Other Pacific Islander","Black or African American","American Indian or Alaska Native"), score = c(89.5, 84, 73))
#'
#' ggplot(data = df, aes(x = group, y = score)) +
#'  geom_col() +
#'  scale_x_discrete(labels = wrap_labels(width = 15))
#'  }
wrap_labels <- function(width) {
  #credit: https://stackoverflow.com/questions/21878974/wrap-long-axis-labels-via-labeller-label-wrap-in-ggplot2
  function(x) {
    lapply(strwrap(x, width = width, simplify = FALSE), paste, collapse = "\n")
  }
}