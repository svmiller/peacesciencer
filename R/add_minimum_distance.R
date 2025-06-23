#' Add minimum distance data to your data frame
#'
#' @description \code{add_minimum_distance()} allows you to add the minimum
#' distance (in kilometers) to a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame. These estimates are recorded in the
#' \code{cow_mindist} and \code{gw_mindist} data that come with this package.
#' The data are current as of the end of 2019.
#'
#'
#' @return
#'
#' \code{add_minimum_distance()} takes a (dyad-year, leader-year,
#' leader-dyad-year, state-year) data frame and adds the minimum distance
#' between the first state and the second state (in dyad-year data) or the
#' minimum minimum (sic) distance for a given state in a given year.
#'
#' @details The function leans on attributes of the data that are provided by
#' one of the "create" functions in this package (e.g. \code{create_dyadyear()}
#' or \code{create_stateyear()}).
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik
#' Cederman, and Kristian Skrede Gleditsch. 2022. "Mapping The International
#' System, 1886-2017: The \code{CShapes} 2.0 Dataset." *Journal of Conflict
#' Resolution*. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring
#' Country Shapes: The \code{cshapes} Package." *The R Journal* 2(1): 18-24.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_minimum_distance()
#'
#' create_dyadyears(system = "gw") %>% add_minimum_distance()
#'
#' create_stateyears(system ="gw") %>% add_minimum_distance()
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'
add_minimum_distance <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

  if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
    # Just to deal with all cases, we're going to create a directed version
    cow_mindist %>%
      rename(ccode1 = .data$ccode2,
             ccode2 = .data$ccode1) %>%
      bind_rows(cow_mindist, .) -> hold_cow

    data %>%
      left_join(., hold_cow) -> data

    return(data)

  } else if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "gw") {

    gw_mindist %>%
      rename(gwcode1 = .data$gwcode2,
             gwcode2 = .data$gwcode1) %>%
      bind_rows(gw_mindist, .) -> hold_gw

    data %>%
      left_join(., hold_gw) -> data

    return(data)

  } else {

    stop("add_minimum_distance() requires either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
  }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      cow_mindist %>%
        group_by(.data$ccode1, .data$year) %>%
        summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
        ungroup()  %>%
        rename(ccode = .data$ccode1) %>%
        left_join(data, .) -> data

      return(data)

    } else if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "gw") {

      gw_mindist %>%
        group_by(.data$gwcode1, .data$year) %>%
        summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
        ungroup()  %>%
        rename(gwcode = .data$gwcode1) %>%
        left_join(data, .) -> data

      return(data)

    } else {

      stop("add_minimum_distance() requires either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
    }

  } else {

    stop("add_minimum_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }

}




