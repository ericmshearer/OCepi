% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mmwr.R
\name{week_ending_date}
\alias{week_ending_date}
\title{Week Ending Date}
\usage{
week_ending_date(date)
}
\arguments{
\item{date}{Input date.}
}
\value{
Output date.
}
\description{
Calculate week ending date following CDC MMWR schema.
}
\examples{
episode_date = as.Date("2020-01-14")
week_ending_date(episode_date)
}
