#' Wrap Long Axis Labels
#'
#' Shorten total width of x-axis labels by breaking/wrapping text at forward slash or at "or".
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
#'  scale_x_discrete(labels = wrap_labels())
wrap_labels <- function() {
  function(x){sub("\\/| or", "\\/\n", x)}
}
