#' Show Duplicate Observations in Your Dyad-Year or State-Year Data Frame
#'
#' @description \code{show_duplicates()} shows which data are duplicated
#' in data generated in \pkg{peacesciencer}. It's a useful diagnostic tool
#' for users doing some do-it-yourself functions with \pkg{peacesciencer}.
#'
#'
#' @return \code{show_duplicates()} takes a dyad-year data frame or
#' state-year data frame generated in \pkg{peacesciencer} and
#' shows what observations are duplicated by unique combination of
#' dyad-year or state-year, contingent on what was supplied to it.
#'
#' @details The function leans on attributes of the data that are
#' provided by the \code{create_dyadyear()} or \code{create_stateyear()}
#' function. Make sure that function (or data created by that function)
#' appear at the top of the proverbial pipe.
#'
#' The data returned will also have a new column called \code{duplicated}.
#' Thus, an implicit assumption in this function is the user does not have
#' a column in the data with this name that is of interest to the user.
#' It will be overwritten.
#'
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame or a state-year data frame created in \pkg{peacesciencer}.
#'
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' gml_dirdisp %>% show_duplicates()
#' cow_mid_dirdisps %>% show_duplicates()


show_duplicates <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (attributes(data)$ps_system == "cow") {

      data %>%
        arrange(.data$ccode1, .data$ccode2, .data$year) %>%
        group_by(.data$ccode1, .data$ccode2, .data$year) %>%
        mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
        filter(.data$duplicated == 1) %>%
        # practice safe group_by()
        ungroup() -> data


    } else { # Assuming it's G-W

      data %>%
        arrange(.data$gwcode1, .data$gwcode2, .data$year) %>%
        group_by(.data$gwcode1, .data$gwcode2, .data$year) %>%
        mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
        filter(.data$duplicated == 1) %>%
        # practice safe group_by()
        ungroup()  -> data



    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (attributes(data)$ps_system == "cow") {

      data %>%
        arrange(.data$ccode,  .data$year) %>%
        group_by(.data$ccode,  .data$year) %>%
        mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
        filter(.data$duplicated == 1) %>%
        # practice safe group_by()
        ungroup()  -> data


    } else { # Assuming it's G-W

      data %>%
        arrange(.data$gwcode, .data$year) %>%
        group_by(.data$gwcode,  .data$year) %>%
        mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
        filter(.data$duplicated == 1) %>%
        # practice safe group_by()
        ungroup()  -> data

    }

  } else  {
    stop("show_duplicates() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}



