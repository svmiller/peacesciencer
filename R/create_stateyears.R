#' Create state-years from state system membership data
#'
#' @description \code{create_stateyears()} allows you to country-year data from
#' either the Correlates of War (\code{CoW}) state system membership data or the
#' Gleditsch-Ward (\code{gw}) system membership data. The function leans on internal
#' data provided in the package.
#'
#' @return \code{create_stateyears()} takes state system membership data provided
#' by either Correlates of War or Gleditsch-Ward and returns a simple state-year
#' data frame.
#'
#' @author Steven V. Miller
#'
#' @references Miller, Steven V. 2019. ``Create Country-Year and (Non)-Directed Dyad-Year Data With Just a Few Lines in R''
#' \url{http://svmiller.com/blog/2019/01/create-country-year-dyad-year-from-country-data/}
#'
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years. Correlates of War is the
#' default.
#' @param mry optional, defaults to TRUE. If TRUE, the function extends the script
#' beyond the most recent system membership updates to include observation to the
#' most recently concluded calendar year. For example, the Gleditsch-Ward data extend
#' to the end of 2017. When \code{mry == TRUE}, the function returns more recent years
#' (e.g. 2018, 2019) under the assumption that states alive at the end of 2017 are still alive
#' today. Use with some care.
#'
#' @examples
#' library(peacesciencer)
#'
#' # CoW is default, will include years beyond 2016 (most recent CoW update)
#' create_stateyears()
#'
#' # Gleditsch-Ward, include most recent years
#' create_stateyears(system="gw")
#'
#' # Gleditsch-Ward, don't include most recent years
#' create_stateyears(system="gw", mry=FALSE)
#'
#'
create_stateyears <- function(system = "cow", mry = TRUE) {

  if (system == "cow") {
    if (mry == TRUE) {
      mry <- as.numeric(format(Sys.Date(), "%Y"))-1
      cow_states$endyear2 = ifelse(cow_states$endyear == max(cow_states$endyear), mry, cow_states$endyear)
    } else {
      cow_states$endyear2 <- cow_states$endyear
    }

    cow_states %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear2))) %>%
      unnest(c(year)) %>%
      arrange(.data$ccode, .data$year) %>%
      select(.data$ccode, .data$statenme, .data$year) %>%
      distinct(.data$ccode, .data$statenme, .data$year) -> data

    attr(data, "ps_data_type") = "state_year"

    return(data)

  } else if(system == "gw") {
    if (mry == TRUE) {
      mry <- as.numeric(format(Sys.Date(), "%Y"))-1
      gw_states$endyear = ifelse(year(gw_states$enddate) == max(year(gw_states$enddate)), mry, year(gw_states$enddate))
    } else {
      gw_states$endyear <- year(gw_states$enddate)
    }
    gw_states %>%
      mutate(styear = year(.data$startdate)) %>%
      rowwise() %>%
      mutate(year = list(seq(.data$styear, .data$endyear))) %>%
      unnest(c(year)) %>%
      arrange(.data$gwcode, .data$year) %>%
      select(.data$gwcode, .data$statename, .data$year)  %>%
      distinct(.data$gwcode, .data$statename, .data$year)  -> data

    attr(data, "ps_data_type") = "state_year"

    return(data)

  }
}
