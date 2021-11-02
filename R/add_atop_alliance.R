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
#' This function will also work with leader-dyad-years, though users should be careful with leader-level
#' applications of alliance data. Alliance data are primarily communicated yearly, making it possible---even
#' likely---that at least one leader-dyad in a given year is credited with an alliance that was not active in the particular
#' leader-dyad. The ATOP alliance data are not communicated with time measurements more granular than
#' the year, at least for dyad-years. The alliance-level data provided by ATOP do have termination dates, but I am unaware
#' how well these start and termination dates coincide with particular members joining after the fact or exiting early. The alliance
#' phase data appear to communicate that "phases" are understood as beginning/ending when the underlying document is amended in such a
#' way that it affects one of their variable codings, but this may or may not because of a signatory joining after the fact or exiting
#' early. More guidance will be useful going forward, but use these data for leader-level analyses with that in mind.
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

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
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
