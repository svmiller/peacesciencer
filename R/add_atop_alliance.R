#' Add Alliance Treaty Obligations and Provisions (ATOP) alliance data to a dyad-year data frame
#'
#' @description \code{add_atop_alliance()} allows you to add Alliance Treaty Obligations and Provisions (ATOP)
#' data to a dyad-year data frame.
#'
#' @return \code{add_atop_alliance()} takes a dyad-year data frame and adds information about
#' the alliance pledge in that given dyad-year from the ATOP data. These include whether there was an alliance
#' with a defense pledge, an offense pledge, neutrality pledge, non-aggression pledge, or pledge for consultation
#' in time of crisis.
#'
#' @details Data are from version 5.0 of the data.
#'
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references
#'
#' Leeds, Brett Ashley, Jeffrey M. Ritter, Sara McLaughlin Mitchell, and Andrew G. Long. 2002.
#' Alliance Treaty Obligations and Provisions, 1815-1944. \emph{International Interactions} 28: 237-60.
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_atop_alliance()
#'

add_atop_alliance <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_atop_alliance() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {
      atop_alliance %>%
        left_join(data, .) %>%
        mutate_at(vars("atop_defense", "atop_offense", "atop_neutral", "atop_nonagg", "atop_consul"), ~ifelse(is.na(.) & year <= 2018, 0, .)) -> data
    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    stop("Right now, there is only support for dyad-year data.")

  } else  {
    stop("add_atop_alliance() requires a data/tibble with attributes$ps_data_type of dyad_year. Try running create_dyadyears() at the start of the pipe.")
  }

  return(data)
}
