#' Import Data from REDCap Project
#'
#' Import project data from REDCap into R via the API. Import options include raw/labeled data and data type.
#'
#' @param url API url, character.
#' @param token API token, character.
#' @param content Currently limited to: record, userRole, user.
#' @param raw Logical to return raw or labeled data.
#'
#' @return Data.frame with project data.
#' @export
#' @importFrom httr POST
#' @importFrom httr content
#' @importFrom cli cli_alert_success
#' @importFrom cli cli_alert_danger
#' @importFrom readr read_csv
#' @importFrom utils write.csv
#' @importFrom utils capture.output
read_redcap <- function(url, token, content, raw = FALSE){

  if(raw){
    kind <- "raw"
  } else {
    kind <- "label"
  }

  if(!content %in% c("record","userRole","user")){
    stop("Content limited to: record, user, or userRole.")
  }

  params <- list(
    token = token,
    content = content,
    format = "csv",
    type = "flat",
    rawOrLabel = kind,
    exportCheckboxLabel = "true"
  )

  response <- httr::POST(url = url, body = params, encode = "form")

  if(response$status_code == 200){
    cli::cli_alert_success("Importing data from REDCap...")
    content <- httr::content(response, "text")
    records <- readr::read_csv(content, na = "")
    return(records)
  } else {
    cli::cli_alert_danger("Invalid token. Check the API token and try again.")
  }
}

#' Write Data to REDCap Project
#'
#' Write data from R back to REDCap project via API. You must be working with raw, unlabeled data.
#'
#' @param df Data.frame to write back to REDCap.
#' @param url API url, character.
#' @param token API token, character.
#' @param content Currently limited to: record, userRole, user.
#'
#' @return Success or warning message, no data returned.
#' @export
#' @importFrom jsonlite toJSON
write_redcap <- function(df, url, token, content){

  csv <- jsonlite::toJSON(df, pretty = TRUE)

  if(!content %in% c("record","userRole")){
    stop("Content limited to: record, userRole")
  }

  post_body <- list(
    "token" = token,
    content = content,
    format = "json",
    data = csv
  )

  response <- httr::POST(url = url, body = post_body, encode = "form")

  if(response$status_code == 200){
    cli::cli_alert_success("Records succesfully written to REDCap.")
  } else {
    cli::cli_alert_danger("Invalid token. Check the API token and try again.")
  }
}

df_to_csv <- function(df){
  paste(utils::capture.output(utils::write.csv(df, row.names = FALSE, na = "")), collapse = "\n")
}
