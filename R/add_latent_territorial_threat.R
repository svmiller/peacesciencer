#' Add estimated latent territorial threat to a data frame
#'
#' @description
#'
#' \code{add_latent_territorial_threat()} allows you to add estimates of latent,
#' external territorial threat to a dyad-year, leader-year, or leader-dyad-year,
#' or state-year data frame. The estimates come by way of Miller (2022).
#'
#' @return
#'
#' \code{add_latent_territorial_threat()} takes a data frame and adds
#' estimates of latent, external territorial threat derived from a random item
#' response model (as described by Miller (2022)).
#'
#'
#'
#' @details
#'
#' The data are stored in [terrthreat] in this package, which also communicates
#' what the variables are and what they mean in the case of overlapping
#' column names. Miller (2022) describes the random item response model in
#' more detail.
#'
#' The standard caveat applies that the data are fundamentally state-year (though
#' derived from dyad-year analyses). Extensions to leader-level data sets should
#' be understood as approximate. For example, it's reasonable to infer the
#' territorial threat for Germany under Friedrich Ebert in 1918 would differ
#' from what Wilhelm II would've experienced in the same year. However, the data
#' would have no way of knowing that (as they are).
#'
#' The state-year nature of the data also carry implications for its use in
#' dyad-year analyses. The function returns estimates of state-year levels of
#' territorial threat for the first state and second state in the dyad, and not
#' the level of territorial threat between each state in the dyad for the given
#' year.
#'
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param slice takes one of 'first' or 'last', determines behavior for when
#' there is a change in a contiguity relationship in a given dyad in a given year.
#' If 'first', the earlier contiguity relationship is recorded. If 'last', the
#' latest contiguity relationship is recorded.
#' @param mry logical, defaults to `FALSE`. If `TRUE`, the data carry forward the
#' identity of the major powers to the most recently concluded calendar year. If
#' `FALSE`, the panel honors the right bound of the data's temporal domain and
#' creates NAs for observations past it.
#'
#' @references
#'
#' Miller, Steven V. 2022. "A Random Item Response Model of External Territorial
#' Threat, 1816-2010" *Journal of Global Security Studies* 7(4): ogac012.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' create_stateyears() |> add_latent_territorial_threat(keep=c('lterrthreat'))
#' }
#'
#' @importFrom rlang .data
#' @importFrom rlang .env

add_latent_territorial_threat <- function(data, keep) {


  #ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  #system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    state_year = .add_lterr_threat_state_year,
    leader_year = .add_lterr_threat_state_year,
    dyad_year = .add_lterr_threat_dyad_year,
    leader_dyad_year = .add_lterr_threat_dyad_year
  )

  if (!ps_type %in% names(dispatch)) {

    stop("Unsupported ps_data_type. The data type must be 'dyad_year', `leader_dyad_year`, 'leader_year', or 'state_year'.")

  }

  data <- dispatch[[ps_type]](data, keep)

  return(data)

}


#' @keywords internal
#' @noRd
#'
.add_lterr_threat_state_year <- function(data, keep) {

  if (!all(i <- c("ccode") %in% colnames(data))) {

    stop("add_latent_territorial_threat() merges on Correlates of War codes (ccode), which your data don't have right now.")
  }

  if (!missing(keep)) {
    hold_this <- subset(terrthreat, select = c("ccode", "year", keep))
  } else {
    hold_this <- terrthreat
  }

 left_join(data, hold_this) -> data

}


#' @keywords internal
#' @noRd
.add_lterr_threat_dyad_year <- function(data, keep) {

  if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

    stop("add_latent_territorial_threat() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


  }


  if (!missing(keep)) {

    hold_this <- subset(terrthreat, select = c("ccode", "year", keep))


    hold_this %>%
      rename_with(~paste0(.x, "1", recycle0 = TRUE), keep) %>%
      left_join(data, ., by=c("ccode1"="ccode",
                              "year"="year")) %>%
      left_join(.,   hold_this %>%
                  rename_with(~paste0(.x, "2", recycle0 = TRUE), keep),
                by=c("ccode2"="ccode", "year"="year")) -> data

  } else {

    hold_this <- terrthreat

    data %>% left_join(., hold_this, by=c("ccode1"="ccode","year"="year")) %>%
      rename(lterrthreat1 = .data$lterrthreat,
             sd1 = .data$sd,
             lwr1 = .data$lwr,
             upr1 = .data$upr,
             m_lterrthreat1 = .data$m_lterrthreat,
             m_sd1 = .data$m_sd,
             m_lwr1 = .data$m_lwr,
             m_upr1 = .data$m_upr) %>%
      left_join(., hold_this, by=c("ccode2"="ccode","year"="year")) %>%
      rename(lterrthreat2 = .data$lterrthreat,
             sd2 = .data$sd,
             lwr2 = .data$lwr,
             upr2 = .data$upr,
             m_lterrthreat2 = .data$m_lterrthreat,
             m_sd2 = .data$m_sd,
             m_lwr2 = .data$m_lwr,
             m_upr2 = .data$m_upr) -> data
  }


}


