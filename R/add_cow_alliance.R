#' Add Correlates of War alliance data to a dyad-year data frame
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
#' \code{cow_alliance} for more information.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references
#'
#' Gibler, Douglas M. 2009. \emph{International Military Alliances, 1648-2008}. Congressional Quarterly Press.
#'
#' @examples
#'
#' \dontrun{
#' library(magrittr)
#' cow_ddy %>% add_cow_alliance()
#' }

add_cow_alliance <- function(data) {
  # require(dplyr)
  # require(magrittr)

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
    cow_alliance %>%
      left_join(data, .) %>%
      mutate_at(vars("defense", "neutrality", "nonaggression", "entente"), ~ifelse(is.na(.), 0, .)) -> data


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    stop("Right now, there is only support for dyad-year data.")

  } else  {
    stop("add_something() requires a data/tibble with attributes$ps_data_type of dyad_year. Try running create_dyadyears() at the start of the pipe.")
  }

  return(data)
}
