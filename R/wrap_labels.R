#' Wrap Long Axis Labels
#'
#' Break long axis labels at one or more "delimiters".
#'
#' @param x Input list of labels.
#' @param delim Vector of characters or words to break label.
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
#'  scale_x_discrete(labels = wrap_labels(delim = "or"))
wrap_labels <- function(x, delim) {
  if(length(delim)==1){
    function(x){gsub(sprintf("(%s)", delim), "\\1\n", x)}
  } else {
    function(x){gsub(sprintf("(%s)", paste0(delim, collapse = "|")), "\\1\n", x)}
  }
}
