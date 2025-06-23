#' Add democracy information to a data frame
#'
#' @description
#'
#' \code{add_democracy()} allows you to add estimates of democracy to your data.
#'
#'
#' @return
#'
#' \code{add_democracy()} takes a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame and adds information about the level of democracy
#' for the state or two states in the dyad in a given year. If the data are
#' dyad-year or leader-dyad-year, the function adds six total columns for
#' the first state  (i.e. `ccode1` or `gwcode1`) and the second state (i.e.
#' `ccode2` or  `gwcode2`) about the level of democracy measured by the
#' Varieties of  Democracy project (`v2x_polyarchy`), the Polity project
#' (`polity2`), and Xavier Marquez' `QuickUDS` extensions/estimates. If the
#' data are state-year or leader-year, the function returns three additional
#' columns to the original data that contain that same information for a given
#' state in a given year.
#'
#' @details
#'
#' As of version 1.2, this function leans on the information made available in
#' the \pkg{isard} package. This is a spin-off package I maintain for data that
#' require periodic updates for the functionality in this package. As of writing,
#' \pkg{peacesciencer} only requires that you have the \pkg{isard} package
#' installed. It does not require you to have any particular version of the
#' package installed. Thus, what exactly this function returns may depend on the
#' particular version of \pkg{isard} you have installed. This will assuredly
#' concern the right-bound of the temporal domain of data you get.
#'
#' You can read more about the data in the documentation for \pkg{isard}.
#'
#' - [https://svmiller.com/isard/reference/cw_democracy.html](https://svmiller.com/isard/reference/cw_democracy.html)
#' - [https://svmiller.com/isard/reference/gw_democracy.html](https://svmiller.com/isard/reference/gw_democracy.html)
#'
#' Be mindful that the data are fundamentally state-year and that extensions to
#' leader-level data should be understood as approximations for leaders in a
#' given state-year.
#'
#" The `keep` argument must include one or more of the democracy estimates
#' included in the `cw_democracy` or `gw_democracy` data in the \pkg{isard}
#' data. Otherwise, it will return an error that it cannot subset columns that
#' do not exist.
#'
#' A vignette on the package's website talks about how these data are here
#' primarily to encourage you to maximize the number of observations in the
#' analysis to follow. Xavier Marquez' `QuickUDS` estimates have the best
#' coverage. If democracy is ultimately a control variable, or otherwise a
#' variable not of huge concern for the analysis (i.e. the user has no
#' particular stake on the best measurement of democracy or the best
#' conceptualization and operationalization of "democracy"), please
#' use Marquez' estimates instead of Polity or V-dem. If the user is
#' doing an analysis of inter-state conflict, and across the standard
#' post-1816 domain in conflict studies,  *definitely* don't use
#' the Polity data because the extent of its missingness is both large and
#' unnecessary. Please read the vignette describing these issues
#' here: \url{http://svmiller.com/peacesciencer/articles/democracy.html}
#'
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param keep an optional parameter, specified as a character vector, about
#' what democracy estimates the user wants to return from this function. If not
#' specified, everything from the underlying democracy data is returned.
#'
#' @references
#'
#' Please cite Miller (2022) for \pkg{peacesciencer}. Beyond that, consult the
#' documentation in \pkg{isard} for additional citations (contingent on which
#' democracy estimate you are using).
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_democracy()
#'
#' create_stateyears(system="gw") %>% add_democracy()
#' create_stateyears(system="cow") %>% add_democracy()
#'


add_democracy <- function(data, keep) {

  ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    cow_state_year = .add_democracy_cow_state_year,
    cow_leader_year = .add_democracy_cow_state_year,
    gw_state_year = .add_democracy_gw_state_year,
    gw_leader_year = .add_democracy_gw_state_year,
    cow_dyad_year = .add_democracy_cow_dyad_year,
    cow_leader_dyad_year = .add_democracy_cow_dyad_year,
    gw_dyad_year = .add_democracy_gw_dyad_year,
    gw_leader_dyad_year = .add_democracy_gw_dyad_year
  )

  if (!system_type %in% names(dispatch)) {

    stop("Unsupported combination of ps_system and ps_data_type. System must be 'cow' or 'gw' and the data type must be 'dyad_year', `leader_dyad_year`, or 'state_year'.")

  }

  data <- dispatch[[system_type]](data, keep)

  return(data)

}



#' @keywords internal
#' @noRd
.add_democracy_cow_state_year <- function(data, keep) {

  syp <- isard::cw_democracy

  if (!missing(keep)) {
    syp <- subset(syp, select = c("ccode", "year", keep))
  } else {
    syp <- syp
  }

  data %>%
    left_join(., syp) -> data


}

