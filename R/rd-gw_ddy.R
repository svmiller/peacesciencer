#' @importFrom tibble tibble
NULL

#' A directed dyad-year data frame of Gleditsch-Ward state system members
#'
#' This is a complete directed dyad-year data frame of Gleditsch-Ward
#' state system members. I offer it here as a shortcut for various other functions.
#'
#' @format A data frame with 1999558 observations on the following 4 variables.
#' \describe{
#' \item{\code{gwcode1}}{a numeric vector for the Correlates of War state code for the first state}
#' \item{\code{gwcode2}}{a numeric vector for the Correlates of War state code for the second state}
#' \item{\code{year}}{a numeric vector for the year}
#' }
#'
#' @details Data are a quick generation from the \code{create_dyadyears(system="gw")} function in this package.
#'
"gw_ddy"
