#' Add Simulated GDP, Population, and GDP per Capita Data
#'
#' @description
#'
#' \code{add_sim_gdp_pop()} allows you to add estimated gross domestic product
#' (GDP), population, and GDP per capita data provided by recent updates by
#' Anders, Fariss, Markowitz (and now Barnum) to the original 2020 publication
#' in *International Studies Quarterly*. The function leans on data available in
#' \pkg{isard}, a spin-off package featuring data that have periodic updates.
#'
#'
#' @return
#'
#' \code{add_sim_gdp_pop()} takes a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame and adds information about the simulated GDP,
#' population, and GDP per capita for that state (or pair of states) in a given
#' year.
#'
#' @details
#'
#'
#' You can read more about the data in the documentation for \pkg{isard}.
#'
#' - [https://svmiller.com/isard/reference/cw_gdppop.html](https://svmiller.com/isard/reference/cw_gdppop.html)
#' - [https://svmiller.com/isard/reference/gw_gdppop.html](https://svmiller.com/isard/reference/gw_gdppop.html)
#'
#' The function leans on attributes of the data that are provided by one of
#' the "create" functions. Make sure a recognized function (or data created
#' by that function) appear at the top of the proverbial pipe. Users will
#' also want to note that the function accesses two different data sets. Thus,
#' the data set it uses will depend on whatever \pkg{peacesciencer} understands
#' is the "master" data set (communicated in the attributes field for system
#' type).
#'
#' Users primarily working in the Correlates of War system will be a little
#' disappointed that the simulations the authors provide are demarcated in the
#' Gleditsch-Ward system. The overlap is substantial, but the data the authors
#' provide are at the mercy of the Gleditsch-Ward system for describing the
#' universe of cases that could have a GDP, a population, or a GDP per capita.
#' There will be conspicuous missingness for Correlates of War data concerning
#' Serbia (1916, 1917), Morocco (1905-1912), Egypt (1856-1882), Saudi Arabia
#' (1927-1931), and Laos (1953). Interested users may want to explore some
#' imputation procedures, potentially leveraging older versions of the data.
#'
#' Fariss et al. (2022) provide multiple variations of GDP and GDP per capita
#' in their simulations, but the data I provide follow their suggested defaults.
#' The GDP per capita is demarcated in constant 2011 international dollars
#' (purchasing power parity (PPP)), GDP is expenditure-side real GDP in millions
#' of 2017 international dollars (PPP). The simulated population estimate is in
#' millions of people. The Maddison Project Database is the source of
#' simulations for GDP per capita while Penn World Table is the source of
#' simulations for GDP and population. You can use the latter two metrics and
#' create another version of GDP per capita if you like.
#'
#' The data in \pkg{isard} include simulated standard deviations around the
#' estimate. It's understandable that users are interested in just the point
#' estimate but the variation of uncertainty around the estimate is also
#' important. You should consider incorporating it into your analyses.
#' Be mindful that the data are fundamentally state-year and that extensions
#' to leader-level data should be understood as approximations for leaders in
#' a given state-year.
#'
#' The `keep` argument must include one or more of the estimates included in the
#' `cw_gdppop` or `gw_gdppop` data in the \pkg{isard} data. Otherwise, it will
#' return an error that it cannot subset columns that do not exist.
#'
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param keep an optional parameter, specified as a character vector, about
#' what estimates the user wants to return from this function. If not specified,
#' everything from the underlying data is returned.
#'
#' @references
#'
#' Please cite Miller (2022) for \pkg{peacesciencer}. Beyond that, consult the
#' documentation in \pkg{isard} for additional citations (contingent on which
#' GDP, population, or GDP per capita estimate you are using).
#'
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_sim_gdp_pop()
#'
#' create_stateyears() %>% add_sim_gdp_pop()
#'
#' create_stateyears(system = "gw") %>% add_sim_gdp_pop()
#'
#'



add_sim_gdp_pop <- function(data, keep) {

  ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    cow_state_year = .add_sim_gdp_pop_cow_state_year,
    cow_leader_year = .add_sim_gdp_pop_cow_state_year,
    gw_state_year = .add_sim_gdp_pop_gw_state_year,
    gw_leader_year = .add_sim_gdp_pop_gw_state_year,
    cow_dyad_year = .add_sim_gdp_pop_cow_dyad_year,
    cow_leader_dyad_year = .add_sim_gdp_pop_cow_dyad_year,
    gw_dyad_year = .add_sim_gdp_pop_gw_dyad_year,
    gw_leader_dyad_year = .add_sim_gdp_pop_gw_dyad_year
  )

  if (!system_type %in% names(dispatch)) {

    stop("Unsupported combination of ps_system and ps_data_type. System must be 'cow' or 'gw' and the data type must be 'dyad_year', `leader_dyad_year`, or 'state_year'.")

  }

  data <- dispatch[[system_type]](data, keep)

  return(data)

}



#' @keywords internal
#' @noRd
.add_sim_gdp_pop_cow_state_year <- function(data, keep) {

  syp <- isard::cw_gdppop

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
.add_sim_gdp_pop_gw_state_year <- function(data, keep) {

  syp <- isard::gw_gdppop

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
.add_sim_gdp_pop_cow_dyad_year <- function(data, keep) {

  syp <- isard::cw_gdppop

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
      rename(mrgdppc1 = .data$mrgdppc,
             sd_mrgdppc1 = .data$sd_mrgdppc,
             pwtrgdp1 = .data$pwtrgdp,
             sd_pwtrgdp1 = .data$sd_pwtrgdp,
             pwtpop1 = .data$pwtpop,
             sd_pwtpop1 = .data$sd_pwtpop) %>%
      left_join(., syp, by=c("ccode2"="ccode","year"="year")) %>%
      rename(mrgdppc2 = .data$mrgdppc,
             sd_mrgdppc2 = .data$sd_mrgdppc,
             pwtrgdp2 = .data$pwtrgdp,
             sd_pwtrgdp2 = .data$sd_pwtrgdp,
             pwtpop2 = .data$pwtpop,
             sd_pwtpop2 = .data$sd_pwtpop) -> data

  }








}

#' @keywords internal
#' @noRd
.add_sim_gdp_pop_gw_dyad_year <- function(data, keep) {

  syp <- isard::gw_gdppop

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
      rename(mrgdppc1 = .data$mrgdppc,
             sd_mrgdppc1 = .data$sd_mrgdppc,
             pwtrgdp1 = .data$pwtrgdp,
             sd_pwtrgdp1 = .data$sd_pwtrgdp,
             pwtpop1 = .data$pwtpop,
             sd_pwtpop1 = .data$sd_pwtpop) %>%
      left_join(., syp, by=c("gwcode2"="gwcode","year"="year")) %>%
      rename(mrgdppc2 = .data$mrgdppc,
             sd_mrgdppc2 = .data$sd_mrgdppc,
             pwtrgdp2 = .data$pwtrgdp,
             sd_pwtrgdp2 = .data$sd_pwtrgdp,
             pwtpop2 = .data$pwtpop,
             sd_pwtpop2 = .data$sd_pwtpop) -> data
  }

}

