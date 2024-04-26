#' Highlight Keywords in ggplot2 Title
#'
#' When building ggplot using highlight_geom, you may need to color a word in the title to draw focus. Function depends on ggtext::element_markdown() to be added to theme plot.
#'
#' @param text Title, string.
#' @param words Named vector with word(s) and hex code.
#'
#' @return Title with highlighted word/words.
#' @export
#'
#' @examples
#' \dontrun{
#' df <- data.frame(locations = letters[1:5], events = c(20,24,19,12,33))
#' ggplot(data = df, aes(x = locations, y = events)) +
#' geom_col() +
#'  labs(
#'    title = highlight_title("New Title Goes Here FRIEND", words = c("New"="#d55c19"))
#'  ) +
#'  theme(
#'    plot.title = ggtext::element_markdown()
#'  )
#'  }
highlight_title <- function(text = NULL, words = NULL){
  shell = text
  list = words
  for(i in 1:length(list)){
    shell = gsub(names(list[i]), sprintf("<span style='color:%s;'>%s</span>", unname(list[i]), names(list[i])), shell)
  }
  return(shell)
}
