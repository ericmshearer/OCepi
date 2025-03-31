#' Aggregate Data for Dashboard Reporting
#'
#' Summarize data across columns in preparation for dashboard reporting.
#'
#' @param data Input dataframe containing only those columns that need to be summarized.
#' @param group_by To be used if summarizing data over multiple years or groups.
#' @param reverse Sets order of n and percent in label.
#' @param digits Number of digits to round proportion.
#' @param n_suppress Suppress values less than specified value.
#'
#' @return Dataframe with n, proportion, and label.
#' @rdname dashboard_tbl
#' @export
dashboard_tbl <- function(data, group_by = NULL, reverse = TRUE, digits = 1, n_suppress = NULL){

  splinter <- deparse(substitute(group_by))

  if(missing(group_by)){
    data <- data %>%
      lapply(function(x) init_tbl(x)) %>%
      lapply(function(x) final_tbl(x, digits = digits, reverse = reverse, n_suppress = n_suppress))

    data <- lapply(names(data), function(n, data){
      data[[n]]$Variable <- n
      return (data[[n]])
      }, data) %>%
      rapply(as.character, classes = "factor", how = "replace")

    out <- do.call(rbind, data)
    out <- out[,c("Variable","Category","n","Percent","Label")]
  } else {
    data <- data %>%
      split(f = data[[splinter]])

    data <- data %>%
      lapply(function(subdf){
        lapply(subdf, function(col){
          x <- init_tbl(col)
          x <- final_tbl(x, digits = digits, reverse = reverse, n_suppress = n_suppress)
          return(x)
        })
      }) %>%
      rapply(as.character, classes = "factor", how = "replace")

    data <- data %>%
      do.call(rbind,
              lapply(function(subdf){
                lapply(names(subdf), function(n, subdf){
                  subdf[[n]]$Variable <- n
                  return (subdf[[n]])}, subdf)
                })
              )

    out <- do.call(rbind,
                   lapply(names(data), function(n, data){
                     data[[n]]$Year <- n
                     return (data[[n]])},
                     data)
                   )

    out <- out[,c("Year","Variable","Category","n","Percent","Label")]
    out$Percent <- ifelse(out$Variable == splinter, NA, out$Percent)
    out$Label <- ifelse(out$Variable == splinter, NA, out$Label)
  }

  return(out)
}

init_tbl <- function(col){
  as.data.frame(table(col))
}

final_tbl <- function(tbl, digits, reverse, n_suppress){
  colnames(tbl) <- c("Category","n")
  tbl$Percent <- add_percent(tbl$n, digits = digits)
  tbl$Label <- n_percent(tbl$n, tbl$Percent, reverse = reverse, n_suppress = n_suppress)
  return(tbl)
}
