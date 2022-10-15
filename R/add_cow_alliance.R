#' Add Correlates of War alliance data to a data frame
#'
#' @description \code{add_cow_alliance()} allows you to add Correlates of War alliance
#' data to a dyad-year data frame
#'
#' @return \code{add_cow_alliance()} takes a dyad-year data frame and adds information about
#' the alliance pledge in that given dyad-year. These include whether there was an alliance
#' with a defense pledge, neutrality pledge, non-aggression pledge, or pledge for consultation
#' in time of crisis (entente).
#'
#' @details Duplicates in the original directed dyad-year alliance data were pre-processed. Check
#' \code{cow_alliance} in the package's `data-raw` directory on Github for more information.
#'
#' This function will also work with leader-dyad-years, though users should be careful with leader-level
#' applications of alliance data. Alliance data are primarily communicated yearly, making it possible---even
#' likely---that at least one leader-dyad in a given year is credited with an alliance that was not active in the particular
#' leader-dyad. The Correlates of War's alliance data are not communicated with time measurements more granular than
#' the year. Apply these data to leader-level analyses with that in mind.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year or leader-dyad-year data frame (either "directed" or "non-directed")
#'
#' @references
#'
#' Gibler, Douglas M. 2009. \emph{International Military Alliances, 1648-2008}. Congressional Quarterly Press.
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_cow_alliance()
#'

add_cow_alliance <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_alliance() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {
    cow_alliance %>%
      left_join(data, .) %>%
      mutate_at(vars("cow_defense", "cow_neutral", "cow_nonagg", "cow_entente"), ~ifelse(is.na(.) & .data$year <= 2012, 0, .)) -> data

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    stop("Right now, there is only support for dyad-year data.")

  } else  {
    stop("add_cow_alliance() requires a data/tibble with attributes$ps_data_type of dyad_year. Try running create_dyadyears() at the start of the pipe.")
  }

  return(data)
}
