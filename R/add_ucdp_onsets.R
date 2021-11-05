#' Add UCDP onsets to state-year data
#'
#' @description \code{add_ucdp_onsets()} allows you to add information about conflict episode onsets from the UCDP
#' data program to state-year data.
#'
#'
#' @return \code{add_ucdp_onsets()} takes a state-year data frame and adds a few summary
#' variables based off armed conflict onsets data provided by UCDP. The variables returned are
#' the sum of new conflict dyads (should they exist) in a given state-year, and the sum of new onset episodes (or new conflicts) that are
#' separated by one, two, three, five, or 10 years since the last conflict episode.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe. The underlying data are version 19.1. Importantly, the UCDP yearly onset data are nominally state-year,
#' but technically state-dyad-episode-year for cases of onsets. For example, there are four France-1946 observations because of four
#' new conflict episodes with Cambodia, Laos, Thailand, and Vietnam. There are two Panama-1989 episodes, one for the invasion by
#' the United States and another for a failed coup attempt. That means the are duplicates in the original data that I process
#' into summaries. The user will probably want to consider some kind of recoding here.
#'
#' @author Steven V. Miller
#'
#' @param data a  state-year data frame
#'
#' @references
#'
#' Gleditsch, Nils Petter; Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg & Håvard Strand (2002)
#' Armed Conflict 1946–2001: A New Dataset. \emph{Journal of Peace Research} 39(5): 615–637.
#'
#' Pettersson, Therese; Stina Högbladh & Magnus Öberg (2019). Organized violence, 1989-2018 and peace
#' agreements. *Journal of Peace Research* 56(4): 589-603.

#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' library(dplyr)
#'
#' create_stateyears(system="gw") %>% add_ucdp_onsets()
#'
#' create_stateyears() %>%
#'   add_gwcode_to_cow() %>% add_ucdp_onsets()
#'
#' # Recall, these are summaries. You'll need to post-process to what you want.
#'
#' create_stateyears(system="gw") %>%
#'   add_ucdp_onsets() %>%
#'   mutate(onset = ifelse(sumonset1 > 0, 1, 0))
#'
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'

add_ucdp_onsets <- function(data) {



  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

   stop("add_ucdp_onsets() is only available for state-year data.")

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("gwcode") %in% colnames(data))) {

      stop("add_ucdp_onsets() merges on the Gleditsch-Ward code (gwcode), which your data don't have right now. Make sure to run create_stateyears(system = 'gw') at the top of the pipe or consider adding add_gwcode_to_cow() before this function. ")


    } else {

      data %>%
        left_join(., ucdp_onsets) %>%
        mutate_at(vars("sumnewconf", "sumonset1", "sumonset2", "sumonset3", "sumonset5", "sumonset10"), ~ifelse(is.na(.), 0, .)) -> data

      return(data)

    }

  } else  {
    stop("add_ucdp_onsets() requires a data/tibble with attributes$ps_data_type of state_year. Try running create_stateyears() at the start of the pipe.")
  }

  return(data)
}



