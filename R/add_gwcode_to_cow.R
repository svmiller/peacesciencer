#' Add Gleditsch-Ward state system codes to dyad-year or state-year data with Correlates of War state codes.
#'
#' @description \code{add_gwcode_to_cow()} allows you to add estimates of democracy to either dyad-year or state-year data.
#'
#'
#' @return \code{add_gwcode_to_cow()} takes a dyad-year data frame or state-year data frame that already has Correlates of War
#' state system codes and adds their corollary Gleditsch-Ward codes.
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about the underlying data that assists
#' in merging in these codes.
#'
#' The user will invariably need to be careful and ask why they want these data included. The issue here is that both have a different
#' composition and the merging process will not (and cannot) be perfect. We can note that a case like Serbia/Yugoslavia is not too difficult
#' to handle (since "Serbia" never overlaps with "Yugoslavia" in the Gleditsch-Ward data and Correlates of War understands Serbia as the
#' predecessor state, dominant state, and successor state to Yugoslavia). However, there is greater weirdness with a case like Yemen/Yemen
#' Arab Republic. The script will *not* create state-year or dyad-year duplicates for the Correlates of War codes. The size of the original data
#' remain unchanged. However, there will be some year duplicates for various Gleditsch-Ward codes (e.g. Yemen, again). Use with care. You can also use
#' the \code{countrycode} package. Whether you use this function or the \code{countrycode} package, do *not* do this kind of merging without assessing
#' the output.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame.
#'
#'
#' @examples
#'
#' library(magrittr)
#' library(peacesciencer)
#'
#'
#' cow_ddy %>% add_gwcode_to_cow()
#'
#' create_stateyears() %>% add_gwcode_to_cow()
#'
#'
add_gwcode_to_cow <- function(data) {
  # require(dplyr)
  # require(magrittr)

  cow_gw_years %>%
    filter(!is.na(.data$ccode)) %>%
    group_by(.data$ccode, .data$year) %>%
    filter(.data$gwcode == max(.data$gwcode)) %>%
    ungroup() %>%
    select(.data$gwcode, .data$ccode, .data$year) -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    data %>%
      left_join(., hold_this, by=c("ccode1"="ccode","year"="year")) %>%
      rename(gwcode1 = .data$gwcode) %>%
      left_join(., hold_this, by=c("ccode2"="ccode","year"="year")) %>%
      rename(gwcode2 = .data$gwcode) -> data



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    data %>%
      left_join(., hold_this) -> data

  } else  {
    stop("add_gwcode_to_cow() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
