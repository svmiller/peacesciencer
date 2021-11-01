#' Add Correlates of War direct contiguity information to a data frame
#'
#' @description \code{add_contiguity()} allows you to add Correlates of War contiguity
#' data to a dyad-year, leader-year, or leader-dyad-year, or state-year data frame.
#'
#' @return \code{add_contiguity()} takes a data frame and adds information
#' about the contiguity relationship based on the "master records" for the
#' Correlates of War direct contiguity data (v. 3.2). If the data are dyad-year (or leader dyad-year), the function
#' returns the lowest contiguity type observed in the dyad-year (if contiguity is observed at all).
#' If the data are state-year (or leader-year), the data return the total number of land and sea borders calculated
#' from these master records.
#'
#'
#'
#' @details The contiguity codes in the dyad-year data range from 0 to 5. 1 = direct land contiguity. 2 =
#' separated by 12 miles of water or fewer (a la Stannis Baratheon). 3 = separated by
#' 24 miles of water or fewer (but more than 12 miles). 4 = separated by 150 miles
#' of water or fewer (but more than 24 miles). 5 = separated by 400 miles of water
#' or fewer (but more than 150 miles).
#'
#' Importantly, 0 are the dyads that are not contiguous at all in the CoW contiguity data.
#' This is a conscious decision on my part as I do not think of the CoW's contiguity data
#' as exactly ordinal. Cross-reference CoW's contiguity data with the minimum distance
#' data in this exact package to see how some dyads that CoW codes as not contiguous are
#' in fact very close to each other, sometimes even land-contiguous. For example, Zimbabwe and
#' Namibia are separated by only about a few hundred feet of water at that peculiar intersection of
#' the Zambezi River where the borders of Zambia, Botswana, Namibia, and Zimbabwe meet. There is
#' no contiguity record for this in the CoW data. There are other cases where contiguity records
#' are situationally missing (e.g. India-Bangladesh, and Bangladesh-Myanmar in 1971) or other cases where
#' states are much closer than CoW's contiguity data imply (e.g. Pakistan and the Soviet Union were separated by
#' under 30 kilometers of Afghani territory). The researcher is free to recode these 0s to be, say, 6s, but this
#' is why \pkg{peacesciencer} does not do this.
#'
#' For additional clarity, the "master records" produce duplicates for cases when
#' the contiguity relationship changed in a given year. This function returns the
#' *minimum* contiguity relationship observed in that given year. There should be no
#' duplicates in the returned output.
#'
#' Be mindful that the data are fundamentally state-year and that extensions to leader-level data should be understood
#' as approximations for leaders in a given state-year.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed"),
#' a state-year data frame, a leader-year data frame, or leader dyad-year data frame
#'
#' @references Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman
#' (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict
#' Management and Peace Science 19 (2):58-66.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_contiguity()
#'
#' create_stateyears() %>% add_contiguity()
#' }
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_contiguity <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_contiguity() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

  cow_contdir %>%
    mutate(styear = as.numeric(str_sub(.data$begin, 1, 4)),
           endyear = as.numeric(str_sub(.data$end, 1, 4))) %>%
    rowwise() %>%
    mutate(year = list(seq(.data$styear, .data$endyear))) %>%
    unnest(.data$year) %>%
    select(.data$ccode1, .data$ccode2, .data$conttype, .data$year) %>%
    group_by(.data$ccode1, .data$ccode2, .data$year) %>%
    filter(.data$conttype == min(.data$conttype)) %>%
    ungroup() -> contdir_years

  data %>%
    left_join(., contdir_years) %>%
    mutate(conttype = case_when(is.na(.data$conttype) ~ 0,
                                TRUE ~ .data$conttype)) -> data
  return(data)

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_contiguity() merges on the Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {
    cow_contdir %>%
      mutate(styear = as.numeric(str_sub(.data$begin, 1, 4)),
             endyear = as.numeric(str_sub(.data$end, 1, 4))) %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear))) %>%
      unnest(.data$year) %>%
      select(.data$ccode1, .data$ccode2, .data$conttype, .data$year) %>%
      mutate(land = ifelse(.data$conttype == 1, 1, 0),
             sea = ifelse(.data$conttype > 1, 1, 0)) %>%
      group_by(.data$ccode1, .data$year) %>%
      summarize(land = sum(.data$land),
                sea = sum(.data$sea)) %>%
      rename(ccode  = .data$ccode1) %>%
      left_join(data, .) %>%
      mutate_at(vars("land","sea"), ~ifelse(is.na(.), 0, .)) -> data
    return(data)

    }
  }
  else  {
    stop("add_contiguity() requires a data/tibble with attributes$ps_data_type of state_year, leader_year, or dyad_year. Try running create_leaderyears(), create_dyadyears(), or create_stateyears() at the start of the pipe.")

  }


}


