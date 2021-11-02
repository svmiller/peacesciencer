#' Add Correlates of War state system codes to your data with Gleditsch-Ward state codes.
#'
#' @description \code{add_ccode_to_gw()} allows you to match, as well as one can, Correlates of War system membership data
#' with Gleditsch-Ward system data.
#'
#'
#' @return \code{add_ccode_to_gw()} takes a (dyad-year, leader-year, leader-dyad-year, state-year) data frame that already has Gleditsch-Ward
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
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#'
#'
#' @examples
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' create_dyadyears(system = "gw") %>% add_ccode_to_gw()
#'
#' create_stateyears(system = 'gw') %>% add_ccode_to_gw()
#' }
#'
add_ccode_to_gw <- function(data) {

  if (any(i <- c("ccode1", "ccode2", "ccode") %in% colnames(data))) {

    stop("Your data already appear to have Correlates of War state codes in it.")

  }

  if (length(attributes(data)$ps_system) == 0 | attributes(data)$ps_system != "gw") {
    warning("The state system data here do not appear to be Gleditsch-Ward, or at least not declared as such. The function will still run, but you may want to inspect the output.")

  }

  gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year) -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

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



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

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

