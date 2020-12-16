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
#' It will not take much effort to generalize this, though.
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
#' library(magrittr)
#' cow_ddy %>% add_contiguity() %>% add_cow_majors() %>% filter_prd()
#'
#'

filter_prd <- function(data) {
  # require(dplyr)
  # require(magrittr)

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

  data %>%
    mutate(prd = case_when(
      conttype <= 5 ~ 1,
      conttype > 5 & cowmaj1 == 1 ~ 1,
      conttype > 5 & cowmaj2 == 1 ~ 1,
      TRUE ~ 0
    )) %>%
    filter(.data$prd == 1) -> data

  } else  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    stop("filter_prd() only makes sense in the context of dyad-year data.")

  } else {
    stop("{peacesciencer} functions require attributes(data)$ps_data_type (either dyad-year or state-year for a given function). Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }
  return(data)
}
