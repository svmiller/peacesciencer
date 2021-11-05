#' Whittle Duplicate Conflict-Years by Just Dropping Something ("JDS")
#'
#' @description  \code{whittle_conflicts_jds()} is in a class of
#' do-it-yourself functions for coercing (i.e. "whittling") conflict-year
#' data with cross-sectional units to unique conflict-year data by
#' cross-sectional unit. The inspiration here is clearly the problem
#' of whittling dyadic dispute-year data into true dyad-year data (like
#' in the Gibler-Miller-Little conflict data). This particular
#' function will just drop something, as a kind of nuclear option.
#'
#' @return \code{whittle_conflicts_jds()} takes a dyad-year data frame or
#' leader-dyad-year data frame with a declared conflict attribute type and,
#' grouping by the dyad and year, returns just those observations that
#' have the lowest start month.
#'
#' @details Dyads are capable of having multiple disputes in a given year,
#' which can create a problem for merging into a complete dyad-year
#' data frame. Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113, MID#0306),
#' as illustrative of the problem. The default process in \pkg{peacesciencer}
#' employs several rules to whittle down these duplicate dyad-years for
#' merging into a dyad-year data frame. These are available in
#' \code{add_cow_mids()} and \code{add_gml_mids()}.
#'
#' This really should be the absolute last exclusion rules a researcher uses.
#' It's a "nuclear option", if you will. Assuming you've run other case
#' exclusion rules to isolate onsets and severe disputes, what remains
#' at the end should be duplicates that are functionally equivalent
#' observations. Your data cannot have duplicates, and these remaining
#' observations are basically the same. Therefore, just drop something.
#'
#' \code{wc_jds()} is a simple, less wordy, shortcut for the same function.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with a declared conflict attribute type.
#' @param ... optional, only to make the shortcut work
#'
#' @references
#'
#' Miller, Steven V. 2021. "How {peacesciencer} Coerces Dispute-Year Data into Dyad-Year Data".
#' URL: \url{http://svmiller.com/peacesciencer/articles/coerce-dispute-year-dyad-year.html}
#'
#' @name whittle_conflicts_jds
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' gml_dirdisp %>% whittle_conflicts_onsets() %>% whittle_conflicts_jds()
#'
#' cow_mid_dirdisps %>% whittle_conflicts_onsets() %>% whittle_conflicts_jds()
#'
#'
#' }
#'


whittle_conflicts_jds <- function(data) {


  if(is.null(attributes(data)$ps_conflict_type)) {

    stop("The 'whittle' class of functions in {peacesciencer} only works on conflict data available in the package.")
  }

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "gml") {

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type

    data %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      slice(1) %>%
      ungroup() -> data

    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "cow-mid") {

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type


    data %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      slice(1) %>%
      ungroup() -> data


    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_dyad_year" &&  attributes(data)$ps_conflict_type == "gml") {

    data[ , c('styear', 'stmon', 'settle', 'fatality', 'mindur', 'maxdur', 'hiact', 'hostlev', 'recip', 'outcome')] <- list(NULL)

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type

    data %>%
      left_join(., gml_mid_disps ) -> hold_this

    hold_this %>%
      group_by(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year) %>%
      slice(1) %>%
      ungroup() -> data

    data[ , c('styear', 'stmon', 'settle', 'fatality', 'mindur', 'maxdur', 'hiact', 'hostlev', 'recip', 'outcome')] <- list(NULL)


    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type

  } else {
    stop("whittle_conflicts_jds() doesn't recognize the data supplied to it.")
  }

  return(data)
}


#' @rdname whittle_conflicts_jds
#' @export

wc_jds <- function(...) peacesciencer::whittle_conflicts_jds(...)
