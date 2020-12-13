#' Add capital-to-capital distance to a dyad-year data frame
#'
#' @description \code{add_capital_distance()} allows you to add capital-to-capital
#' distance to a dyad-year data frame. The capitals are coded in the \code{capitals}
#' data frame, along with their latitudes and longitudes. The distance variable that
#' emerges \code{capdist} is calculated using the "Vincenty" method (i.e. "as the crow
#' flies") and is expressed in kilometers.
#'
#' @return \code{add_capital_distance()} takes a dyad-year data frame and adds the
#' capital-to-capital distance between the first state and the second state. A minor
#' note about this function: cases of capital transition are recorded in the
#' \code{capitals} data but, in the conversion to capital-years (and eventual
#' merging into a dyad-year data frame), the Jan. 1 capital is used for calculating
#' distances.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @examples
#'
#' library(magrittr)
#' cow_ddy %>% add_capital_distance()
#'
#'

add_capital_distance <- function(data) {
  require(dplyr)
  require(magrittr)
  require(dplyr)
  require(tidyr)
  require(lubridate)
  require(geosphere)
  capitals %>% rowwise() %>%
    mutate(year = list(seq(styear, endyear))) %>%
    unnest(year) %>%
    select(ccode, year, lat, lng) %>%
    # There will be duplicates for when the country moved.
    # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
    group_by(ccode, year) %>% slice(1) %>% ungroup() -> capital_years

  data %>%
    left_join(., capital_years %>% select(ccode, year, lat,lng), by=c("ccode1"="ccode","year"="year")) %>%
    rename(lat1 = lat,
           lng1 = lng) %>%
    left_join(., capital_years %>% select(ccode, year, lat,lng), by=c("ccode2"="ccode","year"="year")) %>%
    rename(lat2 = lat,
           lng2 = lng) -> data

  latlng1 <- data %>% select(lng1, lat1)
  latlng2 <- data %>% select(lng2, lat2)
  data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
  data %>% select(-lat1, -lng1, -lat2, -lng2) -> data
  return(data)

}
