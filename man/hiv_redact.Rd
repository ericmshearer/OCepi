% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hiv_redact.R
\name{hiv_redact}
\alias{hiv_redact}
\title{Redact HIV/AIDS from Dataframe}
\usage{
hiv_redact(df)
}
\arguments{
\item{df}{Dataframe with HIV/AIDS removed.}
}
\value{
Dataframe. Warning message printed to console if HIV/AIDS data detected.
}
\description{
Convert manual process of redacting sensitive health information. Works exclusively on dataframes.
}
\examples{
df <- data.frame(cause = c("cancer","hepatitis","COVID-19","HIV"))
hiv_redact(df)
}