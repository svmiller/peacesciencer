#' Filter dyad-year data to include just politically relevant dyads
#'
#' @description \code{filter_prd()} filters a dyad-year data frame to just those that
#' are "politically relevant." This is useful for discarding unnecessary (and unwanted)
#' observations that just consume space in memory.
#'
#' @return \code{filter_prd()} takes a dyad-year data frame, assuming it has columns for
#' major power status and contiguity type, calculates whether the dyad is "politically
#' relevant", and subsets the data frame to just those observations.
#'
#' @details "Political relevance" can be calculated a few ways. Right now, the function
#' considers only "direct" contiguity and Correlates of War major power status. You can employ
#' maximalist definitions of "direct contiguity" to focus on just the land-contiguous. This function
#' is inclusive of any type of contiguity relationship.
#'
#' As of the slated release of version 0.5, \code{filter_prd()} is a shortcut for \code{add_contiguity()}
#' and/or \code{add_cow_majors()} if the function is executed in the absence of the data needed to create
#' politically relevant dyads. See the example below for what this means.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references
#'
#' Weede, Erich. 1976. "Overwhelming preponderance as a pacifying condition among
#' contiguous Asian dyads." \emph{Journal of Conflict Resolution} 20: 395-411.
#'
#' Lemke, Douglas and William Reed. 2001. "The Relevance of Politically Relevant Dyads."
#' \emph{Journal of Conflict Resolution} 45(1): 126-144.
#'
#' @examples
#'
#' \donttest{
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' A <- cow_ddy %>% add_contiguity() %>% add_cow_majors() %>% filter_prd()
#'
#' A
#'
#' # you can also use it as a shortcut for the other functions required
#' # to calculate politically relevant dyads.
#' B <- cow_ddy %>% filter_prd()
#'
#' B
#'
#' identical(A,B)
#' }
#'

filter_prd <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("filter_prd() depends on Correlates of War state codes (ccode1, ccode2), which you don't have right now. Run create_dyadyears() at the top of the pipe. The default returns CoW codes.")


    } else {

      if (all(i <- c("conttype", "cowmaj1", "cowmaj2") %in% colnames(data))) {

        data %>%
          mutate(prd = case_when(
            conttype >= 1 ~ 1,
            conttype == 0 & cowmaj1 == 1 ~ 1,
            conttype == 0 & cowmaj2 == 1 ~ 1,
            TRUE ~ 0
          )) %>%
          filter(.data$prd == 1) -> data

        return(data)


      } else if (!all(i <- c("conttype") %in% colnames(data)) && all(j <- c("cowmaj1", "cowmaj2") %in% colnames(data))) {

        data %>%
          add_contiguity() %>%
          mutate(prd = case_when(
            conttype >= 1 ~ 1,
            conttype == 0 & cowmaj1 == 1 ~ 1,
            conttype == 0 & cowmaj2 == 1 ~ 1,
            TRUE ~ 0
          )) %>%
          filter(.data$prd == 1) -> data

        return(data)

      } else if (!all(i <- c("cowmaj1", "cowmaj2") %in% colnames(data)) && all(j <- c("conttype") %in% colnames(data))) {

        data %>%
          add_cow_majors() %>%
          mutate(prd = case_when(
            conttype >= 1 ~ 1,
            conttype == 0 & cowmaj1 == 1 ~ 1,
            conttype == 0 & cowmaj2 == 1 ~ 1,
            TRUE ~ 0
          )) %>%
          filter(.data$prd == 1) -> data

        return(data)

      } else {

        data %>%
          add_contiguity() %>%
          add_cow_majors() %>%
          mutate(prd = case_when(
            conttype >= 1 ~ 1,
            conttype == 0 & cowmaj1 == 1 ~ 1,
            conttype == 0 & cowmaj2 == 1 ~ 1,
            TRUE ~ 0
          )) %>%
          filter(.data$prd == 1) -> data

        return(data)

      }



    }

  } else  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    stop("filter_prd() only makes sense in the context of dyad-year data.")

  } else {
    stop("{peacesciencer} functions require attributes(data)$ps_data_type (either dyad-year or state-year for a given function). Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }
  return(data)
}
