#' Add Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) data to dyad-year or state-year data frame
#'
#' @description \code{add_gml_mids()} merges in GML's MID data to a dyad-year or state-year data frame. The current version
#' of the GML MID data is 2.2.1.
#'
#' @return \code{add_gml_mids()} takes a dyad-year or state-year data frame and adds dyad-year dispute information
#' from the GML MID data. If the data are dyad-year, the return is a laundry list of information about onsets, ongoing conflicts,
#' and assorted participant- and dispute-level summaries. If the data are state-year, the function returns information about ongoing
#' disputes (and onsets) and whether there were any ongoing disputes (and onsets) the state initiated. A character string of dispute
#' numbers active in the observation year is returned too.
#'
#' @details Dyads are capable of having multiple disputes in a given year, which can create a problem
#' for merging into a complete dyad-year data frame. Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113, MID#0306), as illustrative of the problem.
#' This merging process employs several rules to whittle down these duplicate dyad-years for merging into a dyad-year
#' data frame.
#'
#' Determining "initiation" for state-year summaries of inter-state disputes since there is an implied directionality of "initiation."
#' In about half of all cases, this is straightforward. You can use the participant summaries and determine that if the dispute
#' was bilateral and the dispute did not escalate beyond an attack, the state on Side A initiated the dispute. For multilateral MIDs, these
#' conditions still hold at least for originators. However, there is *considerable* difficulty for cases where 1) participant-level summaries
#' suggested actions at the level of clash or higher, 2) the participant was a joiner and not an originator. The effort required to
#' flesh this out is enormous, and perhaps forthcoming in a future update. For now, the simple determination is all states on Side A that
#' were originators are all initiators, even though there are conceivable cases where, for example, a participant on Side B initiated
#' a course of action as a joiner (e.g. the Sudetenland crisis comes to mind here). Everyone else is not an originator.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param keep an optional parameter, specified as a character vector, applicable to just the dyad-year data, and
#' passed to the function in a \code{select(one_of(.))} wrapper. This
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

      message("add_gml_mids() IMPORTANT MESSAGE: By default, this function whittles dispute-year data into dyad-year data by first selecting on unique onsets. Thereafter, where duplicates remain, it whittles dispute-year data into dyad-year data in the following order: 1) retaining highest `fatality`, 2) retaining highest `hostlev`, 3) retaining highest estimated `mindur`, 4) retaining reciprocated over non-reciprocated observations, 5) retaining the observation with the lowest start month, and, where duplicates still remained (and they don't), 6) forcibly dropping all duplicates for observations that are otherwise very similar.\nSee: http://svmiller.com/peacesciencer/articles/coerce-dispute-year-dyad-year.html")
      return(data)

    }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    gml_part %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear)),
             gmlmidonset = list(ifelse(year == min(year), 1, 0))) %>%
      unnest(c(.data$year, .data$gmlmidonset)) %>%
      mutate(gmlmidongoing = 1) -> hold_this

    hold_this %>%
      mutate(gmlmidongoing_init = ifelse(gmlmidongoing == 1 & sidea == 1 & orig == 1, 1, 0),
             gmlmidonset_init = ifelse(gmlmidonset == 1 & gmlmidongoing_init == 1, 1, 0)) %>%
      select(dispnum:ccode, year, gmlmidonset:ncol(.)) %>%
      group_by(ccode, year) %>%
      summarize(gmlmidongoing = sum(gmlmidongoing),
                gmlmidonset = sum(gmlmidonset),
                gmlmidongoing_init = sum(gmlmidongoing_init),
                gmlmidonset_init = sum(gmlmidonset_init),
                gmlmidongoing_dispnums = paste0(.data$dispnum, collapse = "; ")) %>%
      mutate_at(vars(c(.data$gmlmidongoing, .data$gmlmidonset, .data$gmlmidongoing_init, .data$gmlmidonset_init)), ~ifelse(. >= 1, 1, 0)) %>%
      ungroup() -> hold_this

    data %>%
      left_join(., hold_this) -> data

    data %>%
      mutate_at(vars(c(.data$gmlmidongoing, .data$gmlmidonset, .data$gmlmidongoing_init, .data$gmlmidonset_init)), ~ifelse(is.na(.), 0, .)) -> data

  } else  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_year") {

    print("It's coming. Trust me.")

  } else {
    stop("add_gml_mids() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
