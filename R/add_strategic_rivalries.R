#' Add Thompson and Dreyer's (2012) strategic rivalry data to dyad-year data frame
#'
#' @description \code{add_strategic_rivalries()} merges in Thompson and Dreyer's (2012) strategic rivalry data
#' to a dyad-year data frame. The right-bound, as of right now, are bound at 2010.
#'
#' @return \code{add_strategic_rivalries()} takes a dyad-year data frame and adds information about ongoing strategic rivalries. It
#' will also include a simple dummy variable for whether there was an ongoing rivalry in the year or not.
#' For state-year data, it returns the count of ongoing strategic rivalries for the state in the year meeting a certain criteria (i.e.
#' whether the state has an interventionary, ideological, positional, or spatial rivalry in an ongoing year, and how many).
#'
#' @details \code{add_strategic_rivalries()} will include some other information derived from the rivalry data that the
#' user may not want (e.g. start year of the rivalry). Feel free to select those out after the fact. Function includes
#' an on-the-fly adjustment for Austria for rivalry #79. In this case, the Austria-Serbia rivalry continues for two years
#' after Austria-Hungary (\code{ccode: 300}) became Austria (\code{ccode: 305}).
#'
#' The \code{across_types} argument is optional and observed for only state-year calls. It defaults to 1. At the default,
#' the function looks into the rivalry data (in \code{td_rivalries}) and focuses on the `type1` column. If, say, a state has
#' an ongoing rivalry and it is primarily spatial, it codes that as a spatial rivalry. Assume you input `across_types = 2`, the
#' function then looks across both the `type1` and `type2` columns to see if there is a spatial component to the rivalry as
#' either its primary or secondary dimension. If so, it codes that as a 1. \code{across_types} must be 1, 2, or 3.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param across_types optional, relevant for state-year, takes a value of 1, 2, or 3 to look for
#'  whether one of three types fits criteria for ideological, interventionary, positional, spatial
#'  rivalry. Defaults to 1.
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry Data in R".
#' URL: \url{http://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R. and David Dreyer. 2012. \emph{Handbook of International Rivalries}. CQ Press.
#'
#' @examples
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_strategic_rivalries()
#'
#' # across_types defaults to 1
#' create_stateyears() %>% add_strategic_rivalries()
#' }

add_strategic_rivalries <- function(data, across_types = 1) {


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
           ccode2 = ifelse(.data$ccode2 == 300 & .data$year >= 1919, 305, .data$ccode2)) -> hold_this

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_strategic_rivalries() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      hold_this %>%
        left_join(data, .) %>%
        mutate(ongoingrivalry = ifelse(is.na(.data$type1), 0, 1)) -> data

      return(data)

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_strategic_rivalries() merges on Correlates of War codes (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")

    } else{

      if(across_types == 1) {
        type_vars <- quo(c(.data$type1))

      } else if (across_types == 2) {
        type_vars <- quo(c(.data$type1, .data$type2))
      } else if (across_types == 3) {
        type_vars <- quo(c(.data$type1, .data$type2, .data$type3))
      } else {
        stop("across_types must be 1, 2, or 3.")
      }

      hold_this %>%
        select(.data$ccode1, .data$ccode2, .data$year, .data$type1:.data$type3) %>%
        mutate_all(~ifelse(is.na(.), "NA", .)) %>%
        rowwise() %>%
        mutate(ideological = ifelse("ideological" %in% !!type_vars, 1, 0),
               interventionary = ifelse("interventionary" %in% !!type_vars, 1, 0),
               positional = ifelse("positional" %in% !!type_vars, 1, 0),
               spatial = ifelse("spatial" %in% !!type_vars, 1, 0)) %>%
        group_by(.data$ccode1, .data$year) %>%
        summarize(ideological = sum(.data$ideological),
                  interventionary = sum(.data$interventionary),
                  positional = sum(.data$positional),
                  spatial = sum(.data$spatial)) %>%
        # mutate_at(vars("ideological", "interventionary", "positional", "spatial"), ~ifelse(. >= 1, 1, 0)) %>%
        ungroup() %>%
        rename(ccode = .data$ccode1) %>%
        left_join(data, .) %>%
        mutate_at(vars("ideological", "interventionary", "positional", "spatial"), ~ifelse(is.na(.), 0, .)) -> data

      return(data)
    }

    } else  {
      stop("add_strategic_rivalries() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
      return(data)
    }


  }
