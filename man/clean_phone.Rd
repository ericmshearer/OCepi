% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clean_phone.R
\name{clean_phone}
\alias{clean_phone}
\title{Clean Phone Number}
\usage{
clean_phone(phone_var)
}
\arguments{
\item{phone_var}{Phone number variable.}
}
\value{
Clean 10 digit US based phone number. If international or invalid phone number/not 10 digits, returns NA.
}
\description{
Clean Phone Number
}
\examples{
clean_phone("1-714-834-8180")
}
