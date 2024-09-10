#' Match ID #1 - Partial Name, DOB, Partial Address
#'
#' Match ID for linking disparate datasets using parts of identifiers. Be aware of address formatting and consider recoding variable using clean_address.
#'
#' @param first_name First 4 characters of string
#' @param last_name First 4 characters of string
#' @param dob Date
#' @param part_address First 10 characters of string
#'
#' @return Match id using part of name, date of birth, and the first 10 characters of the address.
#' @export
#'
#' @examples
#' match_id_1("Mickey","Mouse","1955-07-17","1313 Disneyland Dr")
match_id_1 <- function(first_name, last_name, dob, part_address){
  id <- trimws(sprintf("%s%s%s%s", partial(first_name, 4), partial(last_name, 4), dob, partial(part_address, 10, upper_case = FALSE)))
  return(id)
  }

#' Match ID #2 - Partial Name, DOB, Full Address
#'
#' Match ID for linking disparate datasets using parts of identifiers.
#'
#' @param first_name First 4 characters of string
#' @param last_name First 4 characters of string
#' @param dob Date
#' @param address Full address
#'
#' @return Match id using part of name, date of birth, and full address.
#' @export
#'
#' @examples
#' match_id_2("Mickey","Mouse","1955-07-17","1313 Disneyland Dr")
match_id_2 <- function(first_name, last_name, dob, address){
  id <- trimws(sprintf("%s%s%s%s", partial(first_name, 4), partial(last_name, 4), dob, address))
  return(id)
  }

#' Match ID #3 - Partial Name, DOB, Phone Number
#'
#' Match ID for linking disparate datasets using parts of identifiers. Be aware of phone number formatting and consider recoding variable using clean_phone.
#'
#' @param first_name First 4 characters of string
#' @param last_name First 4 characters of string
#' @param dob Date
#' @param phone_number String or Numeric
#'
#' @return Match id using part of name, date of birth, and phone number.
#' @export
#'
#' @examples
#' match_id_3("Mickey","Mouse","1955-07-17","7147814636")
match_id_3 <- function(first_name, last_name, dob, phone_number){
  id <- trimws(sprintf("%s%s%s%s", partial(first_name), partial(last_name, 4), dob, phone_number))
  return(id)
  }

#' Match ID #4 - Partial Name, DOB
#'
#' Match ID for linking disparate datasets using parts of identifiers.
#'
#' @param first_name First 4 characters of string
#' @param last_name First 4 characters of string
#' @param dob Date
#'
#' @return Match id using part of name and date of birth.
#' @export
#'
#' @examples
#' match_id_4("Mickey","Mouse","1955-07-17")
match_id_4 <- function(first_name, last_name, dob){
  id <- trimws(sprintf("%s%s%s", partial(first_name, 4), partial(last_name, 4), dob))
  return(id)
  }
