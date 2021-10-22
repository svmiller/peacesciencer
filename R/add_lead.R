#' Add (Select) Leader Experience and Attribute Descriptions (LEAD) Data to Leader-Year Data
#'
#' @description \code{add_lead()} allows you to add some data recorded in the LEAD data to your leader-year data.
#'
#' @return \code{add_lead()} takes a leader-year data frame and adds some data recorded in the LEAD data to it.
#'
#' @author Steven V. Miller
#'
#' @param data a leader-year data frame
#' @param keep an optional parameter, specified as a character vector, about what leader attributes
#' the user wants to return from this function. If \code{keep} is not specified, everything from the
#' \code{LEAD} data in this package is returned. Otherwise, the function subsets the \code{LEAD}
#' data to just what the user wants.
#'
#'
#' @references
#'
#' Ellis, Carli Mortenson, Michael C. Horowitz, and Allan C. Stam. 2015. "Introducing the
#' LEAD Data Set." \emph{International Interactions} 41(4): 718--741.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' create_leaderyears() %>% add_lead()
#'
#' create_leaderyears() %>% add_lead(keep = c("yrsexper"))
#' }
#'

add_lead <- function(data, keep) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_year") {

    if (!missing(keep)) {
      hold_this <- subset(LEAD, select = c("obsid", keep))
    } else {
      hold_this <- LEAD
    }

    data %>%
      left_join(., hold_this) -> data


  }  else  {
    stop("add_lead() only works with leader-year data generated in {peacesciencer}. This might change in future updates.")
  }

  return(data)
}
