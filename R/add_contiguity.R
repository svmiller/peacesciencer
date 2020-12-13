#' Add Correlates of War direct contiguity information to a dyad-year data frame
#'
#' @description \code{add_contiguity()} allows you to add Correlates of War contiguity
#' data to a dyad-year data frame.
#'
#' @return \code{add_contiguity()} takes a dyad-year data frame and adds information
#' about the contiguity relationship based on the "master records" for the
#' Correlates of War direct contiguity data (v. 3.2).
#'
#' @details The contiguity codes range from 1 to 6. 1 = direct land contiguity. 2 =
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
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references Stinnett, Douglas M., Jaroslav Tir, Philip Schafer, Paul F. Diehl, and Charles Gochman
#' (2002). "The Correlates of War Project Direct Contiguity Data, Version 3." Conflict
#' Management and Peace Science 19 (2):58-66.
#'
#' @examples
#'
#' library(magrittr)
#' cow_ddy %>% add_contiguity()
#'
#'
add_contiguity <- function(data) {
  require(dplyr)
  require(magrittr)
  require(dplyr)
  require(tidyr)
  require(stringr)

  cow_contdir %>%
    mutate(styear = as.numeric(str_sub(begin, 1, 4)),
           endyear = as.numeric(str_sub(end, 1, 4))) %>%
    rowwise() %>%
    mutate(year = list(seq(styear, endyear))) %>%
    unnest(year) %>%
    select(ccode1:conttype, year) %>%
    group_by(ccode1, ccode2, year) %>%
    filter(conttype == min(conttype)) %>%
    ungroup() -> contdir_years

  data %>%
    left_join(., contdir_years) %>%
    mutate(conttype = ifelse(is.na(conttype), 6, conttype)) -> data

  return(data)
}


