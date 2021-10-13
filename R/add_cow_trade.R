#' Add Correlates of War trade data to a dyad-year or state-year data frame
#'
#' @description \code{add_cow_trade()} allows you to add Correlates of War alliance
#' data to a dyad-year data frame
#'
#' @return \code{add_cow_trade()} takes a dyad-year data frame or state-year data frame and
#' adds information about the volume of trade in that given dyad-year or state-year. For the state-year
#' data, these are minimally the sum of all imports and the sum of all exports. For dyad-year data,
#' this function returns the value of imports in current million USD in the first country from
#' the second country (and vice-versa) along with their "smooth" equivalents.
#'
#' @details For the dyad-year data, there must be some kind of information loss in order to work within the
#' limited space available to this package. This package loads a truncated version of the data in which the trade
#' values are rounded to integers in order to greatly reduce the disk space for this package. I do not think this
#' to be terribly problematic, though I admit I do not like it. If this is a problem for your research question,
#' you may want to consider not using this function for dyad-year data.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame
#'
#' @references
#'
#' Barbieri, Katherine, Omar M. G. Keshk, and Brian Pollins. 2009. "TRADING DATA: Evaluating our Assumptions and Coding Rules."
#' \emph{Conflict Management and Peace Science}. 26(5): 471-491.
#'
#' @examples
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' # The function below works, but depends on running `download_extdata()` beforehand.
#' # cow_ddy %>% add_cow_trade()
#'
#' create_stateyears() %>% add_cow_trade()

add_cow_trade <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_trade() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      if (!file.exists(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer"))) {

        stop("Dyadic CoW trade data is now stored remotely and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem and the dyadic trade data (`cow_trade_ddy`) can be loaded for additional exploration.")

      } else {

        readRDS(system.file("extdata", "cow_trade_ddy.rds", package="peacesciencer")) %>%
          left_join(data, .) -> data

        return(data)

      }

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

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
