#' @importFrom tibble tibble
NULL

#' Correlates of War and Gleditsch-War states, by year
#'
#' This is a complete (I believe) data set on Correlates of War states and Gleditsch-Ward states, a byproduct
#' of a \code{full_join()} between \code{gw_states} and \code{cow_states} that leans largely on the
#' state abbreviation variable
#'
#' @format A data frame with 18656 observations on the following 8 variables.
#' \describe{
#' \item{\code{stateabb}}{the state abbreviation, which was the greatest source of agreement between both data sets}
#' \item{\code{year}}{a numeric vector for the year}
#' \item{\code{gwcode}}{a Gleditsch-Ward state code}
#' \item{\code{ccode}}{a Correlates of War state code}
#' \item{\code{gw_statename}}{the state name as it appears in the Gleditsch-Ward data}
#' \item{\code{cow_statename}}{the state name as it appears in the Correlates of War data}
#' }
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about how these data were
#' created. I'm going to use it for internal stuff. The workflow is going to treat the Correlates of War state system
#' membership codes as more of the "master" codes, for which the user can add Gleditsch-Ward identifiers as they see
#' fit.
#'
"cow_gw_years"
