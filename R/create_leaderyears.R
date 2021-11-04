#' Create leader-years from leader data
#'
#' @description \code{create_leaderyears()} allows you to generate leader-year data from
#' leader-level data provided in \pkg{peacesciencer}
#'
#' @return \code{create_leaderyears()} takes leader-level data available in \pkg{peacesciencer}
#' and returns a leader-year-level data frame. This minimal output contains the observation ID
#' from Archigos, the year, the state code for the leader (i.e. either Correlates of War or Gleditsch-Ward, depending on
#' the \code{standardize} argument),
#' the leader's name in Archigos (if it may help the reader to have that), an approximation of the leader's age,
#' and the year in office for the leader (as a running count, starting at 1).
#'
#' @details \code{create_leaderyears()}, as of writing, only supports the Archigos data set of leaders.
#'
#' Many leader ages are known with precision. Many are not recorded in the Archigos data. Knowing well that years are aggregates
#' of days, the leader age variable that gets returned in this output should be treated as an approximation of the leader's age.
#'
#' Be mindful that leader tenure is calculated *before* any standardization argument. Archigos has some leader entries that precede
#' the state system entry for the state, or otherwise do not coincide with state system dates. For example, Lynden Pindling was
#' in his seventh year as leader of The Bahamas (in various titles) before independence in 1973 (in which he became prime minister).
#' Leader tenure is not tethered to state system dates in situations like this (only the dates recorded in the Archigos data).
#'
#' The leader tenure variable returned here does have the odd effect of potentially misstating leader tenure, or at least
#' making it seem unusual. For example, Jimmy Carter (`USA-1877`) was president in 1977 (year 1), 1978 (year 2), 1979 (year 3),
#' 1980 (year 4), and exited in January 1981 (year 5). Again: years are aggregates of days and it's not evident how else this
#' information should be perfectly communicated with that in mind. Users with some R skills can extract the underlying information
#' from the \code{archigos} data and, perhaps, calculate something like the maximum leader tenure (in days) on either Dec. 31 of
#' the referent year, or leader exit before Dec. 31 that year, or something to that effect. No matter, I think this to at least be
#' a defensible variable to present to the user with those limitations in mind. If the user is interested in leader tenure in a leader-year
#' analysis, this variable should be fine. If the user is interested in something like the effect of a fifth year on some kind of leader
#' behavior, they will want to figure out something else.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Goemans, Henk E., Kristian Skrede Gleditsch, and Giacomo Chiozza. 2009. "Introducing Archigos: A Dataset of Political Leaders"
#' \emph{Journal of Peace Research} 46(2): 269--83.
#'
#' @param system a leader system with which to create leader-years. Right now, only "archigos" is supported.
#' @param standardize a character vector of length one: "cow", "gw", or "none". If "cow", the function standardizes the leader-days to
#' just those that overlap  with state system membership in the Correlates of War state system (see: \code{cow_states}). If "gw", the function
#' standardizes the leader-days to just those that overlap with the state system dates of the Gleditsch-Ward date (see: \code{gw_states}). If
#' "none", the function returns all leader-days as presented in Archigos (which is nominally denominated in Gleditsch-Ward state system codes,
#' if not necessarily Gleditsch-Ward state system dates). Default is "none".
#'
#' @examples
#' \donttest{
#' # standardize = 'none' is default
#' create_leaderyears()
#'
#' create_leaderyears(standardize = 'gw')
#' }
#'
create_leaderyears <- function(system = "archigos", standardize = "none") {

  if (!(standardize %in% c("none", "cow", "gw")) | length(standardize) > 1) {

    stop("The `standardize` argument must be either 'none', 'cow', or 'gw'. Pick just one.")
  }

  if (system == "archigos") {

    archigos %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
      unnest(.data$date) %>%
      mutate(year = .pshf_year(.data$date),
             yrinoffice = (.data$year - .pshf_year(.data$startdate)) + 1) -> leaderdays

    if (standardize == "gw") {

      gw_statedays <- create_statedays(system = 'gw')

      leaderdays %>%
        semi_join(., gw_statedays) %>%
        mutate(leaderage = .data$year - .data$yrborn) %>%
        distinct(.data$obsid,  .data$leader, .data$gwcode, .data$gender, .data$leaderage, .data$year, .data$yrinoffice) -> data

      attr(data, "ps_data_type") = "leader_year"
      attr(data, "ps_system") = "gw"

      # data <- subset(data, select=c("obsid", "gwcode", "leader", "year", "gender", "leaderage", "yrinoffice"))

    } else if (standardize == "cow") {
      # I need to do some ad hoc corrections here
      # There are pieces of the gw_cow_years data frame where G-W says the state doesn't exist but it appears in the CoW data.
      # Because G-W is the "master" here, this is going to happen.
      # The gw_cow_years data would be functionally correct here, but that's immaterial for matching it to the Archigos data.
      # gw_cow_years %>% filter(is.na(gwcode) & year >= 1870) %>% group_by(stateabb) %>% summarize(ccode = max(ccode, na.rm=T), n = n(), min = min(year), max = max(year))
      # For example: G-W have Morocco drop out at 1904. CoW has Morocco drop out at 1912.
      # If you want to standardize to CoW, you're going to miss that.
      # You'll also miss that G-W has Saudi Arabia start in 1932, but CoW has it at 1927.
      # Archigos has leader data for the Saudis to 1927, so you'll want that.

      cow_statedays <- create_statedays()


      leaderdays %>%
        left_join(., gw_cow_years %>% select(.data$gwcode, .data$ccode, .data$year)) %>%
        select(.data$obsid, .data$gwcode, .data$ccode, everything()) -> leaderdays

      leaderdays %>%
        mutate(ccode = case_when(
          .data$gwcode == 600 & (.data$year >= 1905 & .data$year <= 1912) ~ 600,
          .data$gwcode == 670 & (.data$year >= 1927 & .data$year <= 1932) ~ 670,
          TRUE ~ .data$ccode
        )) -> leaderdays

      leaderdays %>%
        semi_join(., cow_statedays)  %>%
        mutate(leaderage = .data$year - .data$yrborn) %>%
        distinct(.data$obsid,  .data$leader, .data$ccode, .data$gender, .data$leaderage, .data$year, .data$yrinoffice) -> data

      attr(data, "ps_data_type") = "leader_year"
      attr(data, "ps_system") = "cow"

      #data <- subset(data, select=c("obsid", "ccode", "leader", "year", "yrinoffice"))

    } else { # assuming standardize = "none"

      leaderdays %>%
        mutate(leaderage = .data$year - .data$yrborn) %>%
        distinct(.data$obsid,  .data$leader, .data$gwcode, .data$gender, .data$leaderage, .data$year, .data$yrinoffice) -> data

      attr(data, "ps_data_type") = "leader_year"
      attr(data, "ps_system") = "gw"

      # data <- subset(data, select=c("obsid", "gwcode", "leader", "year", "yrinoffice"))

    }


  } else if(system != "archigos") {

    stop("Right now, only the Archigos leader data are supported.")

  }

  return(data)
}
