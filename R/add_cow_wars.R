#' Add Correlates of War war data to dyad-year or state-year data frame.
#'
#' @description \code{add_cow_wars()} allows you to Correlates of War data to a
#' dyad-year or state-year data frame
#'
#' @return \code{add_cow_wars()} takes a dyad-year or state-year data frame and
#' returns information about wars from either the inter-state or intra-state war
#' data set from the Correlates of War. The function works for state-year data
#' when the user wants information about extra-state wars or intra-state wars.
#' The function works for dyad-year data when the user wants information about
#' inter-state wars.
#'
#' @details
#'
#' Intra-state war data are coerced into true state-year data by first
#' selecting the duplicate state-years on unique onsets, then whichever
#' war was the deadliest. The inter-state war data work functionally the same way.
#'
#' On intra-state wars: the \code{primary_state} is used to identify the government
#' principally fighting the domestic non-state actor over central control over
#' local issues. Internationalized civil wars are included in the data, but not
#' for outside actors that intervene on behalf of the government or rebel group.
#'
#' Extra-state war functionality is not available right now as I try to
#' figure out the demand for its use.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param type the type of war you want to add. Options include "inter" or "intra".
#' @param intratype the types of armed conflicts the user wants to consider, specified as a character vector.
#' Options include "local issues" and "central control". Applicable only if \code{type} is "intra".
#'
#' @references
#'
#' Dixon, Jeffrey, and Meredith Sarkees. 2016. *A Guide to Intra-State Wars: An Examination of Civil Wars, 1816-2014.*
#' Thousand Oaks, CA: Sage.
#'
#' Sarkees, Meredith Reid, and Frank Wheldon Wayman. 2010.
#' *Resort to War: A Data Guide to Inter-State, Extra-State, Intra-State, and Non-State Wars, 1816-2007.*
#' Washington DC: CQ Press.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' create_stateyears(system = "cow") %>%
#' add_cow_wars(type = "intra", intratype = "central control")
#'
#' create_stateyears(system = "cow") %>%
#' add_cow_wars(type = "intra", intratype = "local issues")
#'
#' cow_ddy %>% add_cow_wars(type = "inter")
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_cow_wars <- function(data, type, intratype = "all") {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_cow_wars() merges on the Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears(system = 'cow') at the top of the pipe.")


    } else if (type == "inter") {

    cow_war_inter %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      # filter(n() > 1) %>%
      arrange(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0),
             sddd = sd(.data$cowinteronset)) %>%
      mutate(removeme = case_when(
        .data$duplicated == 1 & .data$sddd > 0 & .data$cowinteronset == 0 ~ 1,
        TRUE ~ 0
      )) %>%
      filter(.data$removeme == 0) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate_at(vars(contains("death")), ~ifelse(. < 0, NA, .)) %>%
      rowwise() %>%
      mutate(deaths = .data$batdeath1 + .data$batdeath2) %>%
      mutate(deaths = case_when(
        is.na(.data$deaths) & is.na(.data$batdeath1) ~ .data$batdeath2,
        is.na(.data$deaths) & is.na(.data$batdeath2) ~ .data$batdeath1,
        TRUE ~ .data$deaths
      )) %>%
      group_by(.data$ccode1, .data$ccode2, .data$year) %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      arrange(-.data$deaths) %>%
      slice(1) %>%
      ungroup() %>%
      select(.data$ccode1:.data$resume) -> the_data


      the_data %>%
        left_join(data,.) %>%
        mutate_at(vars("cowinteronset", "cowinterongoing"), ~ifelse(is.na(.) & between(.data$year, 1816, 2007), 0, .)) -> data

      return(data)

    } else {
      stop("add_cow_wars() only works with type == 'inter' for dyad-year data.")
    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_cow_wars() merges on the Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears(system = 'cow') at the top of the pipe.")


    } else {

      if(type %in% c("inter")) {

        stop("add_cow_wars(type='inter') is supported for just the dyad-year data at the moment.")

      } else if (type == "intra") {

        if(intratype == "all") {

          cow_war_intra %>%
            rename(ccode = .data$ccodea) %>%
            filter(.data$primary_state == 1) -> hold_this

        } else if (intratype == "central control") {

          cow_war_intra %>%
            rename(ccode = .data$ccodea) %>%
            filter(.data$primary_state == 1) %>%
            filter(.data$wartype == "central control") -> hold_this


        } else if (intratype == "local issues") {

          cow_war_intra %>%
            rename(ccode = .data$ccodea) %>%
            filter(.data$primary_state == 1) %>%
            filter(.data$wartype == "local issues") -> hold_this

        } else {

          stop("intratype must be 'central control', 'local issues', or 'all'.")

        }

        hold_this %>%
          group_by(.data$ccode, .data$year) %>%
          mutate(intrawarnums = paste0(.data$warnum, collapse = "; ")) %>%
          select(.data$warnum:.data$wartype, .data$ccode, .data$year, everything()) %>%
          mutate(duplicated = ifelse(n() > 1, 1, 0),
                 sddd = sd(.data$cowintraonset)) %>%
          # Remove anything that's not a unique war onset
          mutate(removeme = case_when(
            .data$duplicated == 1 & .data$sddd > 0 & .data$cowintraonset == 0 ~ 1,
            TRUE ~ 0
          )) %>%
          filter(.data$removeme == 0) %>%
          group_by(.data$ccode, .data$year) %>%
          mutate_at(vars(contains("deaths")), ~ifelse(. < 0, NA, .)) %>%
          rowwise() %>%
          mutate(deaths = .data$sideadeaths + .data$sidebdeaths) %>%
          mutate(deaths = case_when(
            is.na(.data$deaths) & is.na(.data$sidebdeaths) ~ .data$sideadeaths,
            is.na(.data$deaths) & is.na(.data$sideadeaths) ~ .data$sidebdeaths,
            TRUE ~ .data$deaths
          )) %>%
          group_by(.data$ccode, .data$year) %>%
          mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
          arrange(-.data$deaths) %>%
          slice(1) %>%
          ungroup() %>%
          select(.data$warnum:.data$cowintraongoing, .data$intnl,
                 .data$outcome, .data$sideadeaths, .data$sidebdeaths, .data$intrawarnums) %>%
          # selecting on primary states means there are no -8s, just -9s where missing
          mutate_at(vars(contains("deaths")), ~ifelse(is.na(.), -9, .)) -> the_data

        data %>%
          left_join(., the_data) %>%
          mutate_at(vars("cowintraonset", "cowintraongoing"), ~ifelse(is.na(.) & between(.data$year, 1816, 2007), 0, .)) -> data

        return(data)

      }


    }
  }
  else  {
    stop("add_cow_wars() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }

}
