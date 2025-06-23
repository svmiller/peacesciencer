#' Add Gleditsch-Ward state system codes to your data with Correlates of War state codes.
#'
#' @description \code{add_gwcode_to_cow()} allows you to match, as well as one can, Gleditsch-Ward system membership data
#' with Correlates of War state system membership data.
#'
#'
#' @return \code{add_gwcode_to_cow()} takes a (dyad-year, leader-year, leader-dyad-year, state-year)
#' data frame that already has Correlates of War
#' state system codes and adds their corollary Gleditsch-Ward codes.
#'
#' @details
#'
#' The \code{data-raw} directory on the project's Github contains more
#' information about the underlying data that assists in merging in these
#' codes.
#'
#' The user will invariably need to be careful and ask why they want
#' these data included. The issue here is that both have a different
#' composition and the merging process will not (and cannot) be perfect.
#' We can note that a case like Serbia/Yugoslavia is not too difficult
#' to handle (since "Serbia" never overlaps with "Yugoslavia" in the
#' Gleditsch-Ward data and Correlates of War understands Serbia as the
#' predecessor state, dominant state, and successor state to Yugoslavia).
#' However, there is greater weirdness with a case like Yemen/Yemen
#' Arab Republic. The script will *not* create state-year or dyad-year
#' duplicates for the Correlates of War codes. The size of the original data
#' remain unchanged. However, there will be some year duplicates for various
#' Gleditsch-Ward codes (e.g. Yemen, again). Use with care. You can also use
#' the \pkg{countrycode} package. Whether you use this function or the
#' \pkg{countrycode} package, do *not* do this kind of merging without
#' assessing the output.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#'
#'
#' @examples
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_gwcode_to_cow()
#'
#' create_stateyears() %>% add_gwcode_to_cow()
#'
#'
add_gwcode_to_cow <- function(data) {

  if (any(i <- c("gwcode1", "gwcode2", "gwcode") %in% colnames(data))) {

    stop("Your data already appear to have Gleditsch-Ward state codes in it.")

  }

  if (length(attributes(data)$ps_system) == 0 | attributes(data)$ps_system != "cow") {

    warning("The state system data here do not appear to be Correlates of War, or at least not declared as such. The function will still run, but you may want to inspect the output.")

  }

  # state-year panel; CoW is master and we want G-W codes. ----

  syp <- isard::cw_gw_panel

  syp %>% select(.data$ccode, .data$gwcode, .data$year) -> hold_this

  # isard::cw_gw_panel %>%
  #   filter(!is.na(.data$ccode)) %>%
  #   group_by(.data$ccode, .data$year) %>%
  #   filter(.data$gwcode == max(.data$gwcode)) %>%
  #   ungroup() %>%
  #   select(.data$gwcode, .data$ccode, .data$year) -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_gwcode_to_cow() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    data %>%
      left_join(., hold_this, by=c("ccode1"="ccode","year"="year")) %>%
      rename(gwcode1 = .data$gwcode) %>%
      left_join(., hold_this, by=c("ccode2"="ccode","year"="year")) %>%
      rename(gwcode2 = .data$gwcode) -> data

    return(data)

  }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_gwcode_to_cow() merges on the Correlates of War code, which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    data %>%
      left_join(., hold_this) -> data

      return(data)

    }

  } else  {
    stop("add_gwcode_to_cow() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
