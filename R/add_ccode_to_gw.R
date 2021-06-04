#' Add Correlates of War state system codes to dyad-year or state-year data with  Gleditsch-Ward state codes.
#'
#' @description \code{add_cow_to_gwcode()} allows you to match, as well as one can, Correlates of War system membership data
#' with Gleditsch-Ward system data.
#'
#'
#' @return \code{add_cow_to_gwcode()} takes a dyad-year data frame or state-year data frame that already has Gleditsch-Ward
#' state system codes and adds their corollary Correlates of War codes.
#'
#' @details The \code{data-raw} directory on the project's Github contains more information about the underlying data that assists
#' in merging in these codes.
#'
#' The user will invariably need to be careful and ask why they want these data included. The issue here is that both have a different
#' composition and the merging process will not (and cannot) be perfect. We can note that a case like Gran Colombia is not too difficult to handle (i.e.
#' CoW does not have this entity and none of the splinter states conflict with CoW's coding). However, there is greater weirdness with a case like the unification of
#' West Germany and East Germany. Herein, Correlates of War treats the unification as the reappearance of the original Germany whereas
#' Gleditsch-Ward treat the unification as an incorporation of East Germany into West Germany. The script will *not* create state-year or dyad-year duplicates
#' for the Gleditsch-Ward codes. The size of the original data remain unchanged. However, there will be some year duplicates for various
#' Correlates of War codes (prominently Serbia and Yugoslavia in 2006). Use with care. You can also use
#' the \code{countrycode} package. Whether you use this function or the \code{countrycode} package, do *not* do this kind of merging without assessing
#' the output.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame.
#'
#'
#' @examples
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' create_dyadyears(system = "gw") %>% add_cow_to_gwcode()
#'
#' create_stateyears(system = 'gw') %>% add_cow_to_gwcode()
#'
#'
add_ccode_to_gw <- function(data) {

  gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year) -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("gwcode1", "gwcode2") %in% colnames(data))) {

      stop("add_cow_to_gwcode() merges on two Gleditsch-Ward codes (gwcode1, gwcode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      data %>%
        left_join(., hold_this, by=c("gwcode1"="gwcode", "year"="year")) %>%
        rename(ccode1 = .data$ccode) %>%
        left_join(., hold_this, by=c("gwcode2"="gwcode", "year"="year")) %>%
        rename(ccode2 = .data$ccode) -> data

      return(data)

    }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("gwcode") %in% colnames(data))) {

      stop("add_ccode_to_gw() merges on the Gleditsch-Ward code, which your data don't have right now. Make sure to run create_stateyears(system = 'gw') at the top of the pipe.")


    } else {

      data %>%
        left_join(., hold_this) -> data

      return(data)

    }

  } else  {
    stop("add_ccode_to_gw() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}