#' @keywords internal
#' @noRd
.add_democracy_gw_state_year <- function(data, keep) {

  syp <- isard::gw_democracy

  if (!missing(keep)) {
    syp <- subset(syp, select = c("gwcode", "year", keep))
  } else {
    syp <- syp
  }

  data %>%
    left_join(., syp) -> data


}


#' @keywords internal
#' @noRd
.add_democracy_cow_dyad_year <- function(data, keep) {

  syp <- isard::cw_democracy

  if (!missing(keep)) {
    syp <- subset(syp, select = c("ccode", "year", keep))

    syp %>%
      rename_with(~paste0(.x, "1", recycle0 = TRUE), keep) %>%
      left_join(data, ., by=c("ccode1"="ccode",
                              "year"="year")) %>%
      left_join(.,   syp %>%
                  rename_with(~paste0(.x, "2", recycle0 = TRUE), keep),
                by=c("ccode2"="ccode", "year"="year")) -> data

  } else {

    syp <- syp

    data %>% left_join(., syp, by=c("ccode1"="ccode","year"="year")) %>%
      rename(v2x_polyarchy1 = .data$v2x_polyarchy,
             polity21 = .data$polity2,
             euds1 = .data$euds,
             aeuds1 = .data$aeuds) %>%
      left_join(., syp, by=c("ccode2"="ccode","year"="year")) %>%
      rename(v2x_polyarchy2 = .data$v2x_polyarchy,
             polity22 = .data$polity2,
             euds2 = .data$euds,
             aeuds2 = .data$aeuds) -> data

  }








}

#' @keywords internal
#' @noRd
.add_democracy_gw_dyad_year <- function(data, keep) {

  syp <- isard::gw_democracy

  if (!missing(keep)) {
    syp <- subset(syp, select = c("gwcode", "year", keep))

    syp %>%
      rename_with(~paste0(.x, "1", recycle0 = TRUE), keep) %>%
      left_join(data, ., by=c("gwcode1"="gwcode",
                              "year"="year")) %>%
      left_join(.,   syp %>%
                  rename_with(~paste0(.x, "2", recycle0 = TRUE), keep),
                by=c("gwcode2"="gwcode", "year"="year")) -> data

  } else {
    syp <- syp

    data %>% left_join(., syp, by=c("gwcode1"="gwcode","year"="year")) %>%
      rename(v2x_polyarchy1 = .data$v2x_polyarchy,
             polity21 = .data$polity2,
             euds1 = .data$euds,
             aeuds1 = .data$aeuds) %>%
      left_join(., syp, by=c("gwcode2"="gwcode","year"="year")) %>%
      rename(v2x_polyarchy2 = .data$v2x_polyarchy,
             polity22 = .data$polity2,
             euds2 = .data$euds,
             aeuds2 = .data$aeuds) -> data
  }

}



# add_democracy <- function(data) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#     if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#
#       data %>% left_join(., ccode_democracy, by=c("ccode1"="ccode","year"="year")) %>%
#         rename(v2x_polyarchy1 = .data$v2x_polyarchy,
#                polity21 = .data$polity2,
#                xm_qudsest1 = .data$xm_qudsest) %>%
#         left_join(., ccode_democracy, by=c("ccode2"="ccode","year"="year")) %>%
#         rename(v2x_polyarchy2 = .data$v2x_polyarchy,
#                polity22 = .data$polity2,
#                xm_qudsest2 = .data$xm_qudsest) -> data
#
#       return(data)
#
#     } else { # assuming it's G-W
#
#       data %>% left_join(., gwcode_democracy, by=c("gwcode1"="gwcode","year"="year")) %>%
#         rename(v2x_polyarchy1 = .data$v2x_polyarchy,
#                polity21 = .data$polity2,
#                xm_qudsest1 = .data$xm_qudsest) %>%
#         left_join(., gwcode_democracy, by=c("gwcode2"="gwcode","year"="year")) %>%
#         rename(v2x_polyarchy2 = .data$v2x_polyarchy,
#                polity22 = .data$polity2,
#                xm_qudsest2 = .data$xm_qudsest) -> data
#
#       return(data)
#
#
#
#     }
#
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#
#       data %>%
#         left_join(., ccode_democracy) -> data
#
#       return(data)
#
#     } else { # assuming it's G-W
#
#       data %>%
#         left_join(., gwcode_democracy) -> data
#
#       return(data)
#
#     }
#
#   } else  {
#     stop("add_democracy() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#   }
#
#   return(data)
# }
