#' Create leader-dyad-years from the Archigos data
#'
#' @description \code{create_leaderdyadyears()} allows you to created leader dyad-year data from the
#' Archigos data first introduced and described by Goemans et al. (2009).
#'
#' @return \code{create_leaderdyadyears()} takes remote data available for separate download
#' and returns a complete leader dyad-year data frame for all leaders, and all possible dyads,
#' from 1870 to 2015.
#'
#' @details This is a *complete* and *universal* leader dyad-year data frame for all possible dyadic
#' leader pairings from 1870 to 2015. This has several implications. First: these data are enormous. The
#' output is over 2 million rows long! Second: the time required to create these data from scratch would
#' take too long for a normal function call. This amounts to an unholy combination of data that are too large
#' for CRAN's disk space restrictions (5 MB) and too time-consuming to do from scratch every time. Thus, the
#' data are pre-generated and stored remotely. Check \code{download_extdata()} for more information.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#'
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years. Gleditsch-Ward is the
#' default.
#' @param directed optional, defaults to TRUE. If TRUE, the function returns so-called
#' "directed" leader dyad-year data. If FALSE, the function returns
#' non-directed data where the state codes for the second leader are all greater than
#' the state codes for the second leader.
#'
#' @examples
#' \dontrun{
#' # download_extdata()
#' # ^ make sure you've run this first.
#' # default is directed
#' create_leaderdyadyears()
#'
#' # non-directed
#' create_leaderdyadyears(directed = FALSE)
#' }
#'
create_leaderdyadyears <- function(directed = TRUE, system = "gw") {

  if (!(system %in% c("cow", "gw"))) {
    stop("create_leaderdyadyears() requires the system argument to be either 'cow' (Correlates of War) or 'gw' (Gleditsch-Ward). Default is 'gw'.")

  }

  if (!file.exists(system.file("extdata", "gw_dir_leader_dyad_years.rds", package="peacesciencer"))) {

    stop("The process of creating these data would take too long for a normal function. Thus, they are pre-generated, stored remotely, and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem.")

  } else {

    if (system == "gw") {

      readRDS(system.file("extdata", "gw_dir_leader_dyad_years.rds", package="peacesciencer")) -> data

      if (directed == FALSE) {

        data %>%
          filter(.data$gwcode1 < .data$gwcode2) -> data

      }
    } else { # Assuming it's CoW.

      readRDS(system.file("extdata", "cow_dir_leader_dyad_years.rds", package="peacesciencer")) -> data

      if (directed == FALSE) {

        data %>%
          filter(.data$ccode1 < .data$ccode2) -> data

      }

    }





  }

  attr(data, "ps_data_type") = "leader_dyad_year"
  if (system == "cow") {
    attr(data, "ps_system") = "cow"
  } else {
    attr(data, "ps_system") = "gw"
  }

  return(data)

}
