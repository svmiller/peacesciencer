#' @importFrom tibble tibble
NULL

#' Correlates of War Major Powers Data (1816-2016)
#'
#' These are the Correlates of War major powers data.
#'
#' @format A data frame with 14 observations on the following 8 variables.
#' \describe{
#' \item{\code{ccode}}{a numeric vector for the Correlates of War country code}
#' \item{\code{styear}}{the start year as a major power}
#' \item{\code{stmonth}}{the start month as a major power}
#' \item{\code{stday}}{the start day as a major power}
#' \item{\code{endyear}}{the end year as a major power}
#' \item{\code{endmonth}}{the end month as a major power}
#' \item{\code{endday}}{the end day as a major power}
#' \item{\code{version}}{a version identifier}
#' }
#'
#' @details Data are provided "as-is" with no additional re-cleaning before inclusion into this data set (beyond eliminating the state abbreviation).
#'
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership}
#'
"cow_majors"
