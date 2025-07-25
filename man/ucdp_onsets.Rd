% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{ucdp_onsets}
\alias{ucdp_onsets}
\title{UCDP Onset Data (v. 19.1)}
\format{
A data frame with 10142 observations on the following eight variables.
\describe{
\item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward state code}
\item{\code{year}}{a numeric vector for the year}
\item{\code{sumnewconf}}{a numeric vector for the sum of new conflicts/conflict-dyads}
\item{\code{sumonset1}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than one year since last conflict episode}
\item{\code{sumonset2}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than two years since last conflict episode}
\item{\code{sumonset3}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than three years since last conflict episode}
\item{\code{sumonset5}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than five years since last conflict episode}
\item{\code{sumonset10}}{a numeric vector for the sum of new conflict episodes, whether because this is a new conflict or because there is more than 10 years since last conflict episode}
}
}
\usage{
ucdp_onsets
}
\description{
These are state-year level data for armed conflict onsets provided by the
Uppsala Conflict Data Program (UCDP).
}
\details{
The user will want to note that the data provided by UCDP are technically not
country-year observations. They instead duplicate observations for cases of
new conflicts or new conflict episodes. Further, the original data do not
provide any information about the conflict-dyad in question to which those
duplicates pertain. That means the most these data can do for the package's
mission is provide summary information. The user should probably recode these
variables into something else they may want for a particular application.
}
\references{
Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg & Havard Strand (2002)
Armed Conflict 1946–2001: A New Dataset. \emph{Journal of Peace Research} 39(5): 615–637.

Pettersson, Therese; Stina Hogbladh & Magnus Oberg (2019). Organized violence, 1989-2018 and peace
agreements. Journal of Peace Research 56(4): 589-603.
}
\keyword{datasets}
