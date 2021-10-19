#' Add rugged terrain information to a dyad-year or state-year data frame
#'
#' @description \code{add_rugged_terrain()} allows you to add information, however crude,
#' about the "ruggedness" of a state's terrain to your dyad-year or state-year data.
#'
#' @return \code{add_rugged_terrain()} takes a dyad-year data frame or state-year
#' data frame, whether the primary state identifiers are from the Correlates of War
#' system or the Gleditsch-Ward system, and returns information about the
#' "ruggedness" of the state's terrain. The two indicators returned are the
#' "terrain ruggedness index" calculated by Nunn and Puga (2012) and a logarithmic
#' transformation of how mountainous the state is (as calculated by Gibler and Miller [2014]).
#' The dyad-year data get four additional columns (i.e. both indicators for both states
#' in the dyad) whereas the state-year data get just the two additional columns.
#'
#' @details Please see the information for the underlying data \code{rugged}, and the
#' associated R script in the \code{data-raw} directory, to see how these data are generated.
#' Importantly, these data are time-agnostic and move *slowly*. We're talking about geography here.
#' Both data sets benchmark around 1999-2000 and it's a leap of faith to use these data for comparisons
#' across the entirety of the Correlates of War or Gleditsch-Ward system membership. Every use of data
#' of these types have been either cross-sectional snapshots or for making state-to-state comparisons
#' after World War II (think of your prominent civil war studies here). Be mindful about what you expect
#' to get from these data.
#'
#' The underlying data have both Gleditsch-Ward codes and Correlates of War codes. The merge it makes depends
#' on what you declare as the "master" system at the top of the pipe (i.e. in \code{create_dyadyears()} or
#' \code{create_stateyears()}). If, for example, you run \code{create_stateyears(system="cow")} and follow
#' it with \code{add_gwcode_to_cow()}, the merge will be on the Correlates of War codes and not the Gleditsch-Ward
#' codes. You can see the script mechanics to see how this is achieved.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame
#'
#' @references
#'
#' Fearon, James D., and David Laitin, "Ethnicity, Insurgency, and Civil War"
#' \emph{American Political Science Review} 97: 75–90.
#'
#' Gibler, Douglas M. and Steven V. Miller. 2014. "External Territorial Threat, State Capacity, and Civil War."
#' \emph{Journal of Peace Research} 51(5): 634-646.
#'
#' Nunn, Nathan and Diego Puga. 2012. "Ruggedness: The Blessing of Bad Geography in Africa."
#' \emph{Review of Economics and Statistics}. 94(1): 20-36.
#'
#' Riley, Shawn J., Stephen D. DeGloria, and Robert Elliot. 1999. "A Terrain Ruggedness
#' Index That Quantifies Topographic Heterogeneity,” \emph{Intermountain Journal of Sciences} 5: 23–27.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_rugged_terrain()
#'
#' create_stateyears() %>% add_rugged_terrain()
#'
#' create_stateyears(system = "gw") %>% add_rugged_terrain()
#' }
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_rugged_terrain <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      rugged %>%
        select(-.data$gwcode) -> hold_this

      hold_this %>%
        left_join(data, ., by=c("ccode1"="ccode")) %>%
        rename(rugged1 = .data$rugged,
               newlmtnest1 = .data$newlmtnest) %>%
        left_join(., hold_this, by=c("ccode2"="ccode"))  %>%
        rename(rugged2 = .data$rugged,
               newlmtnest2 = .data$newlmtnest) -> data

      return(data)

    } else { # Assuming it's G-W system

      rugged %>%
        select(-.data$ccode) -> hold_this

      hold_this %>%
        left_join(data, ., by=c("gwcode1"="gwcode")) %>%
        rename(rugged1 = .data$rugged,
               newlmtnest1 = .data$newlmtnest) %>%
        left_join(., hold_this, by=c("gwcode2"="gwcode"))  %>%
        rename(rugged2 = .data$rugged,
               newlmtnest2 = .data$newlmtnest) -> data

      return(data)

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      rugged %>%
        select(-.data$gwcode) %>%
        left_join(data, .) -> data
      return(data)


    } else { # Assuming it's G-W system

      rugged %>%
        select(-.data$ccode) %>%
        left_join(data, .) -> data
      return(data)


    }
  }
  else  {
    stop("add_rugged_terrain() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }


}
