#' Add Correlates of War major power information to a dyad-year data frame
#'
#' @description \code{add_cow_majors()} allows you to add Correlates of War major power variables
#' to a dyad-year data frame.
#'
#' @return \code{add_cow_majors()} takes a dyad-year data frame and adds two columns for whether
#' the first state (i.e. \code{ccode1}) or the second state (i.e. \code{ccode2}) are major powers
#' in the given year, according to the Correlates of War. 1 = is a major power. 0 = is not a major
#' power.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references Correlates of War Project. 2017. "State System Membership List, v2016." Online, \url{https://correlatesofwar.org/data-sets/state-system-membership}
#'
#' @examples
#'
#' library(magrittr)
#' cow_ddy %>% add_cow_majors()
#'
#'

add_cow_majors <- function(data) {
  require(dplyr)
  require(magrittr)
  require(dplyr)
  require(tidyr)
  require(stringr)

  cow_majors %>%
    select(ccode, styear, endyear) %>%
    rowwise() %>%
    mutate(year = list(seq(styear, endyear))) %>% unnest(year) %>%
    select(-styear, -endyear) %>%
    mutate(cowmaj = 1) -> major_years

  cow_ddy %>% left_join(., major_years, by=c("ccode1"="ccode","year"="year")) %>%
    rename(cowmaj1 = cowmaj) %>%
    left_join(., major_years, by=c("ccode2"="ccode","year"="year")) %>%
    rename(cowmaj2 = cowmaj) %>%
    mutate_at(vars("cowmaj1", "cowmaj2"), ~ifelse(is.na(.), 0, .)) -> data

  return(data)
}
