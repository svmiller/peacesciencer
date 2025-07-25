% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_latent_territorial_threat.R
\name{add_latent_territorial_threat}
\alias{add_latent_territorial_threat}
\title{Add estimated latent territorial threat to a data frame}
\usage{
add_latent_territorial_threat(data, keep)
}
\arguments{
\item{data}{a data frame with appropriate \pkg{peacesciencer} attributes}

\item{keep}{an optional parameter, specified as a character vector, about
what capability estimates the user wants to return from this function. If not
specified, everything from the underlying capabilities data is returned.}
}
\value{
\code{add_latent_territorial_threat()} takes a data frame and adds
estimates of latent, external territorial threat derived from a random item
response model (as described by Miller (2022)).
}
\description{
\code{add_latent_territorial_threat()} allows you to add estimates of latent,
external territorial threat to a dyad-year, leader-year, or leader-dyad-year,
or state-year data frame. The estimates come by way of Miller (2022).
}
\details{
The data are stored in \link{terrthreat} in this package, which also communicates
what the variables are and what they mean in the case of overlapping
column names. Miller (2022) describes the random item response model in
more detail.

The standard caveat applies that the data are fundamentally state-year (though
derived from dyad-year analyses). Extensions to leader-level data sets should
be understood as approximate. For example, it's reasonable to infer the
territorial threat for Germany under Friedrich Ebert in 1918 would differ
from what Wilhelm II would've experienced in the same year. However, the data
would have no way of knowing that (as they are).

The state-year nature of the data also carry implications for its use in
dyad-year analyses. The function returns estimates of state-year levels of
territorial threat for the first state and second state in the dyad, and not
the level of territorial threat between each state in the dyad for the given
year.

The \code{keep} argument must include one or more of the capabilities estimates
included in \code{terrthreat}. Otherwise, it will return an error that it cannot
subset columns that do not exist.
}
\examples{

\donttest{
# just call `library(tidyverse)` at the top of the your script
create_stateyears() |> add_latent_territorial_threat(keep=c('lterrthreat'))
}

}
\references{
Miller, Steven V. 2022. "A Random Item Response Model of External Territorial
Threat, 1816-2010" \emph{Journal of Global Security Studies} 7(4): ogac012.
}
\author{
Steven V. Miller
}
