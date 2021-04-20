#' Add Archigos political leader information to dyad-year and state-year data
#'
#' @description \code{add_archigos()} allows you to add some information about leaders to dyad-year
#' or state-year data. The function leans on an abbreviated version of the data, which also comes in this package.
#'
#'
#' @return \code{add_archigos()} takes a dyad-year or state-year data frame and adds a few summary
#' variables based off the leader-level data. These include whether there was a leader transition in the
#' state-year (or first/second state in the dyad-year), whether there was an "irregular" leader transition,
#' the number of leaders in the state-year, the unique leader ID for Jan. 1 of the year, and the unique leader
#' ID for Dec. 31 of the year.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or state-year data frame
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @examples
#'
#' \donttest{
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

add_archigos <- function(data) {

  archigos %>%
    rowwise() %>%
    mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
    unnest(date) %>%
    mutate(year = year(date)) %>%
    filter(year >= 1870) %>%
    arrange(date) %>%
    group_by(.data$ccode, .data$year) %>%
    mutate(jan1leadid = first(.data$leadid),
           dec31leadid = last(.data$leadid),
           leadertransition = ifelse(.data$jan1leadid != .data$dec31leadid, 1, 0),
           n_leaders = n_distinct(.data$leadid),
           irregular = ifelse(.data$leadertransition == 1 & any(.data$exit == "Irregular"), 1, 0)) %>%
    group_by(.data$ccode, .data$year) %>%
    select(.data$ccode, .data$year, .data$leadertransition, .data$irregular, .data$n_leaders, .data$jan1leadid, .data$dec31leadid) %>%
    group_by(.data$ccode, .data$year) %>%
    slice(1) %>% ungroup() -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_archigos() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      hold_this %>%
        rename_at(vars(-year), ~paste0(.,"1")) %>%
        left_join(data, .) %>%
        left_join(., hold_this  %>%
                    rename_at(vars(-year), ~paste0(.,"2"))) -> data

      return(data)

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_archigos() merges on the Correlates of War codes (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      hold_this %>%
        left_join(data, .) -> data

      return(data)

    }

  } else  {
    stop("add_archigos() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}



