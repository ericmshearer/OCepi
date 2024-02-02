#' Batch Load CSV Files
#'
#' Intended to batch load VRBIS death files for analysis. All columns are read in as character to minimize errors.
#'
#' @param file_names Vector of files with full path names.
#' @param col_names Boolean TRUE/FALSE. Use FALSE if your files do not have column headers/names.
#'
#' @return Dataframe of binded files.
#' @export
#' @importFrom utils read.csv
#'
#' @examples
#' files <- list.files(path = "G:/file_path/Files/", full.names = TRUE, pattern = ".csv")[39:40]
#' df <- batch_load(files, col_names = FALSE)
batch_load <- function(file_names, col_names = FALSE){

  temp_list <- list()

  if(col_names == TRUE){
    for(i in file_names){
      data <- read.csv(i, na.strings = "", stringsAsFactors = FALSE, header = TRUE, colClasses = "character")
      name <- i
      temp_list[[name]] <- data
      print(paste(i, "completed."))
    }
  } else{
    for(i in file_names){
      data <- read.csv(i, na.strings = "", stringsAsFactors = FALSE, header = FALSE, colClasses = "character")
      name <- i
      temp_list[[name]] <- data
      print(paste(i, "completed."))
    }
  }

  df <- do.call("rbind", temp_list)
  rownames(df) <- NULL
  return(df)
}
