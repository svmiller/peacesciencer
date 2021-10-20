#' Create leader-days from leader data
#'
#' @description \code{create_leaderdays()} allows you to generate leader-day data from
#' leader-level data provided in \pkg{peacesciencer}.
#'
#' @return \code{create_leaderdays()} takes leader-level data available in \pkg{peacesciencer}
#' and returns a leader-day-level data frame.
#'
#' @details \code{create_leaderdays()}, as of writing, only supports the Archigos data set of leaders. I envision this function
#' being mostly for internal uses. Basically, \code{create_leaderyears()} effectively starts by first running a version of
#' \code{create_leaderdays()}. So, why not have this function too?
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @param system a leader system with which to create leader-days. Right now, only "archigos" is supported.
#' @param standardize_cow logical, defaults to TRUE. If TRUE, the function standardizes the leader-days to just those that
#' overlap  with state system membership in the Correlates of War state system (see: \code{cow_states}). If FALSE, the function
#' returns all leader-days as implied by the Archigos data.
#'
#' @examples
#' \donttest{
#' create_leaderdays()
#'
#' create_leaderdays(standardize_cow = FALSE)
#' }
#'
create_leaderdays <- function(system = "archigos", standardize_cow = TRUE) {

  if (system == "archigos") {

    archigos %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
      unnest(.data$date) -> leaderdays

    if (standardize_cow == TRUE) {

      cow_states %>%
        mutate(stdate = as.Date(paste0(.data$styear, "/", .data$stmonth, "/", .data$stday)),
               enddate = as.Date(paste0(.data$endyear, "/", .data$endmonth, "/", .data$endday))) %>%
        rowwise() %>%
        mutate(date = list(seq(.data$stdate, .data$enddate, by = "1 day"))) %>%
        unnest(.data$date) %>%
        select(.data$ccode, .data$date) %>%
        # semi-join kinda life, baby, baby...
        semi_join(leaderdays, .) -> data


    } else if (standardize_cow == FALSE) {

      leaderdays -> data

    }

  } else if(system != "archigos") {

    stop("Right now, only the Archigos leader data are supported.")

  }

  attr(data, "ps_data_type") = "leader_day"
  attr(data, "ps_system") = "cow"

  return(data)
}
