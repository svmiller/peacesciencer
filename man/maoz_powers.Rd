% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-others.R
\docType{data}
\name{maoz_powers}
\alias{maoz_powers}
\title{Zeev Maoz' Regional/Global Power Data}
\format{
A data frame with 20 observations on the following 5 variables.
\describe{
\item{\code{ccode}}{a numeric vector for the Correlates of War country code}
\item{\code{regstdate}}{the start date for regional power status}
\item{\code{regenddate}}{the end date for regional power status}
\item{\code{globstdate}}{the start date for global power status}
\item{\code{globenddate}}{the end date for global power status}
}
}
\usage{
maoz_powers
}
\description{
These are Zeev Maoz' data for what states are regional or global powers at a
given point time. They are extensions of the Correlates of War major power
data, which only codes "major" power without consideration of regional or
global distinctions. Think of Austria-Hungary as intuitive of the issue here.
Austria-Hungary is a major power in the Correlates of War data, but there is
good reason to treat Austria-Hungary as a major power only within Europe.
That is what Zeev Maoz tries to do here.
}
\references{
Maoz, Zeev. 2010. \emph{Network of Nations: The Evolution, Structure,
and Impact of International Networks, 1816-2001}. Cambridge University Press.
}
\keyword{datasets}
