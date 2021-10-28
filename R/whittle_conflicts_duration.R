#' Whittle Duplicate Conflict-Years by Conflict Duration
#'
#' @description  \code{whittle_conflicts_duration()} is in a class of do-it-yourself functions for coercing (i.e. "whittling") conflict-year
#' data with cross-sectional units to unique conflict-year data by cross-sectional unit. The inspiration here is clearly the problem
#' of whittling dyadic dispute-year data into true dyad-year data (like in the Gibler-Miller-Little conflict data). This particular
#' function will keep the observations with the highest estimated duration.
#'
#' @return \code{whittle_conflicts_duration()} takes a dyad-year data frame or leader-dyad-year data frame  with a declared conflict attribute type and, grouping by the
#' dyad and year, returns just those observations that have the highest observed dispute-level fatality.
#' This will not eliminate all duplicates, far from it, but it's a sensible cut later into the procedure (after whittling onsets in
#' \code{whittle_conflicts_onsets(), and maybe some other things} the extent to which dispute-level duration
#' is a heuristic for dispute-level severity/importance.
#'
#' @details Dyads are capable of having multiple disputes in a given year, which can create a problem
#' for merging into a complete dyad-year data frame. Consider the case of France and Italy in 1860, which
#' had three separate dispute onsets that year (MID#0112, MID#0113, MID#0306), as illustrative of the problem.
#' The default process in \pkg{peacesciencer} employs several rules to whittle down these duplicate dyad-years for
#' merging into a dyad-year data frame. These are available in \code{add_cow_mids()} and \code{add_gml_mids()}.
#'
#' Some conflicts can be of an unknown length and often come with estimates of a minimum duration
#' and a maximum duration. This will concern the \code{durtype} parameter in this function. In many/most conflicts,
#' certainly thinking of the inter-state dispute data, dates are known with precision (to the day) and the
#' estimate of minimum conflict duration is equal to the estimate of maximum conflict duration. For some conflicts,
#' the estimates will vary. This does importantly imply that using this particular whittle function with the
#' default (\code{mindur}) will produce different results than using this particular whittle function and asking
#' to retain the highest maximum duration (\code{maxdur}). Use the function with that in mind.
#'
#' \code{wc_duration()} is a simple, less wordy, shortcut for the same function.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with a declared conflict attribute type.
#' @param durtype a duration on which to filter/whittle the data. Options include \code{"mindur"} or  \code{"maxdur"}. The default is  \code{"mindur"}.
#' @param ... optional, only to make the shortcut work
#'
#' @references
#'
#' Miller, Steven V. 2021. "How {peacesciencer} Coerces Dispute-Year Data into Dyad-Year Data".
#' URL: \url{http://svmiller.com/peacesciencer/articles/coerce-dispute-year-dyad-year.html}
#'
#' @name whittle_conflicts_duration
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' gml_dirdisp %>% whittle_conflicts_onsets() %>% whittle_conflicts_duration()
#'
#' cow_mid_dirdisps %>% whittle_conflicts_onsets() %>% whittle_conflicts_duration()
#'
#'
#' }
#'


whittle_conflicts_duration <- function(data, durtype = "mindur") {

  if(!(durtype %in% c("mindur", "maxdur"))) {

    stop("The `durtype` parameter must be either 'mindur' or 'maxdur'. It defaults to 'mindur' in the absence of a user-supplied override that it recognizes.")
  }

  if(is.null(attributes(data)$ps_conflict_type)) {

    stop("The 'whittle' class of functions in {peacesciencer} only works on conflict data available in the package.")
  }

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "gml") {

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type

    data %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) -> data

    if (durtype == "mindur") {

      data %>%
        group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
        # keep highest duration
      filter(.data$mindur == max(.data$mindur)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      # practice safe group_by()
      ungroup() %>%
      select(-.data$duplicated) -> data

    } else if (durtype == "maxdur") {

      data %>%
        group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
        # keep highest duration
        filter(.data$maxdur == max(.data$maxdur)) %>%
        arrange(.data$ccode1, .data$ccode2, .data$year) %>%
        # practice safe group_by()
        ungroup() %>%
        select(-.data$duplicated) -> data
    }

    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "cow-mid") {

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type


    data %>%
      left_join(., cow_mid_disps %>% select(.data$dispnum, .data$mindur, .data$maxdur)) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) -> data

    if (durtype == "mindur") {

      data %>%
        group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
        # keep highest duration
        filter(.data$mindur == max(.data$mindur)) %>%
        arrange(.data$ccode1, .data$ccode2, .data$year) %>%
        # practice safe group_by()
        ungroup() %>%
        select(-.data$duplicated) -> data

    } else if (durtype == "maxdur") {

      data %>%
        group_by(.data$ccode1, .data$ccode2, .data$year, .data$duplicated) %>%
        # keep highest duration
        filter(.data$maxdur == max(.data$maxdur)) %>%
        arrange(.data$ccode1, .data$ccode2, .data$year) %>%
        # practice safe group_by()
        ungroup() %>%
        select(-.data$duplicated) -> data
    }


    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type



  } else if(length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_dyad_year" &&  attributes(data)$ps_conflict_type == "gml") {

    data[ , c('styear', 'stmon', 'settle', 'fatality', 'mindur', 'maxdur', 'hiact', 'hostlev', 'recip', 'outcome')] <- list(NULL)

    attr_ps_data_type <- attributes(data)$ps_data_type
    attr_ps_system <- attributes(data)$ps_system
    attr_ps_conflict_type <- attributes(data)$ps_conflict_type

    data %>%
      left_join(., gml_mid_disps ) %>%
      arrange(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year) %>%
      group_by(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) -> hold_this

    if (durtype == "mindur") {

      hold_this %>%
        group_by(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year, .data$duplicated) %>%
        # keep highest duration
        filter(.data$mindur == max(.data$mindur)) %>%
        arrange(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year) %>%
        # practice safe group_by()
        ungroup() %>%
        select(-.data$duplicated) -> data

    } else if (durtype == "maxdur") {

      hold_this %>%
        group_by(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year, .data$duplicated) %>%
        # keep highest duration
        filter(.data$maxdur == max(.data$maxdur)) %>%
        arrange(.data$ccode1, .data$obsid1, .data$ccode2, .data$obsid2, .data$year) %>%
        # practice safe group_by()
        ungroup() %>%
        select(-.data$duplicated) -> data
    }

    attr(data, "ps_data_type") <- attr_ps_data_type
    attr(data, "ps_system") <-  attr_ps_system
    attr(data, "ps_conflict_type") <-  attr_ps_conflict_type



  } else {
    stop("whittle_conflicts_duration() doesn't recognize the data supplied to it.")
  }

  return(data)
}


#' @rdname whittle_conflicts_duration
#' @export

wc_duration <- function(...) peacesciencer::whittle_conflicts_duration(...)
