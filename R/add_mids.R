#' Add Gibler-Miller-Little (GML) Militarized Interstate Dispute (MID) data to dyad-year data frame
#'
#' @description \code{add_mids()} merges in GML's MID data to a dyad-year data frame. The current version
#' of the GML MID data is 2.1.1.
#'
#' @return \code{add_mids()} takes a dyad-year data frame and adds dyad-year dispute information
#' from the GML MID data.
#'
#' @details Dyads are capable of having multiple disputes in a given year, which can create a problem
#' for merging into a complete dyad-year data frame. Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113, MID#0306), as illustrative of the problem.
#' This merging process employs the following rules to whittle down these duplicate dispute-year observations. It
#' first selects on MID onsets, then selecting highest fatality level, then highest hostility level, then
#' the longest estimating minimum dispute duration, and finally, in the event of duplicates still outstanding,
#' selecting the MID that came first. This is how GML present their full directed and non-directed dyad-year data.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param keep an optional parameter, specified as a character vector, passed to the function in a \code{select(one_of(.))} wrapper. This
#' allows the user to discard unwanted columns from the directed dispute data so that the output does not consume
#' too much space in memory. Note: the Correlates of War system codes (\code{ccode1}, \code{ccode2}), the observation year
#' (\code{year}), the presence or absence of an ongoing MID (\code{midongoing}), and the presence or absence of a unique
#' MID onset (\code{midonset}) are *always* returned. It would be foolish and self-defeating to eliminate those observations.
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
#' \dontrun{
#' library(magrittr)
#' cow_ddy %>% add_mids()
#'
#' # keep just the dispute number and Side A/B identifiers
#' cow_ddy %>% add_mids(keep=c("dispnum","sidea1", "sidea2"))
#' }
#'


add_mids <- function(data, keep) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_mids() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    gml_dirdisp %>%
      group_by(.data$ccode1, .data$ccode2, .data$year)  %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      # Remove anything that's not a unique MID onset
      mutate(removeme = ifelse(.data$duplicated == 1 & .data$midonset == 0, 1, 0)) %>%
      filter(.data$removeme != 1) %>%
      select(-.data$removeme) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
      # Keep the highest fatality
      filter(.data$fatality == max(.data$fatality)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      ungroup() %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
      # Keep the highest hostlev
      filter(.data$hostlev == max(.data$hostlev)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      ungroup() %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      # Note: bringing back in the mindur/maxdur...
      ungroup() %>%
      group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
      # Keep the highest mindur
      filter(.data$mindur == max(.data$mindur)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      ungroup() %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated)  %>%
      # Keep the lowest stmon
      filter(.data$stmon == min(.data$stmon)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      ungroup() %>%
      # Now get rid of the mindur/maxdur, and dates variables...
      # select(-styear:-endday, -enddate, -stdate, -mindur, -maxdur) %>%
      group_by(.data$ccode1, .data$ccode2,.data$ year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
      # Just drop something... just in case...
      mutate(seq = seq(1:n())) %>%
      filter(seq == 1) %>%
      # We're done here, mercifully...
      ungroup() %>%
      select(-.data$duplicated, -.data$seq) -> dirdisp

    if (missing(keep)) {
      dirdisp %>% select(everything()) -> dirdisp
    } else {
      dirdisp %>% select(one_of("ccode1", "ccode2", "year", "midonset", "midongoing", keep)) -> dirdisp
    }

    dirdisp %>%
      left_join(data, .) %>%
      mutate_at(vars("midongoing", "midonset"), ~ifelse(is.na(.), 0, .)) -> data

    return(data)

    }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
    stop("add_mids() is only available for dyad-year data.")

  } else  {
    stop("add_mids() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
