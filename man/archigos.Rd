% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{archigos}
\alias{archigos}
\title{Archigos: A (Subset of a) Dataset on Political Leaders}
\format{
A data frame with 3409 observations on the following seven variables.
\describe{
\item{\code{ccode}}{a numeric vector for the Correlates of War state code}
\item{\code{leadid}}{the unique leader identifier}
\item{\code{startdate}}{a date for the leader start date}
\item{\code{enddate}}{a date for the leader end date}
\item{\code{entry}}{a character vector for the leader's entry type}
\item{\code{exit}}{a character vector for the leader's exit type}
\item{\code{exitcode}}{a character vector for more information about the leader's exit type}
}
}
\usage{
archigos
}
\description{
These are leader-level data drawn from the Archigos data. Space considerations mean I offer here just a few columns
based on these data.
}
\details{
Space considerations mean I can only offer a few columns from the overall data. Archigos data are rich with information. Consult
the raw data available on Hein Goeman's website for more. Data are version 4.1.
}
\references{
Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
\emph{Journal of Peace Research} 46(2): 269--83.
}
\keyword{datasets}
