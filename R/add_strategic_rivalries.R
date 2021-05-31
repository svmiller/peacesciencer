#' Add Thompson and Dreyer's (2012) strategic rivalry data to dyad-year data frame
#'
#' @description \code{add_strategic_rivalries()} merges in Thompson and Dreyer's (2012) strategic rivalry data
#' to a dyad-year data frame. The right-bound, as of right now, are bound at 2010.
#'
#' @return \code{add_strategic_rivalries()} takes a dyad-year data frame and adds information about ongoing strategic rivalries.
#'
#' @details \code{add_strategic_rivalries()} will include some other information derived from the rivalry data that the
#' user may not want (e.g. start year of the rivalry). Feel free to select those out after the fact. Function includes
#' an on-the-fly adjustment for Austria for rivalry #79. In this case, the Austria-Serbia rivalry continues for two years
#' after Austria-Hungary (\code{ccode: 300}) became Austria (\code{ccode: 305}).
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{http://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R. and David Dreyer. 2012. \emph{Handbook of International Rivalries}. CQ Press.
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_strategic_rivalries()
#'

add_strategic_rivalries <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_strategic_rivalries() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      td_rivalries %>%
        bind_rows(td_rivalries %>% rename(ccode1 = .data$ccode2, ccode2 = .data$ccode1), .) %>%
        arrange(.data$rivalryno) %>%
        select(.data$rivalryno, .data$rivalryname, .data$ccode1, .data$ccode2,
               .data$styear, .data$endyear, .data$region, .data$type1, .data$type2, .data$type3) %>%
        rowwise() %>%
        mutate(year = list(seq(.data$styear, .data$endyear))) %>%
        # Unnest the list, which will expand the data.
        unnest(c(.data$year)) %>%
        # Minor note: ccode change for Austria, post-1918 for rivalryno 79.
        mutate(ccode1 = ifelse(.data$ccode1 == 300 & .data$year >= 1919, 305, .data$ccode1),
               ccode2 = ifelse(.data$ccode2 == 300 & .data$year >= 1919, 305, .data$ccode2)) %>%
        left_join(data, .) -> data

      return(data)

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

      stop("add_strategic_rivalries() is only available for dyad-year data right now. There is surely a state-year indicator to be derived from it, but I haven't figured out how I want to do this yet.")


    } else  {
      stop("add_strategic_rivalries() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
    }

    return(data)
  }
