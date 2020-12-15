#' @importFrom tibble tibble
NULL

#' Correlates of War directed dyad-year alliance data
#'
#' These are version 4.1 of the Correlates of War directed dyad-year alliance data.
#'
#' @format A data frame with 120784 observations on the following 7 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{defense}}{a numeric vector that equals 1 if the alliance included a defense pledge}
#' \item{\code{neutrality}}{a numeric vector that equals 1 if the alliance included a neutrality pledge}
#' \item{\code{nonaggression}}{a numeric vector that equals 1 if the alliance included a non-aggression pledge}
#' \item{\code{entente}}{a numeric vector that equals 1 if the alliance included a pledge to consult if a crisis occurred}
#' }
#'
#' @details The directed dyad-year alliance data are for alliance initiations, not straight dyad-years, "per se." This suggests
#' the presence of duplicate directed dyad-years. For computing ease, given the intended use, I take care of these duplicate
#' dyad-years behind the scenes. Consider the case of the U.S. and Canada in 1958. Therein, there were apparently two separate
#' alliance initiations  that included defense pledges. My behind-the-scenes cleaning process groups by \code{ccode1},
#' \code{ccode2}, and \code{year} and summarizes those alliance pledge variables. I then replace any value greater than 1
#' with 1. This indicates the presence or absence of a defense pledge in a given directed dyad-year.
#'
#' @references
#'
#' Gibler, Douglas M. 2009. \emph{International Military Alliances, 1648-2008}. Congressional Quarterly Press.
#'
"cow_alliance"
