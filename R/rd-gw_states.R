#' @importFrom tibble tibble
NULL

#' Gleditsch-Ward (Independent States) System Membership Data (1816-2017)
#'
#' These are the independent states in Gleditsch and Ward's data.
#'
#' @format A data frame with 216 observations on the following 5 variables.
#' \describe{
#' \item{\code{gwcode}}{a numeric vector for the Gleditsch-Ward country code}
#' \item{\code{stateabb}}{a character vector for state abbreviation}
#' \item{\code{statename}}{a character vector for the state name}
#' \item{\code{startdate}}{the start date in the data}
#' \item{\code{enddate}}{the end date in the data}
#' }
#'
#' @details Data originally provided by Gleditsch with no column names. Column names were added before some light re-cleaning in order
#' to generate these data.
#'
#' @references \url{http://ksgleditsch.com/data-4.html}
#'
"gw_states"
