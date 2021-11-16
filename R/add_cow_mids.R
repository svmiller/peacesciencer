#' Add Correlates of War (CoW) Militarized Interstate Dispute (MID) data to dyad-year data frame
#'
#' @description \code{add_cow_mids()} merges in CoW's MID data to a dyad-year data frame.
#' The version of the CoW-MID data in this package is version 5.0.
#'
#' @return \code{add_cow_mids()} takes a dyad-year data frame and adds dyad-year dispute information
#' from the CoW-MID data.
#'
#' @details
#'
#' Dyads are capable of having multiple disputes in a given year, which can
#' create a problem for merging into a complete dyad-year data frame.
#' Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113,
#' MID#0306), as illustrative of the problem. This merging process employs
#' several rules to whittle down these duplicate dyad-years for merging
#' into a dyad-year data frame.
#'
#' The function will also return a message to the user about the
#' case-exclusion rules that went into this process. Users who are
#' interested in implementing their own case-exclusion rules should
#' look up the "whittle" class of functions also provided in this
#' package.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param keep an optional parameter, specified as a character vector, passed to the function in a \code{select(one_of(.))} wrapper. This
#' allows the user to discard unwanted columns from the directed dispute data so that the output does not consume
#' too much space in memory. Note: the Correlates of War system codes (\code{ccode1}, \code{ccode2}), the observation year
#' (\code{year}), the presence or absence of an ongoing MID (\code{cowmidongoing}), and the presence or absence of a unique
#' MID onset (\code{cowmidonset}) are *always* returned. It would be foolish and self-defeating to eliminate those observations.
#' The user is free to keep or discard anything else they see fit.
#'
#' If \code{keep} is not specified in the function, the ensuing output returns everything.
#'
#' @references
#'
#' Palmer, Glenn, and Roseanne W. McManus and Vito D'Orazio and Michael R. Kenwick and Mikaela Karstens
#' and Chase Bloch and Nick Dietrich and Kayla Kahn and Kellan Ritter and Michael J. Soules. 2021.
#' "The MID5 Dataset, 2011–2014: Procedures, coding rules, and description" \emph{Conflict Management and Peace Science}.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_cow_mids()
#'
#' # keep just the dispute number and Side A/B identifiers
#' cow_ddy %>% add_cow_mids(keep=c("dispnum","sidea1", "sidea2"))
#' }
#'


add_cow_mids <- function(data, keep) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_mids() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    if (missing(keep)) {
      cow_mid_ddydisps %>% select(everything()) -> dirdisp
    } else {
      cow_mid_ddydisps %>% select(one_of("ccode1", "ccode2", "year", "cowmidonset", "cowmidongoing", keep)) -> dirdisp
    }

    dirdisp %>%
      left_join(data, .) %>%
      mutate_at(vars("cowmidonset", "cowmidongoing"), ~ifelse(is.na(.) & between(.data$year, 1816, 2014), 0, .)) -> data
    message("add_cow_mids() IMPORTANT MESSAGE: By default, this function whittles dispute-year data into dyad-year data by first selecting on unique onsets. Thereafter, where duplicates remain, it whittles dispute-year data into dyad-year data in the following order: 1) retaining highest `fatality`, 2) retaining highest `hostlev`, 3) retaining highest estimated `mindur`, 4) retaining highest estimated `maxdur`, 5) retaining reciprocated over non-reciprocated observations, 6) retaining the observation with the lowest start month, and, where duplicates still remained (and they don't), 7) forcibly dropping all duplicates for observations that are otherwise very similar.\nSee: http://svmiller.com/peacesciencer/articles/coerce-dispute-year-dyad-year.html")
    return(data)

    }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
    stop("add_cow_mids() is only available for dyad-year data.")

  } else  {
    stop("add_cow_mids() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
