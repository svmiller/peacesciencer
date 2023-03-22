#' Add UCDP Armed Conflict Data to state-year data frame
#'
#' @description \code{add_ucdp_acd()} allows you to add UCDP Armed Conflict data to a state-year data frame
#'
#' @return \code{add_ucdp_acd()} takes a state-year data frame and returns state-year information from the
#' UCDP Armed Conflict data set (v. 20.1). The variables returned are whether there is an ongoing armed
#' conflict in that year, whether there was an armed conflict episode onset that year, what was the maximum
#' intensity observed that year (if an armed conflict was observed), and a character vector of the associated
#' conflict IDs that year.
#'
#' @details Right now, only state-year data are supported. It's worth saying
#' that "both" in the \code{issue} argument should not be understood as
#' equivalent to \code{c("territory","government")}. The former is a kind of
#' "AND" (in boolean speak) and is an explicit category in the data. The latter
#' is an "OR" (in boolean speak) and is in all likelihood what you want if you
#' are tempted to specify "both" in the \code{issue} argument.
#'
#' @author Steven V. Miller
#'
#' @param data state-year data frame
#' @param type the types of armed conflicts the user wants to consider, specified as a character vector.
#' Options include "extrasystemic", "interstate", "intrastate", and "II". "II" is convenience shorthand for
#' "internationalized intrastate". If you want just one (say: "intrastate"), then the type you want in quotes
#' is sufficient. If you want multiple, wrap it in a vector with \code{c()}.
#' @param issue do you want to subset the data to just different armed conflicts over different types of issues?
#' If so, specify those here as you would with the \code{type} argument. Options include "territory", "government",
#' and "both".
#' @param only_wars subsets the conflict data to just those with intensity levels of "war" (i.e. >1,000 deaths). Defaults to FALSE.
#'
#' @references
#'
#' Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg & Havard Strand (2002)
#' Armed Conflict 1946–2001: A New Dataset. \emph{Journal of Peace Research} 39(5): 615–637.
#'
#' Pettersson, Therese; Stina Hogbladh & Magnus Oberg (2019). Organized violence, 1989-2018 and peace
#' agreements. *Journal of Peace Research* 56(4): 589-603.
#'
#' @examples
#'
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' library(dplyr)
#'
#' create_stateyears(system = "gw") %>%
#' filter(between(year, 1946, 2019)) %>%
#' add_ucdp_acd()
#'
#' create_stateyears(system = "gw") %>%
#' filter(between(year, 1946, 2019)) %>%
#' add_ucdp_acd(type = "intrastate", issue = "government")
#'
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_ucdp_acd <- function(data, type, issue, only_wars = FALSE) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    stop("add_ucdp_acd() only works for state-year data at the moment.")

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("gwcode") %in% colnames(data))) {

      stop("add_ucdp_acd() merges on the Gleditsch-Ward code (gwcode), which your data don't have right now. Make sure to run create_stateyears(system = 'gw') at the top of the pipe.")


    } else {

      if (missing(type) && !missing(issue)) {

        ucdp_acd %>%
          filter(.data$incompatibility %in% issue) -> hold_this

      } else if (!missing(type) && missing(issue)) {
        ucdp_acd %>%
          filter(.data$type_of_conflict %in% type) -> hold_this
      } else if (!missing(type) && !missing(issue)) {
        ucdp_acd %>%
          filter(.data$incompatibility %in% issue) %>%
          filter(.data$type_of_conflict %in% type) -> hold_this
      } else {
        ucdp_acd -> hold_this
      }

      if (only_wars == TRUE) {
        hold_this %>%
          filter(.data$intensity_level == 2) -> hold_this
      } else {

      }

      hold_this %>%
        group_by(.data$conflict_id, .data$gwno_a, .data$year) %>% slice(1) %>%
        arrange(.data$conflict_id, .data$gwno_a, .data$year) %>%
        group_by(.data$conflict_id, .data$gwno_a) %>%
        mutate(ucdponset = ifelse(row_number() == 1, 1, 0)) %>%
        group_by(.data$gwno_a, .data$year) %>%
        summarize(ucdpongoing = 1,
                  ucdponset = max(.data$ucdponset),
                  maxintensity = max(.data$intensity_level),
                  conflict_ids = paste0(.data$conflict_id, collapse = "; ")) %>%
        ungroup() %>%
        rename(gwcode = .data$gwno_a) %>%
        left_join(data, .) -> data

      data %>%
        mutate_at(vars("ucdpongoing","ucdponset"), ~ifelse(is.na(.) & .data$year >= 1946 & .data$year < 2020, 0, .)) -> data




      return(data)

    }
  }
  else  {
    stop("add_ucdp_acd() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }

}
