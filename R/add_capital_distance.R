#' Add capital-to-capital distance to a dyad-year or state-year data frame
#'
#' @description \code{add_capital_distance()} allows you to add capital-to-capital
#' distance to a dyad-year or state-year data frame. The capitals are coded in the \code{capitals}
#' data frame, along with their latitudes and longitudes. The distance variable that
#' emerges \code{capdist} is calculated using the "Vincenty" method (i.e. "as the crow
#' flies") and is expressed in kilometers.
#'
#' @return \code{add_capital_distance()} takes a dyad-year or state-year data frame and adds the
#' capital-to-capital distance between the first state and the second state (in dyad-year data) or the minimum
#' capital-to-capital distance for a given state in a given year. A minor
#' note about this function: cases of capital transition are recorded in the
#' \code{capitals} data but, in the conversion to capital-years (and eventual
#' merging into a dyad-year data frame), the Jan. 1 capital is used for calculating
#' distances.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or state-year data frame
#'
#' @examples
#'
#' library(magrittr)
#' library(peacesciencer)
#' cow_ddy %>% add_capital_distance()
#'
#' create_stateyears() %>% add_capital_distance()
#'
#' @importFrom rlang .data
#' @importFrom rlang .env

add_capital_distance <- function(data) {
  # require(dplyr)
  # require(magrittr)
  # require(dplyr)
  # require(tidyr)
  # require(lubridate)
  # require(geosphere)
  capitals %>% rowwise() %>%
    mutate(year = list(seq(.data$styear, .data$endyear))) %>%
    unnest(.data$year) %>%
    select(.data$ccode, .data$year, .data$lat, .data$lng) %>%
    # There will be duplicates for when the country moved.
    # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
    group_by(ccode, year) %>% slice(1) %>% ungroup() -> capital_years

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
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

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
    cow_ddy %>%
      left_join(., capital_years %>% select(ccode, year, lat,lng), by=c("ccode1"="ccode","year"="year")) %>%
      rename(lat1 = lat,
             lng1 = lng) %>%
      left_join(., capital_years %>% select(ccode, year, lat,lng), by=c("ccode2"="ccode","year"="year")) %>%
      rename(lat2 = lat,
             lng2 = lng) -> hold_this

    latlng1 <- hold_this %>% select(lng1, lat1)
    latlng2 <- hold_this %>% select(lng2, lat2)
    hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
    hold_this %>% select(-lat1, -lng1, -lat2, -lng2) -> hold_this

    hold_this %>% group_by(ccode1, year) %>%
      summarize(mincapdist = min(capdist)) %>% ungroup() %>%
      rename(ccode = ccode1) %>%
      left_join(data, .) -> data

    return(data)

  } else  {
    stop("add_capital_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

    }

}
