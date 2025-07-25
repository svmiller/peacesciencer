% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-gml.R
\docType{data}
\name{gml_dirdisp}
\alias{gml_dirdisp}
\title{Directed dispute-year data (Gibler, Miller, and Little, 2016)}
\format{
A data frame with 10,276 observations on the following 39 variables.
\describe{
\item{\code{dispnum}}{the dispute number}
\item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
\item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
\item{\code{year}}{a numeric vector for the year}
\item{\code{midongoing}}{a constant of 1 for ongoing disputes}
\item{\code{midonset}}{a numeric vector that equals 1 for the onset year of a given dispute}
\item{\code{sidea1}}{is the first state (in \code{ccode1}) on the side that took the first militarized action?}
\item{\code{sidea2}}{is the second state (in \code{ccode2}) on the side that took the first militarized action?}
\item{\code{revstate1}}{is the first state (in \code{ccode1}) a revisionist state in the dispute?}
\item{\code{revstate2}}{is the second state (in \code{ccode2}) a revisionist state in the dispute?}
\item{\code{revtype11}}{what is the \code{revtype1} value for \code{ccode1}?}
\item{\code{revtype12}}{what is the \code{revtype1} value for \code{ccode2}?}
\item{\code{revtype21}}{what is the \code{revtype2} value for \code{ccode1}?}
\item{\code{revtype22}}{what is the \code{revtype2} value for \code{ccode2}?}
\item{\code{fatality1}}{what is the \code{fatality} value for \code{ccode1}?}
\item{\code{fatality2}}{what is the \code{fatality} value for \code{ccode2}?}
\item{\code{fatalpre1}}{what is the \code{fatalpre} value for \code{ccode1}?}
\item{\code{fatalpre2}}{what is the \code{fatalpre} value for \code{ccode2}?}
\item{\code{hiact1}}{what is the \code{hiact} value for \code{ccode1}?}
\item{\code{hiact2}}{what is the \code{hiact} value for \code{ccode2}?}
\item{\code{hostlev1}}{what is the \code{hostlev} value for \code{ccode1}?}
\item{\code{hostlev2}}{what is the \code{hostlev} value for \code{ccode2}?}
\item{\code{orig1}}{is \code{ccode1} an originator (1) of the dispute or a joiner (0)?}
\item{\code{orig2}}{is \code{ccode2} an originator (1) of the dispute or a joiner (0)?}
\item{\code{hiact}}{the highest level of action observed in the dispute}
\item{\code{hostlev}}{the hostility level of action observed in the dispute}
\item{\code{mindur}}{the minimum length of the dispute (in days)}
\item{\code{maxdur}}{the maximum length of the dispute (in days)}
\item{\code{outcome}}{the dispute-level outcome}
\item{\code{settle}}{the settlement value for the dispute}
\item{\code{fatality}}{the ordinal fatality level for the dispute}
\item{\code{fatalpre}}{the fatalities (with precision, if known) for the dispute}
\item{\code{stmon}}{the start month of the dispute (dispute-level)}
\item{\code{endmon}}{the end month of the dispute (dispute-level)}
\item{\code{recip}}{was the dispute reciprocated (i.e. did Side B also have a militarized action)?}
\item{\code{numa}}{the number of participants on Side A}
\item{\code{numb}}{the number of participants on Side B}
\item{\code{ongo2010}}{was the dispute ongoing as of 2010?}
\item{\code{version}}{a version identifier}
}
}
\usage{
gml_dirdisp
}
\description{
These are directed dispute-year data from the most recent version (2.2.1) of
the Gibler-Miller-Little (GML) militarized interstate dispute (MID) data.
They are used internally for merging into full dyad-year data frames.
}
\details{
Data are the directed dispute-year data made available in version 2.1.1 of
the GML MID data.

I would caution against using the \code{revtype} variables. They are not
informative. They are however included for legacy reasons.
}
\references{
Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis
of the Militarized Interstate Dispute (MID) Dataset, 1816-2001.”
\emph{International Studies Quarterly} 60(4): 719-730.
}
\keyword{datasets}
