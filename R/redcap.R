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
    returnFormat = "json",
    returnContent = "counts"
  )

  response <- httr::POST(url = url, body = post_body, encode = "form")

  response_content <- httr::content(response, "parsed", encoding = "UTF-8", show_col_types = FALSE)

  if(httr::http_error(response)) {
    stop(paste("HTTP Error:", httr::status_code(response), httr::content(response, "text", encoding = "UTF-8")))
  } else if(is.list(response_content) && "count" %in% names(response_content)) {
    message(paste("Successfully uploaded/modified", response_content$count, "record(s)."))
  } else {
    stop("Some other error I didn't account for.")
  }
}

#' Read in Metadata from REDCap Project
#'
#' This method allows you to read in the metadata for a project. To use this method, you must have API Export privileges in the project. If you're starting a new project and want to bulk upload records, you return = "template" to get a blank data.frame to populate. Otherwise, set return = "dictionary" to see all specs about project. You can send this dictionary to others to upload into their instance of REDCap.
#'
#' @param url Character, API url.
#' @param token Character, token from project.
#' @param return Character, dictionary or template. If bulk uploading new records, use template.
#' @param repeating_instrument Boolean, adds two additional columns (redcap_repeat_instrument, redcap_repeat_instance) to template option.
#'
#' @return Data.frame
#' @export
#' @importFrom tibble as_tibble
#' @importFrom stats setNames
redcap_metadata <- function(url, token, return = c("dictionary","template"), repeating_instrument = FALSE){

  return_what <- match.arg(return, choices = c("dictionary","template"))

  if(return == "dictionary"){
    what <- "metadata"
  } else {
    what <- "exportFieldNames"
  }

  api_call <- meta_call(url, token, what)

  if(return == "template"){
    api_call <- data.frame(matrix(ncol = nrow(api_call), nrow = 1)) %>%
      stats::setNames(api_call$export_field_name) %>%
      tibble::as_tibble()
    if(repeating_instrument){
      api_call$redcap_repeat_instrument <- NA
      api_call <- move_column(api_call, "redcap_repeat_instrument", Position = 2)
      api_call$redcap_repeat_instance <- NA
      api_call <- move_column(api_call, "redcap_repeat_instance", Position = 3)
    }
    #convert all boolean to character
    api_call[] <- lapply(api_call, function(col) if (is.logical(col)) as.character(col) else col)
  }

  return(api_call)
}

#' Delete a Record in REDCap
#'
#' This method allows you to delete one or more records from a project, and also optionally allows you to delete parts of records such as specific instruments and/or repeating instances.
#'
#' @param url Character, API url.
#' @param token Character, token from project.
#' @param record_id Numeric, single or vector of record id's.
#' @param instrument Character, name of instrument that contains data you wish to delete. Optional.
#' @param repeat_instance Character, repeating instance number that contains data you wish to delete. Optional.
#'
#' @returns Number of records deleted  or (if instrument or repeating instance is provided) the number of items deleted over the total records specified.
#' @export
delete_redcap_record <- function(url, token, record_id, instrument = NULL, repeat_instance = NULL){

  records_to_delete <- record_id

  names(records_to_delete) <- sprintf("records[%i]", seq_along(record_id) - 1)

  formData <- list(
    token = token,
    action = "delete",
    content = "record",
    returnFormat = "json"
  )

  instru <-
    if(is.null(instrument)){
      NULL
    } else {
      list("instrument" = instrument)
    }

  repeat_inst <-
    if(is.null(repeat_instance)){
      NULL
    } else {
      list("repeat_instance" = repeat_instance)
    }

  formData <- c(formData, records_to_delete, instru, repeat_inst)

  response <- httr::POST(url, body = formData, encode = "form")

  result <- httr::content(response, as = "text")

  if(httr::http_error(response)){
    error <- httr::content(response, "text")
    error <- gsub('\\"|\\}', "", error) #did not know double quotes can be inside double quotes
    error <- sub("^.*\\{error\\:", "", error)
    stop(error)
  } else if(as.numeric(result) >= 1){
    print(sprintf("%s record(s) successfully deleted from REDCap.", as.numeric(result)))
  } else {
    stop("Error I didn't account for.")
  }
}

#' Unite Checkbox Variables in REDCap
#'
#' While useful for data collection, checkbox variables may need to be merged/united into a singular variable for analysis. REDCap internally labels checkbox variables are "prefix___1", with the number matchin the number response in the checkbox variable. Warning: if REDCap ever changes this format, this function will stop working.
#'
#' @param df Data.frame or tibble.
#' @param prefix Character, prefix of checkbox variable to be combined. If left blank or unspecified, all checkbox variables will be impacted.
#' @param sep Character, delimiter to separate multiple values.
#' @param drop_cols Logical, option to drop united columns after transformation. Default set to FALSE.
#'
#' @returns Data.frame or tibble with united colums using prefix.
#' @export
combine_redcap_checkboxes <- function(df, prefix = NULL, sep = ", ", drop_cols = FALSE){
  if(!is.null(prefix)){
    if(length(prefix) > 0){
      prefix <- paste(paste0(prefix, "___"), collapse = "|")
    }
  } else {
    checkbox_vars <- show_cols(df, "___")
  }

  unique_names <- unique(gsub("___.*", "", checkbox_vars))

  big_drop <- c()

  for(name in unique_names){
    dat <- df[,show_cols(df, paste0(name, "___")), drop = FALSE]

    combined_dat <- apply(dat, MARGIN = 1, FUN = function(x){
      non_na_values <- x[!is.na(x)]

      if(length(non_na_values) == 0){
        return(NA_character_)
      } else {
        get_non_na <- paste(non_na_values, collapse = sep)
        return(as.character(get_non_na))
      }
    })

    cols_to_drop <- colnames(dat)
    big_drop <- append(big_drop, cols_to_drop)
    col_positions <- get_indices(df, name)[1]
    df[[name]] <- combined_dat
    df <- move_column(df, name, Position = col_positions)
  }

  if(drop_cols){
    df <- df[!colnames(df) %in% big_drop]
  }
  return(df)
}

show_cols <- function(df, contains, ignore.case = FALSE){
  search <- grepl(contains, colnames(df), ignore.case = ignore.case)
  position <- which(search, colnames(df))
  out <- colnames(df)[position]
  return(out)
}

get_indices <- function(df, prefix){
  col_names <- names(df)
  matching <- which(startsWith(col_names, paste0(prefix, "___")))
  return(matching)
}

move_column <- function(df, column, Position = 1){
  d <- ncol(df)
  col_names <- names(df)

  for(i in column){
    x <- i == col_names
    if(all(!x)){
      warning(paste('Column \"', i, '"\ not found.'))
    } else {
      d1 <- seq(d)
      d1[x] <- Position - 0.5
      df <- df[order(d1)]
    }
  }
  return(df)
}

con_opt <- function(x){
  tolower(as.character(x))
}

df_to_csv <- function(df){
  csv_lines <- utils::capture.output(utils::write.csv(df, stdout(), row.names = FALSE, na = ""))
  csv <- paste(csv_lines, collapse = "\n")
  return(csv)
}

meta_call <- function(url, token, what){

  return_what <- match.arg(what, choices = c("metadata","exportFieldNames"))

  formData <- list("token" = token,
                   content = what,
                   format = "csv",
                   returnFormat = "json"
  )

  response <- httr::POST(url, body = formData, encode = "form")

  result <- httr::content(response)
  return(result)
}
