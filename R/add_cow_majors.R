#' Add Correlates of War major power information to a dyad-year or state-year data frame
#'
#' @description \code{add_cow_majors()} allows you to add Correlates of War major power variables
#' to a dyad-year or state-year data frame.
#'
#'
#' @return \code{add_cow_majors()} takes a dyad-year data frame or state-year data frame and adds information
#' about major power status for the given state or dyad in that year. If the data are dyad-year, the function
#' returns two columns for whether the first state (i.e. \code{ccode1}) or the second state (i.e. \code{ccode2}) are major powers
#' in the given year, according to the Correlates of War. 1 = is a major power. 0 = is not a major
#' power. If the data are state-year, the functions returns just one column (\code{cowmaj}) for whether the
#' state was a major power in a given dyad-year.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame.
#'
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership}
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

add_cow_majors <- function(data) {


  cow_majors %>%
    select(.data$ccode, .data$styear, .data$endyear) %>%
    rowwise() %>%
    mutate(year = list(seq(.data$styear, .data$endyear))) %>% unnest(.data$year) %>%
    select(-.data$styear, -.data$endyear) %>%
    mutate(cowmaj = 1) -> major_years

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_majors() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

  data %>% left_join(., major_years, by=c("ccode1"="ccode","year"="year")) %>%
    rename(cowmaj1 = .data$cowmaj) %>%
    left_join(., major_years, by=c("ccode2"="ccode","year"="year")) %>%
    rename(cowmaj2 = .data$cowmaj) %>%
    mutate_at(vars("cowmaj1", "cowmaj2"), ~ifelse(is.na(.), 0, .)) -> data

  return(data)

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_cow_majors() merges on the Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {
    data %>%
      left_join(., major_years) %>%
      mutate(cowmaj = ifelse(is.na(.data$cowmaj), 0, 1)) -> data

    return(data)

    }

  } else  {
      stop("add_cow_majors() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
    }

  return(data)
}
