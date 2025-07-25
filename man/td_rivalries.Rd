% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{td_rivalries}
\alias{td_rivalries}
\title{Thompson and Dreyer's (2012) Strategic Rivalries, 1494-2010}
\format{
A data frame with 197 observations on the following 10 variables.
\describe{
\item{\code{rivalryno}}{a numeric vector for the rivalry number}
\item{\code{rivalryname}}{a character vector for the rivalry name}
\item{\code{ccode1}}{the Correlates of War state code for the state with the lowest Correlates of War state code in the rivalry}
\item{\code{ccode2}}{the Correlates of War state code for the state with the highest Correlates of War state code in the rivalry}
\item{\code{styear}}{a numeric vector for the start year of the rivalry}
\item{\code{endyear}}{a numeric vector for the end year of the rivalry}
\item{\code{region}}{a character vector for the region of the rivalry, per Thompson and Dreyer (2012)}
\item{\code{type1}}{a character vector for the primary type of the rivalry (spatial, positional, ideological, or interventionary)}
\item{\code{type2}}{a character vector for the secondary type of the rivalry, if applicable (spatial, positional, ideological, or interventionary)}
\item{\code{type3}}{a character vector for the tertiary type of the rivalry, if applicable (spatial, positional, ideological, or interventionary)}
}
}
\usage{
td_rivalries
}
\description{
A simple summary of all strategic (inter-state) rivalries from Thompson and Dreyer (2012).
}
\details{
Information gathered from the appendix of Thompson and Dreyer (2012). Ongoing rivalries are
right-bound at 2010, the date of publication for Thompson and Dreyer's handbook. Users are free to change this if they like. Data are effectively
identical to \code{strategic_rivalries} in \pkg{stevemisc}, but include some behind-the-scenes processing (described in a blog post on
\url{https://svmiller.com}) that is available to see on the project's Github repository. The data object is also renamed to avoid a conflict.
}
\references{
Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
URL: \url{https://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}

Thompson, William R. and David Dreyer. 2012. \emph{Handbook of International Rivalries}. CQ Press.
}
\keyword{datasets}
