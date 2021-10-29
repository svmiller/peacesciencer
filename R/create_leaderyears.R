#' Create leader-years from leader data
#'
#' @description \code{create_leaderyears()} allows you to generate leader-year data from
#' leader-level data provided in \pkg{peacesciencer}
#'
#' @return \code{create_leaderyears()} takes leader-level data available in \pkg{peacesciencer}
#' and returns a leader-year-level data frame. This minimal output contains the observation ID
#' from Archigos, the year, the Correlates of War state code for the leader (i.e. leaders are nested in states),
#' the leader's name in Archigos (if it may help the reader to have that), an approximation of the leader's age,
#' and the year in office for the leader (as a running count, starting at 1).
#'
#' @details \code{create_leaderyears()}, as of writing, only supports the Archigos data set of leaders. Importantly:
#' the absence of much leader-level covariates (of which I am aware) means, for now, the data that are returned are
#' treated as observationally equivalent to state-year data. Users should be careful here, but it does mean the data
#' will work with other functions in \pkg{peacesciencer} that have support for state-year data (e.g. \code{add_nmc()},
#' \code{add_rugged_terrain()}). This is declared in the attribute field.
#'
#' Many leader ages are known with precision. Many are not recorded in the Archigos data. Knowing well that years are aggregates
#' of days, the leader age variable that gets returned in this output should be treated as an approximation of the leader's age.
#'
#' If `standardize_cow = FALSE`, the leader-year data are returned with an internal attribute declaring these to be Gleditsch-Ward
#' system data. This is because the Archigos data are nominally denominated in the Gleditsch-Ward system. If `standardize_cow = TRUE`, the
#' leader-year data are returned with an attribute that declares them to be Correlates of War state system data. This attribute matters
#' for the other functions in \pkg{peacesciencer} that merge in other data sets. Think carefully about what you want here. The default option
#' is `standardize_cow = FALSE`.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @param system a leader system with which to create leader-years. Right now, only "archigos" is supported.
#' @param standardize_cow logical, defaults to FALSE. If TRUE, the function standardizes the leader years to just those that
#' overlap  with state system membership in the Correlates of War state system (see: \code{cow_states}). If FALSE, the function
#' returns all leader-years as implied by the Archigos data.
#'
#' @examples
#' \donttest{
#' create_leaderyears()
#'
#' create_leaderyears(standardize_cow = FALSE)
#' }
#'
create_leaderyears <- function(system = "archigos", standardize_cow = FALSE) {

  if (system == "archigos") {

    archigos %>%
      # rename(gwcode = .data$ccode) %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
      unnest(.data$date) %>%
      mutate(year = .pshf_year(.data$date)) -> leaderdays

    leaderdays %>%
      left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) %>%
      select(.data$obsid, .data$gwcode, .data$ccode, everything()) -> leaderdays

    if (standardize_cow == TRUE) {

      cow_states %>%
        mutate(stdate = as.Date(paste0(.data$styear, "/", .data$stmonth, "/", .data$stday)),
               enddate = as.Date(paste0(.data$endyear, "/", .data$endmonth, "/", .data$endday))) %>%
        rowwise() %>%
        mutate(date = list(seq(.data$stdate, .data$enddate, by = "1 day"))) %>%
        unnest(.data$date) %>%
        select(.data$ccode, .data$date) %>%
        # semi-join kinda life, baby, baby...
        semi_join(leaderdays, .) -> hold_this

      hold_this %>%
       # mutate(year = .pshf_year(.data$date)) %>%
        group_by(.data$ccode, .data$obsid, .data$year) %>%
        slice(1) %>% ungroup() -> data




    } else { # You want G-W data...

      leaderdays %>%
        mutate(year = .pshf_year(.data$date)) %>%
        group_by(.data$gwcode, .data$obsid, .data$year) %>%
        slice(1) %>% ungroup() -> data



    }


  } else if(system != "archigos") {

    stop("Right now, only the Archigos leader data are supported.")

  }

  data %>%
    mutate(leaderage = .data$year - .data$yrborn) %>%
    group_by(.data$obsid) %>%
    mutate(yrinoffice = 1:n()) %>%
    ungroup() -> data

  data <- subset(data, select=c("obsid", "year", "gwcode", "ccode", "leader", "gender", "leaderage", "yrinoffice"))

  attr(data, "ps_data_type") = "leader_year"

  if (standardize_cow == TRUE) {
    attr(data, "ps_system") = "cow"
    data$gwcode <- NULL
  } else {
    attr(data, "ps_system") = "gw"
    data$ccode <- NULL
  }


  return(data)
}
