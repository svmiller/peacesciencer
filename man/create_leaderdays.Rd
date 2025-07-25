% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_leaderdays.R
\name{create_leaderdays}
\alias{create_leaderdays}
\title{Create leader-days from leader data}
\usage{
create_leaderdays(system = "archigos", standardize = "none")
}
\arguments{
\item{system}{a leader system with which to create leader-days. Right now,
only "archigos" is supported.}

\item{standardize}{a character vector of length one: "cow", "gw", or "none".
If "cow", the function standardizes the leader-days to just those that overlap
with state system membership in the Correlates of War state system (see:
\link{cow_states}). If "gw", the function standardizes the leader-days to just
those that overlap with the state system dates of the Gleditsch-Ward date
(see: \link{gw_states}). If "none", the function returns all leader-days as
presented in Archigos (which is nominally denominated in Gleditsch-Ward
state system codes, if not necessarily Gleditsch-Ward state system dates).
Default is "none".}
}
\value{
\code{create_leaderdays()} takes leader-level data available in
\pkg{peacesciencer} and returns a leader-day-level data frame.
}
\description{
\code{create_leaderdays()} allows you to generate leader-day data from
leader-level data provided in \pkg{peacesciencer}.
}
\details{
\code{create_leaderdays()}, as of writing, only supports the Archigos data
set of leaders. I envision this function being mostly for internal uses.
Basically, \code{create_leaderyears()} effectively starts by first running a
version of \code{create_leaderdays()}. So, why not have this function too?

The Archigos data are anchored in the Gleditsch-Ward system of states, which
now includes (in this package by way of \pkg{isard}) the microstates. However,
the Archigos data do not include information for the leaders of microstates.
}
\examples{
\donttest{
create_leaderdays()

create_leaderdays(standardize = "gw")
}

}
\references{
Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
"Introducing Archigos: A Dataset of Political Leaders" \emph{Journal of Peace
Research} 46(2): 269--83.
}
\author{
Steven V. Miller
}
