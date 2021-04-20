#' Add minimum distance data to a dyad-year or state-year data frame
#'
#' @description \code{add_minimum_distance()} allows you to add the minimum
#' distance (in kilometers) to a dyad-year or state-year data frame. These estimates
#' are recorded in the \code{cow_mindist} and \code{gw_mindist} data that come with this package. The
#' data are current as of the end of 2015.
#'
#'
#' @return \code{add_minimum_distance()} takes a dyad-year or state-year data frame and adds the
#' minimum distance between the first state and the second state (in dyad-year data) or the minimum
#' minimum (sic) distance for a given state in a given year.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or state-year data frame
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years.
#'
#' @references
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring Country Shapes: The \code{cshapes} Package." \emph{The R Journal} 2(1): 18-24.
#'
#' @examples
#'
#' \donttest{
#'
#' cow_ddy %>% add_minimum_distance()
#'
#' create_dyadyears(system = "gw") %>% add_minimum_distance(system = "gw")
#'
#' create_stateyears(system ="gw") %>% add_minimum_distance(system = "gw")
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'
add_minimum_distance <- function(data, system) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

  if (system == "cow") {
    # Just to deal with all cases, we're going to create a directed version
    cow_mindist %>%
      rename(ccode1 = .data$ccode2,
             ccode2 = .data$ccode1) %>%
      bind_rows(cow_mindist, .) -> hold_cow

    data %>%
      left_join(., hold_cow) -> data

    return(data)

  } else if (system == "gw") {

    gw_mindist %>%
      rename(gwcode1 = .data$gwcode2,
             gwcode2 = .data$gwcode1) %>%
      bind_rows(gw_mindist, .) -> hold_gw

    data %>%
      left_join(., hold_gw) -> data

    return(data)

  } else {

    stop("add_minimum_distance() requires a declaration of either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
  }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (system == "cow") {

      cow_mindist %>%
        group_by(.data$ccode1, .data$year) %>%
        summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
        ungroup()  %>%
        rename(ccode = .data$ccode1) %>%
        left_join(data, .) -> data

      return(data)

    } else if (system == "gw") {

      gw_mindist %>%
        group_by(.data$gwcode1, .data$year) %>%
        summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
        ungroup()  %>%
        rename(gwcode = .data$gwcode1) %>%
        left_join(data, .) -> data

      return(data)

    } else {

      stop("add_minimum_distance() requires a declaration of either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
    }

  } else {

    stop("add_minimum_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }

}




