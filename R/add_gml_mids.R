#' Add Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) data to dyad-year data frame
#'
#' @description \code{add_gml_mids()} merges in GML's MID data to a dyad-year data frame. The current version
#' of the GML MID data is 2.1.1.
#'
#' @return \code{add_gml_mids()} takes a dyad-year data frame and adds dyad-year dispute information
#' from the GML MID data.
#'
#' @details Dyads are capable of having multiple disputes in a given year, which can create a problem
#' for merging into a complete dyad-year data frame. Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113, MID#0306), as illustrative of the problem.
#' This merging process employs several rules to whittle down these duplicate dyad-years for merging into a dyad-year
#' data frame.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param keep an optional parameter, specified as a character vector, passed to the function in a \code{select(one_of(.))} wrapper. This
#' allows the user to discard unwanted columns from the directed dispute data so that the output does not consume
#' too much space in memory. Note: the Correlates of War system codes (\code{ccode1}, \code{ccode2}), the observation year
#' (\code{year}), the presence or absence of an ongoing MID (\code{gmlmidongoing}), and the presence or absence of a unique
#' MID onset (\code{gmlmidonset}) are *always* returned. It would be foolish and self-defeating to eliminate those observations.
#' The user is free to keep or discard anything else they see fit.
#'
#' If \code{keep} is not specified in the function, the ensuing output returns everything.
#'
#' @references
#'
#' Gibler, Douglas M., Steven V. Miller, and Erin K. Little. 2016. “An Analysis of the Militarized
#' Interstate Dispute (MID) Dataset, 1816-2001.” International Studies Quarterly 60(4): 719-730.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_gml_mids()
#'
#' # keep just the dispute number and Side A/B identifiers
#' cow_ddy %>% add_gml_mids(keep=c("dispnum","sidea1", "sidea2"))
#' }
#'


add_gml_mids <- function(data, keep) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_gml_mids() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      if (missing(keep)) {
        gml_mid_ddydisps %>% select(everything()) -> dirdisp
      } else {
        gml_mid_ddydisps %>% select(one_of("ccode1", "ccode2", "year", "gmlmidonset", "gmlmidongoing", keep)) -> dirdisp
      }

      dirdisp %>%
        left_join(data, .) %>%
        mutate_at(vars("gmlmidonset", "gmlmidongoing"), ~ifelse(is.na(.) & between(.data$year, 1816, 2010), 0, .)) -> data

      return(data)

    }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
    stop("add_gml_mids() is only available for dyad-year data.")

  } else  {
    stop("add_gml_mids() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
