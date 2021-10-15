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
#' output is over 2.4 million rows long! Second: the time required to create these data from scratch would
#' take too long for a normal function call. This amounts to an unholy combination of data that are too large
#' for CRAN's disk space restrictions (5 MB) and too time-consuming to do from scratch every time. Thus, the
#' data are pre-generated and stored remotely. Check \code{download_extdata()} for more information.
#'
#' For now, these data are treated as dyad-year data (check the attributes) so that other functions can work with it.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#'
#' @param directed optional, defaults to TRUE. If TRUE, the function returns so-called
#' "directed" leader dyad-year data. If FALSE, the function returns
#' non-directed data. The standard here is to drop cases where the country code for the
#' second observation is less than the country code for the first observation.
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
create_leaderdyadyears <- function(directed = TRUE) {

  if (!file.exists(system.file("extdata", "dir_leader_dyad_years.rds", package="peacesciencer"))) {

    stop("The process of creating these data would take too long for a normal function. Thus, they are pre-generated, stored remotely, and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem.")

  } else {

    readRDS(system.file("extdata", "dir_leader_dyad_years.rds", package="peacesciencer")) %>%
      select(-.data$startdate1, -.data$enddate1, -.data$startdate2, -.data$enddate2) -> data

    if (directed == FALSE) {

      data %>%
        filter(.data$ccode1 < .data$ccode2) -> data

    }

  }

  attr(data, "ps_data_type") = "dyad_year"
  attr(data, "ps_system") = "cow"

  return(data)

}
