#' Split and Print Dataframe
#'
#' Divide a dataframe into multiple .CSV files with a specified number of rows per file.
#'
#' @param path File path for file export
#' @param df Dataframe to export
#' @param chunks Number of rows to split dataframe into
#' @param prefix Default set to "List". Option to specify file prefix.
#'
#' @return Multiple .CSV files split into number of rows specified from chunks argument.
#' @export
#' @importFrom utils write.csv
#'
#' @examples
#'
#' \dontrun{
#' split_df(path = "G:/file_path/", df = test_data, chunks = 200, prefix = "list_")
#' }
split_df <- function(path = NULL, df, chunks = NULL, prefix = "List_"){

  #error message
  if(missing(path)){
    stop("Path not provided.")
  }

  if(missing(df)){
    stop("Dataframe not specified.")
  }

  if(!class(chunks) %in% c("numeric","integer") | missing(chunks)){
    stop("Provide a valid number to split files.")
  }

  #split dataframe to files of CHUNKS rows
  r <- rep(1:ceiling(nrow(df)/chunks), each = chunks)[1:nrow(df)]
  d <- split(df, r)

  #write to csv
  for(i in names(d)){
    write.csv(d[[i]], paste0(path, prefix, i,".csv"), na = "", row.names = FALSE)
  }
}
