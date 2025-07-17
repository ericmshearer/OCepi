con_opt <- function(x){
  tolower(as.character(x))
}

df_to_csv <- function(df){
  csv_lines <- utils::capture.output(utils::write.csv(df, stdout(), row.names = FALSE, na = ""))
  csv <- paste(csv_lines, collapse = "\n")
  return(csv)
}

#' Read in Data from REDCap Project
#'
#' This method allows you to import/read in a set of records for a project. To use this method, you must have API Import/Update privileges in the project. Please be aware that Data Export user rights will be applied to this API request. For example, if you have 'No Access' data export rights in the project, then the API data export will fail and return an error. And if you have 'De-Identified' or 'Remove All Identifier Fields' data export rights, then some data fields *might* be removed and filtered out of the data set returned from the API. To make sure that no data is unnecessarily filtered out of your API request, you should have 'Full Data Set' export rights in the project.
#'
#' @param url Character, API url.
#' @param token Character, token from project.
#' @param raw Logical, export the raw coded values or labels for the options of multiple choice fields.
#' @param exportCheckboxLabel Logical, export the checkbox value as the checkbox option's label (e.g., 'Choice 1').
#' @param exportSurveyFields Logical, export the survey identifier field (e.g., 'redcap_survey_identifier') or survey timestamp fields (e.g., instrument+'_timestamp') when surveys are utilized in the project.
#'
#' @return Data.frame with project data.
#'
#' @importFrom httr POST
#' @importFrom httr content
#' @importFrom httr http_error
#' @importFrom readr read_csv
#' @importFrom utils read.csv
#' @importFrom utils write.csv
#' @importFrom utils capture.output
#'
#' @export
read_redcap <- function(url, token, raw = TRUE, exportCheckboxLabel = FALSE, exportSurveyFields = FALSE){

  if(!raw){
    kind <- "label"
  } else {
    kind <- "raw"
  }

  params <- list(
    token = token,
    content = "record",
    format = "csv",
    type = "flat",
    rawOrLabel = kind,
    exportCheckboxLabel = con_opt(exportCheckboxLabel),
    returnFormat = "json",
    exportSurveyFields = con_opt(exportSurveyFields)
  )

  response <- httr::POST(url = url, body = params, encode = "form")

  if(httr::http_error(response)){
    stop(paste("HTTP Error:", httr::status_code(response), httr::content(response, "text", encoding = "UTF-8")))
  } else if(response$status_code == "200") {
    content <- httr::content(response, "text")
    records <- readr::read_csv(content, na = "")
  } else {
    stop("Some other error message I didn't account for.")
  }
}

#' Write New or Modified Data to REDCap Project
#'
#' This method allows you to upload/write a set of records for a project. To use this method, you must have API Export privileges in the project.
#'
#' @param df Data.frame to write back to REDCap.
#' @param url Character, API url.
#' @param token Character, token from project.
#' @param forceAutoNumber Logical, if TRUE new record ids will be automatically determined.
#'
#' @return Success or warning message, no data returned.
#'
#' @importFrom utils capture.output
#' @importFrom utils write.csv
#'
#' @export
write_redcap <- function(df, url, token, forceAutoNumber = FALSE){

  csv <- df_to_csv(df)

  post_body <- list(
    "token" = token,
    content = "record",
    format = "csv",
    data = csv,
    overwriteBehavior = "normal", #blank/empty values will be ignored
    forceAutoNumber = con_opt(forceAutoNumber),
    returnContent = "json"
  )

  response <- httr::POST(url = url, body = post_body, encode = "form")

  response_content <- httr::content(response, "parsed", encoding = "UTF-8", show_col_types = FALSE)

  if(httr::http_error(response)) {
    stop(paste("HTTP Error:", httr::status_code(response), httr::content(response, "text", encoding = "UTF-8")))
  } else if(is.list(response_content) && "count" %in% names(response_content)) {
    paste("Successfully uploaded/modified", response_content$count, "record(s).")
  } else {
    stop("Some other error message I didn't account for.")
  }
}

#' Read in Metadata from REDCap Project
#'
#' This method allows you to read in the metadata for a project. To use this method, you must have API Export privileges in the project. If you're starting a new project and want to bulk upload records, you return = "template" to get a blank data.frame to populate. Otherwise, set return = "dictionary" to see all specs about project. You can send this dictionary to others to upload into their instance of REDCap.
#'
#' @param url Character, API url.
#' @param token Character, token from project.
#' @param forms Vector, if not specified will include all forms.
#' @param return Character, dictionary or template. If bulk uploading new records, use template.
#'
#' @return Data.frame with project metadata.
#' @export
redcap_metadata <- function(url, token, forms = NULL, return = c("dictionary","template")){

  return_what <- match.arg(return, choices = c("dictionary","template"))

  get_forms <- sapply(seq_along(forms), function(i){
    name_tag <- sprintf("forms[%s]", i-1)
    result <- list(forms[i])
    names(result) <- name_tag
    return(result)
  })

  formData <- list("token" = token,
                   content = "metadata",
                   format = "csv",
                   returnFormat = "json"
  )

  if(!is.null(forms)){
    formData <- c(formData, get_forms)
  }

  response <- httr::POST(url, body = formData, encode = "form")
  dat <- httr::content(response, show_col_types = FALSE)

  form_names <- unique(dat$form_name)

  new_cols <- paste(form_names, "complete", sep = "_")

  empty_matrix <- matrix(nrow = 0, ncol = nrow(dat))

  #Setup template
  template <- as.data.frame(empty_matrix)
  colnames(template) <- dat$field_name
  template[nrow(template)+1,] <- NA
  template[] <- lapply(template, as.character)
  template[,new_cols] <- 0

  if(return == "template"){
    return(template)
  } else {
    return(dat)
  }
}
