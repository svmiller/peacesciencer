#' Add Correlates of War trade data to a data frame
#'
#' @description
#'
#' \code{add_cow_trade()} allows you to add Correlates of War trade data to your
#' (dyad-year, leader-year, leader-dyad-year, state-year) data frame
#'
#' @return
#'
#' \code{add_cow_trade()} takes a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame and adds information about the volume of trade in
#' that given dyad-year or state-year. For the state-year (leader-year) data,
#' these are minimally the sum of all imports and the sum of all exports. For
#' dyad-year (leader-dyad-year) data, this function returns the value of
#' imports in current million USD in the first country from the second country
#' (and vice-versa) along with their "smooth" equivalents.
#'
#' @details
#'
#' For the dyad-year (and leader-dyad-year) data, there must be some kind of
#' information loss in order to work within the limited space available to this
#' package. This package loads a truncated version of the data in which the trade
#' values are rounded to three decimal points in order to greatly reduce the
#' disk space for this package. I do not think this to be terribly problematic,
#' though I admit I do not like it. If this is a problem for your research
#' question, you may want to consider not using this function for dyad-year or
#' leader-dyad-year data.
#'
#' Be mindful that the data are fundamentally state-year or dyad-year and that
#' extensions to leader-level data should be understood as approximations for
#' leaders (leader-dyads) in a given state-year (dyad-year).
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#'
#' @references
#'
#' Barbieri, Katherine, Omar M. G. Keshk, and Brian Pollins. 2009. "TRADING
#' DATA: Evaluating our Assumptions and Coding Rules." *Conflict Management and
#' Peace Science*. 26(5): 471-491.
#'
#' @examples
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' # The function below works, but depends on running `download_extdata()` beforehand.
#' # cow_ddy %>% add_cow_trade()
#'
#' create_stateyears() %>% add_cow_trade()

add_cow_trade <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_trade() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      if (!file.exists(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer"))) {

        stop("Dyadic CoW trade data are now stored remotely and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem and the dyadic trade data (`cow_trade_ddy`) can be loaded for additional exploration.")

      } else {

        readRDS(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer")) %>%
          left_join(data, .) -> data

        return(data)

      }

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_cow_trade() merges on the Correlates of War codes (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    cow_trade_sy %>%
      left_join(data, .) -> data

      return(data)

    }

  } else  {
    stop("add_cow_trade() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
