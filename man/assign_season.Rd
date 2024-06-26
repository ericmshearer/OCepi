% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assign_season.R
\name{assign_season}
\alias{assign_season}
\title{Assign Respiratory Season}
\usage{
assign_season(date)
}
\arguments{
\item{date}{Input date.}
}
\value{
Character in format YYYY-YY.
}
\description{
Calculate respiratory season based on laboratory or episode date. Respiratory season is defined as week 40 through week 39.
}
\examples{
x = as.Date("2023-10-01")
assign_season(x)
}
