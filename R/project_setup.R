#' Setup R Project
#'
#' Spend less thinking about how to setup R project directories.
#'
#' @param read_me
#'
#' @return Three sub-directories and READme.
#' @export
setup_project <- function(read_me = FALSE){

  if(!dir.exists("R")){
    dir.create("R")
  }

  if(!dir.exists("data")){
    dir.create("data")
  }

  if(!dir.exists("output")){
    dir.create("output")
  }

  if(read_me){
    pkg_dir <- system.file(package = "OCepi")
    rmd_path <- paste0(pkg_dir, "/rmarkdown/templates/epi_workflow/skeleton/")
    rmd_to_copy <- list.files(path = rmd_path, full.names = TRUE)
    invisible(file.copy(rmd_to_copy, getwd()))
    invisible(file.rename("skeleton.Rmd", "READme.Rmd"))
  }
}
