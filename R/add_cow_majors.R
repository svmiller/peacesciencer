#' Add Correlates of War major power information to a data frame
#'
#' @description \code{add_cow_majors()} allows you to add Correlates of War major
#' power variables to a dyad-year, leader-year, leader dyad-year, or state-year
#' data frame.
#'
#'
#' @return \code{add_cow_majors()} takes a data frame and adds information
#' about major power status for the given state or dyad in that year. If the
#' data are dyad-year (or leader dyad-year), the function returns two
#' columns for whether the first state (i.e. \code{ccode1}) or the second
#' state (i.e. \code{ccode2}) are major powers in the given year, according
#' to the Correlates of War. 1 = is a major power. 0 = is not a major
#' power. If the data are state-year (or leader-year), the functions
#' returns just one column (\code{cowmaj}) for whether the
#' state was a major power in a given state-year.
#'
#'
#' @details
#'
#' Be mindful that the data are fundamentally state-year and that extensions to
#' leader-level data should be understood as approximations for leaders in a
#' given state-year.
#'
#' The `mry` argument works on an informal assumption that the composition of
#' the major powers are unchanged since the most recent data update. It simply
#' carries forward the most recent observation from the end of the data and
#' assumes there are no new major powers to note. Perhaps this is one way of
#' thinking about the absence of yearly updates from Correlates of War for its
#' composition data sets (i.e. state system, major powers). If there was a need
#' to update it in light of current events (e.g. the elimination or creation of
#' a new state, or the arrival/elimination of great power status), there would be
#' an immediate update to acknowledge it. The absence of an update means you can
#' just carry forward the most recent observations.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param mry logical, defaults to `TRUE`. If `TRUE`, the data carry forward the
#' identity of the major powers to the most recently concluded calendar year. If
#' `FALSE`, the panel honors the right bound of the data's temporal domain and
#' creates NAs for observations past it.
#'
#' @references
#'
#' Correlates of War Project. 2017. "State System Membership List, v2016."
#' Online, \url{https://correlatesofwar.org/data-sets/state-system-membership/}
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_cow_majors()
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'
#' @export
#'
add_cow_majors <- function(data, mry = TRUE) {

  ps_type <- attr(data, "ps_data_type")

  major_years <- .majyears(mry)

  dispatch <- list(
    state_year = .add_cow_majors_state_year,
    dyad_year = .add_cow_majors_dyad_year,
    leader_year = .add_cow_majors_state_year,
    leader_dyad_year = .add_cow_majors_dyad_year
  )

  if (is.null(ps_type) || !ps_type %in% names(dispatch)) {
    stop("Unexpected or unsupported ps_data_type. Expected dyad_year, leader_dyad_year, state_year, or leader_year.")
  }

  data <- dispatch[[ps_type]](data, major_years, mry)

  return(data)

}

#' @keywords internal
#' @noRd
.majyears <- function(mry = TRUE) {

  if(mry == FALSE) {
    cow_majors %>%
      select(.data$ccode, .data$styear, .data$endyear) %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear))) %>% unnest(.data$year) %>%
      select(-.data$styear, -.data$endyear) %>%
      mutate(cowmaj = 1) -> x

  } else {

    mrcy <- as.numeric(format(Sys.Date(), "%Y")) - 1

    cow_majors %>%
      mutate(endyear = ifelse((.data$endyear == max(.data$endyear) &
                                 .data$endmonth == 12 &
                                 .data$endday == 31), mrcy, .data$endyear)) %>%
      select(.data$ccode, .data$styear, .data$endyear) %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear))) %>%
      unnest(.data$year) %>%
      select(-.data$styear, -.data$endyear) %>%
      mutate(cowmaj = 1) -> x
  }

  return(x)

}

