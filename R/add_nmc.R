#' Add Correlates of War National Military Capabilities Data
#'
#' @description
#'
#' \code{add_nmc()} allows you to add the Correlates of War National Material
#' Capabilities data to your data.
#'
#' @return
#'
#' \code{add_nmc()} takes a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame and adds information about the national material
#' capabilities for the state or two states in the dyad in a given year. If the
#' data are dyad-year (or leader-dyad-year), the function adds 12 total columns
#' for the first state (i.e. \code{ccode1}) and the second state (i.e.
#' \code{ccode2}) for all estimates of national military capabilities provided
#' by the Correlates of War project. If the data are state-year (or leader-year),
#' the function returns six additional columns to the original data that contain
#' that same information for a given state in a given year.
#'
#' @details
#'
#' Be mindful that the data are fundamentally state-year and that extensions to
#' leader-level data should be understood as approximations for leaders in a
#' given state-year.
#'
#' The `keep` argument must include one or more of the capabilities estimates
#' included in `cow_nmc`. Otherwise, it will return an error that it cannot
#' subset columns that do not exist.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param keep an optional parameter, specified as a character vector, about
#' what capability estimates the user wants to return from this function. If not
#' specified, everything from the underlying capabilities data is returned.
#'
#' @references
#'
#' Singer, J. David, Stuart Bremer, and John Stuckey. (1972).
#' "Capability Distribution, Uncertainty, and Major Power War, 1820-1965." in
#' Bruce Russett (ed) *Peace, War, and Numbers*, Beverly Hills: Sage, 19-48.
#'
#' Singer, J. David. 1987. "Reconstructing the Correlates of War Dataset on
#' Material Capabilities of States, 1816-1985."
#' *International Interactions* 14(1): 115-32.
#'
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_nmc()
#'
#' create_stateyears() %>% add_nmc()
#'
#'

add_nmc <- function(data, keep) {


  ps_type <- attr(data, "ps_data_type")

  #system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    state_year = .add_nmc_state_year,
    leader_year = .add_nmc_state_year,
    dyad_year = .add_nmc_dyad_year,
    leader_dyad_year = .add_nmc_dyad_year
  )

  if (!ps_type %in% names(dispatch)) {

    stop("Unsupported ps_data_type. Data type must be 'dyad_year', `leader_dyad_year`, `leader_year`, or 'state_year'.")

  }

  data <- dispatch[[ps_type]](data, keep)

  return(data)

}




#' @keywords internal
#' @noRd
.add_nmc_state_year  <- function(data, keep) {

  if (!missing(keep)) {
    hold_this <- subset(cow_nmc, select = c("ccode", "year", keep))
  } else {
    hold_this <- cow_nmc
  }

  if (!all(i <- c("ccode") %in% colnames(data))) {

    stop("add_nmc() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


  } else {

    data %>%
      left_join(., hold_this) -> data

    return(data)

  }

}


#' @keywords internal
#' @noRd
.add_nmc_dyad_year <- function(data, keep) {

  if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

    stop("add_nmc() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


  }


  if (!missing(keep)) {
    hold_this <- subset(cow_nmc, select = c("ccode", "year", keep))


    hold_this %>%
      rename_with(~paste0(.x, "1", recycle0 = TRUE), keep) %>%
      left_join(data, ., by=c("ccode1"="ccode",
                              "year"="year")) %>%
      left_join(.,   hold_this %>%
                  rename_with(~paste0(.x, "2", recycle0 = TRUE), keep),
                by=c("ccode2"="ccode", "year"="year")) -> data

  } else {

    hold_this <- cow_nmc

    data %>% left_join(., hold_this, by=c("ccode1"="ccode","year"="year")) %>%
      rename(milex1 = .data$milex,
             milper1 = .data$milper,
             irst1 = .data$irst,
             pec1 = .data$pec,
             tpop1 = .data$tpop,
             upop1 = .data$upop,
             cinc1 = .data$cinc) %>%
      left_join(., hold_this, by=c("ccode2"="ccode","year"="year")) %>%
      rename(milex2 = .data$milex,
             milper2 = .data$milper,
             irst2 = .data$irst,
             pec2 = .data$pec,
             tpop2 = .data$tpop,
             upop2 = .data$upop,
             cinc2 = .data$cinc) -> data
  }


}





















# add_nmc <- function(data) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_nmc() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#     data %>% left_join(., cow_nmc, by=c("ccode1"="ccode","year"="year")) %>%
#       rename(milex1 = .data$milex,
#              milper1 = .data$milper,
#              irst1 = .data$irst,
#              pec1 = .data$pec,
#              tpop1 = .data$tpop,
#              upop1 = .data$upop,
#              cinc1 = .data$cinc) %>%
#       left_join(., cow_nmc, by=c("ccode2"="ccode","year"="year")) %>%
#       rename(milex2 = .data$milex,
#              milper2 = .data$milper,
#              irst2 = .data$irst,
#              pec2 = .data$pec,
#              tpop2 = .data$tpop,
#              upop2 = .data$upop,
#              cinc2 = .data$cinc) -> data
#
#       return(data)
#
#     }
#
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     if (!all(i <- c("ccode") %in% colnames(data))) {
#
#       stop("add_nmc() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#     data %>%
#       left_join(., cow_nmc) -> data
#
#       return(data)
#
#     }
#
#   } else  {
#     stop("add_nmc() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#   }
#
#
#
#   return(data)
# }


