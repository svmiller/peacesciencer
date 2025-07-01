#' Add Archigos political leader information to dyad-year and state-year data
#'
#' @description `add_archigos()` allows you to add some information about
#' leaders to dyad-year or state-year data. The function leans on an abbreviated
#' version of the data, which also comes in this package.
#'
#'
#' @return `add_archigos()` takes a dyad-year or state-year data frame and
#' adds a few summary variables based off the leader-level data. These include
#' whether there was a leader transition in the state-year (or first/second
#' state in the dyad-year), whether there was an "irregular" leader transition,
#' the number of leaders in the state-year, the unique leader ID for Jan. 1 of
#' the year, and the unique leader ID for Dec. 31 of the year.
#'
#' @details The function leans on attributes of the data that are provided by
#' the `create_dyadyears()` or `create_stateyears()` function. Make sure
#' that function (or data created by that function) appear at the top of the
#' proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or
#' state-year data frame
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009.
#' "Introducing Archigos: A Dataset of Political Leaders" *Journal of Peace
#' Research* 46(2): 269--83.
#'
#' @examples
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_archigos()
#'
#' create_stateyears() %>% add_archigos()
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'
#' @export


add_archigos <- function(data) {

  #archigossums <- .archigossummary()
  ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    cow_state_year = .add_archigos_cow_state_year,
    cow_dyad_year = .add_archigos_cow_dyad_year,
    gw_state_year = .add_archigos_gw_state_year,
    gw_dyad_year = .add_archigos_gw_dyad_year
  )

  if (!system_type %in% names(dispatch)) {

    stop("Unsupported combination of ps_system and ps_data_type. System must be 'cow' or 'gw' and the data type must be 'dyad_year' or 'state_year'.")
  }

  data <- dispatch[[system_type]](data, archigossums)

  return(data)

}

# #' @keywords internal
# #' @noRd
#
# .archigossummary <- function() {
#
#   archigos %>%
#     rowwise() %>%
#     mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
#     unnest(date) %>%
#     mutate(year = .pshf_year(date)) %>%
#     filter(.data$year >= 1870) %>%
#     arrange(date) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     mutate(jan1obsid = first(.data$obsid),
#            dec31obsid = last(.data$obsid),
#            leadertransition = ifelse(.data$jan1obsid != .data$dec31obsid, 1, 0),
#            n_leaders = n_distinct(.data$leadid),
#            irregular = ifelse(.data$leadertransition == 1 & any(.data$exit == "Irregular"), 1, 0)) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     select(.data$gwcode, .data$year, .data$leadertransition, .data$irregular, .data$n_leaders, .data$jan1obsid, .data$dec31obsid) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     slice(1) %>% ungroup() -> x
#
#   return(x)
#
# }

#' @keywords internal
#' @noRd

.add_archigos_cow_state_year <- function(data, archigossums) {

  archigossums %>%
    left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode,
                                         .data$year)) -> hold_this

  # Naturally, the different ways of handling Serbia screw things up here.
  # On June 4, 2006, archigos records a leader transition and a state transition,
  # from YUG-2003 to SER-2006. CoW would see this as just a leader transition, not
  # a state transition as well. We can use some rudimentary filter/case_when to
  # fix this and then remove gwcode later. In this case, CoW's Serbia starts the
  # year with YUG-2003 and ends it with SER-2006.

  hold_this %>%
    filter(!(.data$gwcode == 340 & .data$year == 2006)) %>%
    mutate(dec31obsid = case_when(
      .data$gwcode == 345 & .data$year == 2006 ~ "SER-2006",
      TRUE ~ .data$dec31obsid
    )) -> hold_this


  hold_this$gwcode <- NULL

  data %>%
    left_join(., hold_this, by=c("ccode"="ccode", "year"="year")) -> data

}

#' @keywords internal
#' @noRd
.add_archigos_cow_dyad_year <- function(data, archigossums) {

  archigossums %>%
    left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) -> hold_this

  # Naturally, the different ways of handling Serbia screw things up here.
  # On June 4, 2006, archigos records a leader transition and a state transition,
  # from YUG-2003 to SER-2006. CoW would see this as just a leader transition, not
  # a state transition as well. We can use some rudimentary filter/case_when to
  # fix this and then remove gwcode later. In this case, CoW's Serbia starts the
  # year with YUG-2003 and ends it with SER-2006.

  hold_this %>%
    filter(!(.data$gwcode == 340 & .data$year == 2006)) %>%
    mutate(dec31obsid = case_when(
      .data$gwcode == 345 & .data$year == 2006 ~ "SER-2006",
      TRUE ~ .data$dec31obsid
    )) -> hold_this


  hold_this$gwcode <- NULL



  hold_this %>%
    rename_at(vars(-.data$year), ~paste0(.,"1")) %>%
    left_join(data, .,  by=c("ccode1"="ccode1", "year"="year")) %>%
    left_join(., hold_this  %>%
                rename_at(vars(-.data$year), ~paste0(.,"2")),
              by=c("ccode2"="ccode2", "year"="year")) -> data

}





