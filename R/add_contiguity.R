#' Add Correlates of War direct contiguity information to a dyad-year or state-year data frame
#'
#' @description \code{add_contiguity()} allows you to add Correlates of War contiguity
#' data to a dyad-year or state-year data frame.
#'
#' @return \code{add_contiguity()} takes a dyad-year data frame and adds information
#' about the contiguity relationship based on the "master records" for the
#' Correlates of War direct contiguity data (v. 3.2). If the data are dyad-year, the function
#' returns the lowest contiguity type observed in the dyad-year (if contiguity is observed at all).
#' If the data are state-year, the data return the total number of land and sea borders calculated
#' from these master records.
#'
#' @details The contiguity codes in the dyad-year data range from 1 to 6. 1 = direct land contiguity. 2 =
#' separated by 12 miles of water or fewer (a la Stannis Baratheon). 3 = separated by
#' 24 miles of water or fewer (but more than 12 miles). 4 = separated by 150 miles
#' of water or fewer (but more than 24 miles). 5 = separated by 400 miles of water
#' or fewer (but more than 150 miles). 6 = separated by more than 400 miles of water (i.e.
#' not contiguous).
#'
#' For additional clarity, the "master records" produce duplicates for cases when
#' the contiguity relationship changed in a given year. This function returns the
#' *minimum* contiguity relationship observed in that given year. There should be no
#' duplicates in the returned output.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame
#'
#' @references Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman
#' (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict
#' Management and Peace Science 19 (2):58-66.
#'
#' @examples
#'
#' \dontrun{
#' library(magrittr)
#' library(peacesciencer)
#'
#' cow_ddy %>% add_contiguity()
#'
#' create_stateyears() %>% add_contiguity()
#' }
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_contiguity <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
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

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_contiguity() merges on Correlates of War code (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


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
    stop("add_contiguity() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }


}


