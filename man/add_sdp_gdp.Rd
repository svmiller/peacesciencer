% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_sdp_gdp.R
\name{add_sdp_gdp}
\alias{add_sdp_gdp}
\title{Add (Surplus and Gross) Domestic Product Data (DEPRECATED)}
\usage{
add_sdp_gdp(data)
}
\arguments{
\item{data}{a data frame with appropriate \pkg{peacesciencer} attributes}
}
\value{
\code{add_sdp_gdp()} takes a (dyad-year, leader-year, leader-dyad-year,
state-year)  data frame and adds information about the estimated gross
domestic product (in 2011 USD) for that year, the estimated population
in that year, the GDP per capita in that year, and what Anders, Fariss
and Markowitz term the "surplus domestic product" in that year. If the
data are dyad-year (leader-dyad-year), the function adds eight total
columns for the first state (i.e. \emph{ccode1}) and the second state
(i.e. \emph{ccode2}) for all these estimates. If the data are state-year
(or leader-year), the function returns four additional columns to the
original data that contain that same information for a given state in
a given year.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}

\code{add_sdp_gdp()} allowed you to add estimated GDP and "surplus"
domestic product data from a 2020 analysis published in \emph{International
Studies Quarterly} by Anders, Fariss, and Markowitz. The data that allow you
to do this have since been updated and is now in \pkg{isard}.
\code{add_sim_gdp_pop()} will allow users to add the kind of data provided
by Anders et al. by way of their revised simulations.
}
\details{
The function leans on attributes of the data that are provided by one of
the "create" functions. Make sure a recognized function (or data created
by that function) appear at the top of the proverbial pipe. Users will
also want to note that the underlying function access two different data
sets. It appears that the results published in the
\emph{International Studies Quarterly} used Correlates of War classification,
but a follow-up repository on Github uses Gleditsch-Ward classification.
The extent to which these estimates are generated by simulation, it does
mean the estimates will be slightly different across both data sets even
for common observations (e.g. the United States in 1816).

Because these are large nominal numbers, the estimates have been
log-transformed. Users can always exponentiate these if they choose.
Researchers can use these data to construct reasonable estimates of
surplus GDP per capita, but must exponentiate the underlying variables
before doing this.

Be mindful that the data are fundamentally state-year and that extensions
to leader-level data should be understood as approximations for leaders in
a given state-year.
}
\examples{

# just call `library(tidyverse)` at the top of the your script
library(magrittr)

cow_ddy \%>\% add_sdp_gdp()

create_stateyears() \%>\% add_sdp_gdp()

create_stateyears(system = "gw") \%>\% add_sdp_gdp()


}
\references{
Anders, Therese, Christopher J. Fariss, and Jonathan N. Markowitz. 2020.
"Bread Before Guns or Butter: Introducing Surplus Domestic Product (SDP)"
\emph{International Studies Quarterly} 64(2): 392--405.
}
\author{
Steven V. Miller
}
