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
#' limited space available to this package. This package loads a truncated version of the data
#' from my website.
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
#'
#' \dontrun{
#' library(magrittr)
#' cow_ddy %>% add_cow_trade()
#' }

add_cow_trade <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    cow_trade_ddy <- readRDS(url("http://svmiller.com/R/peacesciencer/cow_trade_ddy.rds"))

    cow_trade_ddy %>%
      left_join(data, .) -> data

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    cow_trade_sy %>%
      left_join(data, .) -> data

  } else  {
    stop("add_cow_trade() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
