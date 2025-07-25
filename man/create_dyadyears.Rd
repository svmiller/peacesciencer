% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_dyadyears.R
\name{create_dyadyears}
\alias{create_dyadyears}
\title{Create dyad-years from state system membership data}
\usage{
create_dyadyears(system = "cow", mry = TRUE, directed = TRUE, subset_years)
}
\arguments{
\item{system}{a character specifying whether the user wants Correlates of War
state-years ("cow") or Gleditsch-Ward ("gw") state-years. Correlates of War
is the default.}

\item{mry}{optional, defaults to TRUE. If TRUE, the function extends the
script beyond the most recent system membership updates to include
observation to the most recently concluded calendar year. For example, the
Gleditsch-Ward data extend to the end of 2020. When \code{mry == TRUE}, the
function returns more recent years (e.g. 2018, 2019) under the assumption
that states alive at the end of 2016 or 2020 are still alive today. Use with
some care.}

\item{directed}{optional, defaults to TRUE. If TRUE, the function returns
so-called "directed" dyad-year data. In directed dyad-year data,
France-Germany (220-255) and Germany-France (255-220) are observationally
different. If FALSE, the function returns non-directed data. In non-directed
data, France-Germany and Germany-France in the same year are the same
observation. The standard here is to drop cases where the country code for
the second observation is less than the country code for the first
observation.}

\item{subset_years}{and optional character vector for subsetting the years
returned to just some temporal domain of interest to the user. For example,
\code{c(1816:1820)} would subset the data to just all dyad-years in 1816, 1817,
1818, 1819, and 1820. Be advised that it's easiest to subset the data after
the full universe of dyad-year data have been created. This means you could,
if you choose, effectively overwrite \code{mry = TRUE} with this argument since
the \code{mry} argument is applied at the expansion of the state system data,
which occurs at the start of the function.}
}
\value{
\code{create_dyadyears()} takes state system membership data provided by
either Correlates of War or Gleditsch-Ward and returns a dyad-year data
frame with one observation for each dyad-year.
}
\description{
\code{create_dyadyears()} allows you to dyad-year data from either the
Correlates of War (CoW) state system membership data or the Gleditsch-Ward
(gw) system membership data. The function leans on state system data
available in \pkg{isard}.
}
\details{
The function leans on data made available in the \pkg{isard} package.

Underneath the hood, the function removes dyads that existed in the same year,
but not on any given day in the same year. For example, Suriname enters the
Correlates of War state system on Nov. 25, 1975, but the Republic of Vietnam
was eliminated from the state system on April 30 of the same year.

Dyad-year data for the Gleditsch-Ward system will also include dyadic
indicators communicating whether the first state or second state is a
microstate. You may not want these and you can always remove them after the
fact.
}
\examples{
\donttest{
# CoW is default, will include years beyond 2016 (most recent CoW update)
create_dyadyears()

# Gleditsch-Ward, include most recent years
create_dyadyears(system="gw")

# Gleditsch-Ward, don't include most recent years
create_dyadyears(system="gw", mry=FALSE)

# Gleditsch-Ward, don't include most recent years, directed = FALSE
create_dyadyears(system="gw", mry=FALSE, directed = FALSE)
}

}
\references{
Miller, Steven V. 2019. ``Create Country-Year and (Non)-Directed Dyad-Year
Data With Just a Few Lines in R''
\url{https://svmiller.com/blog/2019/01/create-country-year-dyad-year-from-country-data/}

Miller, Steven V. 2025. \pkg{isard}: Overflow Data for Quantitative Peace
Science Research. \url{https://CRAN.R-project.org/package=isard}
}
\author{
Steven V. Miller
}
