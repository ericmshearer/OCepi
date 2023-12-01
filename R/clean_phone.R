#' Clean Phone Number
#'
#' @param phone_var Phone number variable.
#'
#' @return Clean 10 digit US based phone number. If international or invalid phone number/not 10 digits, returns NA.
#' @export
#'
#' @examples
#' clean_phone("1-714-834-8180")
clean_phone <- function(phone_var){

  phone_var = gsub("\\-|\\+|\\(|\\)|\\s+", "", phone_var)

  if(startsWith(phone_var, "1")){
    phone_var = substr(phone_var, 2, nchar(phone_var))
  }

  if(nchar(phone_var) == 10){
    return(phone_var)
  }else{
    return(NA)
  }
}
