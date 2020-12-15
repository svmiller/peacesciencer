#' @importFrom tibble tibble
NULL

#' Correlates of War directed dyad-year alliance data
#'
#' These are version 4.1 of the Correlates of War directed dyad-year alliance data.
#'
#' @format A data frame with 148258 observations on the following 9 variables.
#' \describe{
#' \item{\code{ccode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{ccode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{left_censor}}{a numeric vector that equals 1 if the alliance started before Jan. 1, 1816}
#' \item{\code{right_censor}}{a numeric vector that equals 1 if the alliance was still active after Dec. 31, 2012}
#' \item{\code{defense}}{a numeric vector that equals 1 if the alliance included a defense pledge}
#' \item{\code{neutrality}}{a numeric vector that equals 1 if the alliance included a neutrality pledge}
#' \item{\code{nonaggression}}{a numeric vector that equals 1 if the alliance included a non-aggression pledge}
#' \item{\code{entente}}{a numeric vector that equals 1 if the alliance included a pledge to consult if a crisis occurred}
#' }
#'
#' @details The directed dyad-year alliance data are for alliance initiations, not straight dyad-years, "per se." This suggests
#' the presence of duplicate directed dyad-years. These are processed in various ways in \code{add_cow_alliances()}.
#'
#' @references
#'
#' Gibler, Douglas M. 2009. \emph{International Military Alliances, 1648-2008}. Congressional Quarterly Press.
#'
"cow_alliance"