#' @keywords internal
#' @noRd
.add_cow_majors_state_year <- function(data, major_years, mry) {

  if(mry == TRUE) {
    mrcy <- .pshf_year(Sys.Date()) - 1
  } else {
    mrcy <- max(cow_majors$endyear)
  }

  if (!"ccode" %in% colnames(data)) {
    stop("add_cow_majors() merges on the Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
  }

  data %>%
    left_join(major_years, by = c("ccode", "year")) %>%
    mutate(cowmaj = ifelse(is.na(.data$cowmaj) & .data$year <= mrcy, 0, .data$cowmaj))
}

#' @keywords internal
#' @noRd
.add_cow_majors_dyad_year <- function(data, major_years, mry) {

  if(mry == TRUE) {
    mrcy <- .pshf_year(Sys.Date()) - 1
  } else {
    mrcy <- max(cow_majors$endyear)
  }

  if (!all(c("ccode1", "ccode2") %in% colnames(data))) {
    stop("add_cow_majors() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
  }

  data %>%
    left_join(major_years, by = c("ccode1" = "ccode", "year")) %>%
    rename(cowmaj1 = .data$cowmaj) %>%
    left_join(major_years, by = c("ccode2" = "ccode", "year")) %>%
    rename(cowmaj2 = .data$cowmaj) %>%
    mutate(
      cowmaj1 = ifelse(is.na(.data$cowmaj1) & .data$year <= mrcy, 0, .data$cowmaj1),
      cowmaj2 = ifelse(is.na(.data$cowmaj2) & .data$year <= mrcy, 0, .data$cowmaj2)
    )
}












# add_cow_majors <- function(data, mry = TRUE) {
#
# if(mry == FALSE) {
#   cow_majors %>%
#     select(.data$ccode, .data$styear, .data$endyear) %>%
#     rowwise() %>%
#     mutate(year = list(seq(.data$styear, .data$endyear))) %>% unnest(.data$year) %>%
#     select(-.data$styear, -.data$endyear) %>%
#     mutate(cowmaj = 1) -> major_years
# } else {
#
#     mrcy <- as.numeric(format(Sys.Date(), "%Y")) - 1
#
#     cow_majors %>%
#       mutate(endyear = ifelse((.data$endyear == max(.data$endyear) &
#                                 .data$endmonth == 12 &
#                                 .data$endday == 31), mrcy, .data$endyear)) %>%
#       select(.data$ccode, .data$styear, .data$endyear) %>%
#       rowwise() %>%
#       mutate(year = list(seq(.data$styear, .data$endyear))) %>% unnest(.data$year) %>%
#       select(-.data$styear, -.data$endyear) %>%
#       mutate(cowmaj = 1) -> major_years
#   }
#
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_cow_majors() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#   data %>% left_join(., major_years, by=c("ccode1"="ccode","year"="year")) %>%
#     rename(cowmaj1 = .data$cowmaj) %>%
#     left_join(., major_years, by=c("ccode2"="ccode","year"="year")) %>%
#     rename(cowmaj2 = .data$cowmaj) -> hold_this
#
#       if(mry == FALSE) {
#         hold_this %>%
#           mutate_at(vars("cowmaj1", "cowmaj2"), ~ifelse(is.na(.) & .data$year <= 2016, 0, .)) -> data
#       } else {
#         hold_this %>%
#           mutate_at(vars("cowmaj1", "cowmaj2"), ~ifelse(is.na(.) & .data$year <= mrcy, 0, .)) -> data
#       }
#
#   return(data)
#
#     }
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     if (!all(i <- c("ccode") %in% colnames(data))) {
#
#       stop("add_cow_majors() merges on the Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#     data %>%
#       left_join(., major_years) -> hold_this
#
#       if(mry == FALSE) {
#         hold_this %>%
#           mutate(cowmaj = ifelse(is.na(.data$cowmaj)  &
#                                    .data$year <= 2016, 0, .data$cowmaj)) -> data
#       } else {
#         hold_this %>%
#           mutate(cowmaj = ifelse(is.na(.data$cowmaj)  &
#                                    .data$year <= mrcy, 0, .data$cowmaj)) -> data
#       }
#
#     return(data)
#
#     }
#
#   } else  {
#       stop("add_cow_majors() requires a data/tibble with attributes$ps_data_type of state_year, leader_year, or dyad_year. Try running create_dyadyears(), create_leaderyears(), or create_stateyears() at the start of the pipe.")
#     }
#
#   return(data)
# }
