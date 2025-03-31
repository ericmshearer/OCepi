path_r_project <- function(){
  current_dir <- normalizePath(getwd(), mustWork = TRUE)

  while(!identical(current_dir, dirname(current_dir))) {
    if (any(file.exists(file.path(current_dir, c(".Rproj", ".git"))))) {
      return(current_dir)
    }

    current_dir <- dirname(current_dir)
  }
}

#' Setup R Project
#'
#' Spend less time thinking about how to setup R project directories. If not currently working within a R Project, function will return an error.
#'
#' @param subs Character, vector of sub-directories to create if not already present.
#' @param read_me Boolean to indicate if you want to use built-in OCepi Rmd template.
#'
#' @return Three sub-directories and READme.
#' @export
setup_project <- function(subs = c("R","data","output"), read_me = FALSE){

  current_dir <- path_r_project()

  current_subs <- list.dirs(current_dir, full.names = FALSE, recursive = FALSE)

  subs <- subs[!subs %in% current_subs]

  for(i in subs){
    dir.create(paste(current_dir, i, sep = "/"))
  }

  message("R Project setup complete.")

  # if(!dir.exists("R")){
  #   dir.create("R")
  # }
  #
  # if(!dir.exists("data")){
  #   dir.create("data")
  # }
  #
  # if(!dir.exists("output")){
  #   dir.create("output")
  # }

  if(read_me){
    pkg_dir <- system.file(package = "OCepi")
    rmd_path <- paste0(pkg_dir, "/rmarkdown/templates/epi_workflow/skeleton/")
    rmd_to_copy <- list.files(path = rmd_path, full.names = TRUE)
    invisible(file.copy(rmd_to_copy, current_dir))
    invisible(file.rename("skeleton.Rmd", "READme.Rmd"))
  }
}
