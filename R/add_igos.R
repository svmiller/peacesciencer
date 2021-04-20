#' Add Correlates of War international governmental organizations (IGOs) data to dyad-year or state-year data.
#'
#' @description \code{add_igos()} allows you to add information from the Correlates oF War International
#' Governmental Organizations data to dyad-year or state-year data, matching on Correlates of War system codes.
#'
#'
#' @return \code{add_igos()} takes a dyad-year data frame or state-year data frame and adds information available from
#' the Correlates of War International Governmental Organizations data. If the data are dyad-year, the function returns
#' the original data with just one additional column for the total number of mutual IGOs for which both members of the dyad
#' are full members. If the data are state-year, the function returns the original data with four additional columns. These are
#' the number oF IGOs for which the state is a full member, the number of IGOs for which the state is an associate member, the
#' number of IGOs for which the state is an observer, and the number of IGOs for which the state is involved in any way (i.e. the
#' sum of the other three columns).
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame.
#'
#' @references
#'
#' Pevehouse, Jon C.W., Timothy Nordstron, Roseanne W McManus, Anne Spencer Jamison, “Tracking Organizations in the World: The Correlates of War IGO Version 3.0 datasets”, Journal of Peace Research 57(3): 492-503.
#'
#' Wallace, Michael, and J. David Singer. 1970. "International Governmental Organization in the Global System, 1815-1964." International Organization 24: 239-87.
#'
#' @examples
#'
#' \donttest{
#'
#' cow_ddy %>% add_igos()
#'
#' create_stateyears() %>% add_igos()
#' }
#'

add_igos <- function(data) {
  # The earliest missing is 1990, so we're going to treat these as just missing or unavailable.
  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_igos() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    cow_igo_ndy %>%
      rename(ccode1 = .data$ccode2,
             ccode2 = .data$ccode1) %>%
      bind_rows(cow_igo_ndy, .) %>%
      left_join(data, .) -> data

      return(data)

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_igos() merges on the Correlates of War code, which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    cow_igo_sy %>%
      left_join(data, .) -> data

      return(data)

    }

  } else  {
    stop("add_igos() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
