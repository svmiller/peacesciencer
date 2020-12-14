#' Create dyad-years from state system membership data
#'
#' @description \code{create_dyadyears()} allows you to dyad-year data from
#' either the Correlates of War (\code{CoW}) state system membership data or the
#' Gleditsch-Ward (\code{gw}) system membership data. The function leans on internal
#' data provided in the package.
#'
#' @return \code{create_dyadyears()} takes state system membership data provided
#' by either Correlates of War or Gleditsch-Ward and returns a dyad-year data frame.
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
#' @param directed optional, defaults to TRUE. If TRUE, the function returns so-called
#' "directed" dyad-year data. In directed dyad-year data, France-Germany (220-255) and
#' Germany-France (255-220) are observationally different. If FALSE, the function returns
#' non-directed data. In non-directed data, France-Germany and Germany-France in the same year
#' are the same observation. The standard here is to drop cases where the country code for the
#' second observation is less than the country code for the first observation.
#'
#' @examples
#' # CoW is default, will include years beyond 2016 (most recent CoW update)
#' create_dyadyears()
#'
#' # Gleditsch-Ward, include most recent years
#' create_dyadyears(system="gw")
#'
#' # Gleditsch-Ward, don't include most recent years
#' create_stateyears(system="gw", mry=FALSE)
#'
#' # Gleditsch-Ward, don't include most recent years, directed = FALSE
#' create_stateyears(system="gw", mry=FALSE, directed = FALSE)
#'
#'
create_dyadyears <- function(system = "cow", mry = TRUE, directed = TRUE) {
  require(dplyr)
  require(magrittr)
  require(dplyr)
  require(tidyr)
  require(lubridate)
  if (system == "cow") {
    if (mry == TRUE) {
      mry <- as.numeric(format(Sys.Date(), "%Y"))-1
      cow_states$endyear = ifelse(cow_states$endyear == max(cow_states$endyear), mry, cow_states$endyear)
      max_endyear <- max(cow_states$endyear)
    } else {
      max_endyear <- max(cow_states$endyear)
    }
    cow_states %>%
      # Select just the stuff we need
      select(ccode, styear, endyear) %>%
      # Expand the data, create two ccodes as well
      expand(ccode1=ccode, ccode2=ccode, year=seq(1816,max_endyear)) %>%
      # Filter out where ccode1 == ccode2
      filter(ccode1!=ccode2) %>%
      left_join(., cow_states, by=c("ccode1"="ccode")) %>%
      # ...and filter out cases where the years don't align.
      filter(year >= styear & year <= endyear) %>%
      # Get rid of styear and endyear to do it again.
      select(-styear,-endyear) %>%
      # And do it again, this time for ccode2
      left_join(., cow_states, by=c("ccode2"="ccode")) %>%
      # Again, filter out cases where years don't align.
      filter(year >= styear & year <= endyear) %>%
      # And select just what we need.
      select(ccode1, ccode2, year) -> data

    attr(data, "class") = c(class(data), "dyad_year")

    if (directed == TRUE) {

    } else {
      filter(data, ccode2 > ccode1) -> data
    }
    return(data)

    } else if(system == "gw") {
      gw_states$styear <- year(gw_states$startdate)
      if (mry == TRUE) {
        mry <- as.numeric(format(Sys.Date(), "%Y"))-1
        gw_states$endyear = ifelse(year(gw_states$enddate) == max(year(gw_states$enddate)), mry, year(gw_states$enddate))
        max_endyear <- max(gw_states$endyear)
      } else {
        gw_states$endyear <- year(gw_states$enddate)
        max_endyear <- max(gw_states$endyear)
      }
      gw_states %>%
        mutate(styear = year(startdate)) %>%
        # Select just the stuff we need
        select(gwcode, styear, endyear) %>%
        # Expand the data, create two ccodes as well
        expand(gwcode1=gwcode, gwcode2=gwcode, year=seq(1816,max_endyear)) %>%
        # Filter out where ccode1 == ccode2
        filter(gwcode1!=gwcode2) %>%
        left_join(., gw_states, by=c("gwcode1"="gwcode")) %>%
        # ...and filter out cases where the years don't align.
        filter(year >= styear & year <= endyear) %>%
        # Get rid of styear and endyear to do it again.
        select(-styear,-endyear) %>%
        # And do it again, this time for ccode2
        left_join(., gw_states, by=c("gwcode2"="gwcode")) %>%
        # Again, filter out cases where years don't align.
        filter(year >= styear & year <= endyear) %>%
        # And select just what we need.
        select(gwcode1, gwcode2, year) -> data

      attr(data, "class") = c(class(data), "dyad_year")

      if (directed == TRUE) {

      } else {
        filter(data, gwcode2 > gwcode1) -> data
      }
      return(data)

    }

}
