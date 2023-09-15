#' Batch Load Vital Records
#'
#' Intended to batch load VRBIS death files for analysis. All columns are read in as character to minimize errors when binding. Assumes all files have same number of columns.
#'
#' @param file_names Vector of files with full path names.
#'
#' @return Dataframe of binded files.
#' @export
#'
#' @examples
#' files_to_load <-list.files(path = "G:/your_file_path/", pattern = "^death", full.names = TRUE)
#' merged_data <- batch_load_vrbis(files_to_load)
batch_load_vrbis <- function(file_names){

  temp_list <- list()

  for(i in file_names){
    data <- read.csv(i, na.strings = "", stringsAsFactors = FALSE, header = FALSE, colClasses = "character")
    name <- i
    temp_list[[name]] <- data
    print(paste(i, "completed."))
  }

  df <- do.call("rbind", temp_list)
  rownames(df) <- NULL
  return(df)
}