#' @keywords internal
#' @noRd

.add_archigos_gw_state_year <- function(data, archigossums) {

  # well, that's easy...
  data %>%
    left_join(., archigossums) -> data

}

#' @keywords internal
#' @noRd
.add_archigos_gw_dyad_year <- function(data, archigossums) {


  data %>%
    left_join(., archigossums %>%
                rename_at(vars(-.data$year), ~paste0(.,"1"))) %>%
    left_join(., archigossums %>%
                rename_at(vars(-.data$year), ~paste0(.,"2"))) -> data

}









# add_archigos <- function(data) {
#
#   archigos %>%
#     rowwise() %>%
#     mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
#     unnest(date) %>%
#     mutate(year = .pshf_year(date)) %>%
#     filter(.data$year >= 1870) %>%
#     arrange(date) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     mutate(jan1obsid = first(.data$obsid),
#            dec31obsid = last(.data$obsid),
#            leadertransition = ifelse(.data$jan1obsid != .data$dec31obsid, 1, 0),
#            n_leaders = n_distinct(.data$leadid),
#            irregular = ifelse(.data$leadertransition == 1 & any(.data$exit == "Irregular"), 1, 0)) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     select(.data$gwcode, .data$year, .data$leadertransition, .data$irregular, .data$n_leaders, .data$jan1obsid, .data$dec31obsid) %>%
#     group_by(.data$gwcode, .data$year) %>%
#     slice(1) %>% ungroup() -> archigossums
#
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
#
#     if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_system == "cow") {
#
#       archigossums %>%
#         left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) -> hold_this
#
#       # Naturally, the different ways of handling Serbia screw things up here.
#       # On June 4, 2006, archigos records a leader transition and a state transition,
#       # from YUG-2003 to SER-2006. CoW would see this as just a leader transition, not
#       # a state transition as well. We can use some rudimentary filter/case_when to fix this
#       # and then remove gwcode later. In this case, CoW's Serbia starts the year with YUG-2003 and
#       # ends it with SER-2006.
#
#       hold_this %>%
#         filter(!(.data$gwcode == 340 & .data$year == 2006)) %>%
#         mutate(dec31obsid = case_when(
#           .data$gwcode == 345 & .data$year == 2006 ~ "SER-2006",
#           TRUE ~ .data$dec31obsid
#         )) -> hold_this
#
#
#       hold_this$gwcode <- NULL
#
#
#
#       hold_this %>%
#         rename_at(vars(-.data$year), ~paste0(.,"1")) %>%
#         left_join(data, .,  by=c("ccode1"="ccode1", "year"="year")) %>%
#         left_join(., hold_this  %>%
#                     rename_at(vars(-.data$year), ~paste0(.,"2")), by=c("ccode2"="ccode2", "year"="year")) -> data
#
#
#     } else { # Assuming it's GW..
#
#       archigossums %>%
#         rename_at(vars(-.data$year), ~paste0(.,"1")) %>%
#         left_join(data, .) %>%
#         left_join(., hold_this  %>%
#                     rename_at(vars(-.data$year), ~paste0(.,"2"))) -> data
#
#     }
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
#
#     if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_system == "cow") {
#
#       archigossums %>%
#         left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) -> hold_this
#
#       # Naturally, the different ways of handling Serbia screw things up here.
#       # On June 4, 2006, archigos records a leader transition and a state transition,
#       # from YUG-2003 to SER-2006. CoW would see this as just a leader transition, not
#       # a state transition as well. We can use some rudimentary filter/case_when to fix this
#       # and then remove gwcode later. In this case, CoW's Serbia starts the year with YUG-2003 and
#       # ends it with SER-2006.
#
#       hold_this %>%
#         filter(!(.data$gwcode == 340 & .data$year == 2006)) %>%
#         mutate(dec31obsid = case_when(
#           .data$gwcode == 345 & .data$year == 2006 ~ "SER-2006",
#           TRUE ~ .data$dec31obsid
#         )) -> hold_this
#
#
#       hold_this$gwcode <- NULL
#
#       data %>%
#         left_join(., hold_this, by=c("ccode"="ccode", "year"="year")) -> data
#
#
#     } else { # Assuming it's G-W...
#
#       data %>%
#         left_join(., archigossums) -> data
#
#
#       }
#
#
#
#   } else  {
#     stop("add_archigos() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#   }
#
#   return(data)
# }



