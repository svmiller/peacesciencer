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
#' create_leaderdays(standardize_cow = TRUE)
#' }
#'
create_leaderdays <- function(system = "archigos", standardize_cow = FALSE) {

  if (system == "archigos") {

    archigos %>%
      # rename(gwcode = .data$ccode) %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
      unnest(.data$date) %>%
      mutate(year = .pshf_year(.data$date)) -> leaderdays

    leaderdays <- subset(leaderdays, select=c("obsid", "gwcode", "leader", "year", "date"))

    # I need to do some ad hoc corrections here
    # There are pieces of the gw_cow_years data frame where G-W says the state doesn't exist but it appears in the CoW data.
    # Because G-W is the "master" here, this is going to happen.
    # The gw_cow_years data would be functionally correct here, but that's immaterial for matching it to the Archigos data.
    # gw_cow_years %>% filter(is.na(gwcode) & year >= 1870) %>% group_by(stateabb) %>% summarize(ccode = max(ccode, na.rm=T), n = n(), min = min(year), max = max(year))
    # For example: G-W have Morocco drop out at 1904. CoW has Morocco drop out at 1912.
    # If you want to standardize to CoW, you're going to miss that.
    # You'll also miss that G-W has Saudi Arabia start in 1932, but CoW has it at 1927.
    # Archigos has leader data for the Saudis to 1927, so you'll want that.

    if (standardize_cow == TRUE) {

      leaderdays %>%
        left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) %>%
        select(.data$obsid, .data$gwcode, .data$ccode, everything()) -> leaderdays

      leaderdays %>%
        mutate(ccode = case_when(
          .data$gwcode == 600 & (.data$year >= 1905 & .data$year <= 1912) ~ 600,
          .data$gwcode == 670 & (.data$year >= 1927 & .data$year <= 1932) ~ 670,
          TRUE ~ .data$ccode
        )) -> leaderdays

      cow_states %>%
        mutate(stdate = as.Date(paste0(.data$styear, "/", .data$stmonth, "/", .data$stday)),
               enddate = as.Date(paste0(.data$endyear, "/", .data$endmonth, "/", .data$endday))) %>%
        rowwise() %>%
        mutate(date = list(seq(.data$stdate, .data$enddate, by = "1 day"))) %>%
        unnest(.data$date) %>%
        select(.data$ccode, .data$date) %>%
        # semi-join kinda life, baby, baby...
        semi_join(leaderdays, .) -> data

      data$year <- NULL
      data$gwcode <- NULL


    } else if (standardize_cow == FALSE) {

      leaderdays$year <- NULL

      leaderdays -> data

    }

  } else if(system != "archigos") {

    stop("Right now, only the Archigos leader data are supported.")

  }

  attr(data, "ps_data_type") = "leader_day"
  if (standardize_cow == TRUE) {
    attr(data, "ps_system") = "cow"
  } else {
    attr(data, "ps_system") = "gw"
  }

  return(data)
}
