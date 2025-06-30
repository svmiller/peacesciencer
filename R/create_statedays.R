#' Create state-days from state system membership data
#'
#' @description \code{create_statedays()} allows you to create state-day data from
#' either the Correlates of War (CoW) state system membership data or the
#' Gleditsch-Ward (gw) system membership data. The function leans on internal
#' data provided in the package.
#'
#' @return \code{create_statedays()} takes state system membership data provided
#' by either Correlates of War or Gleditsch-Ward and returns a simple state-day
#' data frame.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Miller, Steven V. 2019. ``Create Country-Year and (Non)-Directed Dyad-Year
#' Data With Just a Few Lines in R''
#' \url{https://svmiller.com/blog/2019/01/create-country-year-dyad-year-from-country-data/}
#'
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years. Correlates of War
#' is the default.
#' @param mry optional, defaults to TRUE. If TRUE, the function extends the
#' script beyond the most recent system membership updates to include observation
#' to the most recently concluded calendar year. For example, the Gleditsch-Ward
#' data extend to the end of 2017. When \code{mry == TRUE}, the function returns
#' more recent years (e.g. 2018, 2019) under the assumption that states alive
#' at the end of 2017 are still alive today. Use with some care.
#'
#' @examples
#' \donttest{
#'
#' # CoW is default, will include years beyond 2016 (most recent CoW update)
#' create_statedays()
#'
#' # Gleditsch-Ward, include most recent years
#' create_statedays(system="gw")
#'
#' # Gleditsch-Ward, don't include most recent years
#' create_statedays(system="gw", mry=FALSE)
#' }
#'
#'
create_statedays <- function(system = "cow", mry = TRUE) {

  if (system == "cow") {
    if (mry == TRUE) {
      mry <- as.numeric(format(Sys.Date(), "%Y"))-1
      cow_states$endyear2 = ifelse(cow_states$endyear == max(cow_states$endyear), mry, cow_states$endyear)
    } else {
      cow_states$endyear2 <- cow_states$endyear
    }

    cow_states %>%
      mutate(stdate = as.Date(paste0(.data$styear,"/", .data$stmonth,"/", .data$stday)),
             enddate = as.Date(paste0(.data$endyear2, "/", .data$endmonth,"/",.data$endday))) %>%
      rowwise() %>%
      mutate(date = list(seq(.data$stdate, .data$enddate, by = '1 day'))) %>%
      unnest(date) %>%
      select(.data$ccode, .data$statenme, .data$date) -> data

    attr(data, "ps_data_type") = "state_day"
    attr(data, "ps_system") = "cow"

    return(data)

  } else if(system == "gw") {
    if (mry == TRUE) {
      gw_states$enddate2 = if_else(.pshf_year(gw_states$enddate) == max(.pshf_year(gw_states$enddate)),
                                   as.Date(paste0(as.numeric(format(Sys.Date(), "%Y"))-1,"/12/31")),
                                   gw_states$enddate)
    } else {
      gw_states$enddate2 <- gw_states$enddate
    }

    gw_states %>%
      mutate(.data$enddate) %>%
      rowwise() %>%
      mutate(date = list(seq(.data$startdate, .data$enddate2, by = '1 day')))  %>%
      unnest(c(date)) %>%
      arrange(.data$gwcode, .data$date) %>%
      select(.data$gwcode, .data$statename, .data$date)  %>%
      distinct(.data$gwcode, .data$statename, .data$date)  -> data

    attr(data, "ps_data_type") = "state_day"
    attr(data, "ps_system") = "gw"

    return(data)

  }
}
