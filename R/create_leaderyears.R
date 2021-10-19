#' Create leader-years from leader data
#'
#' @description \code{create_leaderyears()} allows you to generate leader-year data from
#' leader-level data provided in \pkg{peacesciencer}
#'
#' @return \code{create_leaderyears()} takes leader-level data available in \pkg{peacesciencer}
#' and returns a leader-year-level data frame.
#'
#' @details \code{create_leaderyears()}, as of writing, only supports the Archigos data set of leaders. Importantly:
#' the absence of much leader-level covariates (of which I am aware) means, for now, the data that are returned are
#' treated as observationally equivalent to state-year data. Users should be careful here, but it does mean the data
#' will work with other functions in \pkg{peacesciencer} that have support for state-year data (e.g. \code{add_nmc()},
#' \code{add_rugged_terrain()}). This is declared in the attribute field.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @param system a leader system with which to create leader-years. Right now, only "archigos" is supported.
#'
#' @examples
#' \donttest{
#' create_leaderyears()
#' }
#'
create_leaderyears <- function(system = "archigos") {

  if (system == "archigos") {

    archigos %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
      unnest(.data$date) %>%
      mutate(year = .pshf_year(.data$date)) %>%
      group_by(.data$ccode, .data$leadid, .data$year) %>%
      slice(1) %>% ungroup() -> data

    attr(data, "ps_data_type") = "leader_year"
    attr(data, "ps_system") = "cow"

    return(data)

  } else if(system != "archigos") {

    stop("Right now, only the Archigos leader data are supported.")

  }

  return(data)
}
