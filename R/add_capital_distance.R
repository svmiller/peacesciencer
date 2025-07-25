#' Add capital-to-capital distance to a data frame
#'
#' @description `add_capital_distance()` allows you to add capital-to-capital
#' distance to a (dyad-year, state-year) data frame. The distance variable that
#' emerges (`capdist`) is calculated using the "Vincenty" method (i.e. "as the
#' crow flies") and is expressed in kilometers.
#'
#' @return
#'
#' `add_capital_distance()` takes a (dyad-year, state-year) data frame and
#' adds the capital-to-capital distance between the first state and the second
#' state (in dyad-year data) or the minimum capital-to-capital distance for a
#' given state in a given year.
#'
#' @details
#'
#' The function leans on attributes of the data that are provided by one of the
#' "create" functions in this package (e.g. [create_dyadyears()] or
#' [create_stateyears()]).
#'
#' Be advised that "jan1" and "dec31" are alternate specifications for
#' "first" and "last" respectively and exist as kind of a nudge for what you
#' want to conceptualize the inputs for your year to be what is observed at its
#' start or at its end. Obviously, there was no Jan. 1, 1954 or Dec. 31, 1875
#' for the Republic of Vietnam.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param transsum a character vector with one of the following acceptable
#' inputs: "first" ("jan1") or "last" ("dec31"). Determines what to do for a
#' yearly summary in the case of a capital transition. "first" ("jan1") selects
#' the first capital coordinate observed in a given year while "last" ("dec31")
#' selects the last capital coordinate observed in a given year. Default is
#' "first" ("jan1"). See details section for more.
#' @param ... optional, only to make the shortcut (`add_cap_dist()`) work
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_capital_distance()
#'
#' create_stateyears() %>% add_capital_distance()
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'



#
# add_capital_distance <- function(data) {
#
#   cow_capitals %>% rowwise() %>%
#     mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#     unnest(.data$year) %>%
#     select(.data$ccode, .data$year, .data$lat, .data$lng) %>%
#     # There will be duplicates for when the country moved.
#     # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
#     group_by(.data$ccode, .data$year) %>% slice(1) %>% ungroup() -> capital_years
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_capital_distance() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#     data %>%
#       left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
#       rename(lat1 = .data$lat,
#              lng1 = .data$lng) %>%
#       left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
#       rename(lat2 = .data$lat,
#              lng2 = .data$lng) -> data
#
#     latlng1 <- data %>% select(.data$lng1, .data$lat1)
#     latlng2 <- data %>% select(.data$lng2, .data$lat2)
#     data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#     data %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> data
#
#   return(data)
#     }
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
#     if (!all(i <- c("ccode") %in% colnames(data))) {
#
#       stop("add_capital_distance() merges on Correlates of War codes (ccode1, ccode2 for dyad-year data, ccode for state-year), which your data don't have right now. Make sure to run create_dyadyears() or create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#     cow_ddy %>%
#       left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
#       rename(lat1 = .data$lat,
#              lng1 = .data$lng) %>%
#       left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
#       rename(lat2 = .data$lat,
#              lng2 = .data$lng) -> hold_this
#
#     latlng1 <- hold_this %>% select(.data$lng1, .data$lat1)
#     latlng2 <- hold_this %>% select(.data$lng2, .data$lat2)
#     hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#     hold_this %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> hold_this
#
#     hold_this %>% group_by(.data$ccode1, .data$year) %>%
#       summarize(mincapdist = min(.data$capdist)) %>% ungroup() %>%
#       rename(ccode = .data$ccode1) %>%
#       left_join(data, .) -> data
#
#     return(data)
#
#     }
#
#   } else  {
#     stop("add_capital_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#
#     }
#
# }

add_capital_distance <- function(data, transsum = "first") {

  if(length(transsum) > 1 || !transsum %in% c("first", "jan1", "last", "dec31")) {
    stop("transsum must be one of 'first', 'jan1', 'last', or 'dec31'. Specify only one. 'jan1' and 'dec31' are alternate ways of specifying 'first' and 'last'.")
  }

  ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  system_type <- paste0(ps_system, "_", ps_type)

  dispatch <- list(
    cow_state_year = .add_cap_dist_cow_state_year,
    gw_state_year = .add_cap_dist_gw_state_year,
    gw_dyad_year = .add_cap_dist_gw_dyad_year,
    cow_dyad_year = .add_cap_dist_cow_dyad_year
  )

  if (!system_type %in% names(dispatch)) {

    stop("Unsupported combination of ps_system and ps_data_type. System must be 'cow' or 'gw' and the data type must be 'dyad_year', `leader_dyad_year`, or 'state_year'.")

  }

  data <- dispatch[[system_type]](data, transsum)

  return(data)

}

#' @keywords internal
#' @noRd
.capdays <- function(system = c("cow", "gw")) {

  if (system == "cow") {

  dayos <- Map(seq, cow_capitals$stdate, cow_capitals$enddate, by = '1 day')

  rows <- rep(seq_len(nrow(cow_capitals)), lengths(dayos))

  x <- data.frame(
    ccode = cow_capitals$ccode[rows],
    capital = cow_capitals$capital[rows],
    date = do.call("c",dayos),
    lat = cow_capitals$lat[rows],
    lng = cow_capitals$lng[rows]
  )

  x <- x[order(x$ccode, x$date), ]
  class(x) <- c("tbl_df", "tbl", class(x))

  } else { # system = 'gw'

    dayos <- Map(seq, gw_capitals$stdate, gw_capitals$enddate, by = '1 day')

    rows <- rep(seq_len(nrow(gw_capitals)), lengths(dayos))

    x <- data.frame(
      gwcode = gw_capitals$gwcode[rows],
      capital = gw_capitals$capital[rows],
      date = do.call("c",dayos),
      lat = gw_capitals$lat[rows],
      lng = gw_capitals$lng[rows]
    )

    x <- x[order(x$gwcode, x$date), ]
    class(x) <- c("tbl_df", "tbl", class(x))

  }

  return(x)

}

#' @keywords internal
#' @noRd
.capyears <- function(system = c("cow", "gw")) {

  if (system == "cow") {

    ylist <- Map(seq, cow_capitals$styear, cow_capitals$endyear)

    rows <- rep(seq_len(nrow(cow_capitals)), lengths(ylist))

    x <- data.frame(
      ccode = cow_capitals$ccode[rows],
      year = unlist(ylist),
      lat = cow_capitals$lat[rows],
      lng = cow_capitals$lng[rows]
    )

    x <- x[order(x$ccode, x$year), ]
    class(x) <- c("tbl_df", "tbl", class(x))


  } else {

    ylist <- Map(seq, gw_capitals$styear, gw_capitals$endyear)

    rows <- rep(seq_len(nrow(gw_capitals)), lengths(ylist))

    x <- data.frame(
      gwcode = gw_capitals$gwcode[rows],
      year = unlist(ylist),
      lat = gw_capitals$lat[rows],
      lng = gw_capitals$lng[rows]
    )

      x <- x[order(x$gwcode, x$year), ]
      class(x) <- c("tbl_df", "tbl", class(x))

  }

  return(x)

}


#' @keywords internal
#' @noRd
.add_cap_dist_cow_state_year <- function(data, transsum) {

  # recall this going to be minimum distance for a given state. I don't know the
  # value of this information for a given, boilerplate project, but it's not
  # hard to do.

  capdys <- .capdays(system = 'cow')
  capdys$year <- as.POSIXlt(capdys$date)$year + 1900

  if(transsum %in% c("first", "jan1")) {

    capdys %>%
      slice(1, .by=c(.data$ccode, .data$year)) -> capdyslice

  } else if(transsum %in% c("last", "dec31")) {

    capdys %>%
      slice(n(), .by=c(.data$ccode, .data$year)) -> capdyslice

  }

  cow_ddy %>%
    left_join(., capdyslice %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
    rename(lat1 = .data$lat,
           lng1 = .data$lng)  %>%
    left_join(., capdyslice %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
    rename(lat2 = .data$lat,
           lng2 = .data$lng) -> hold_this

  latlng1 <- hold_this %>% select(.data$lng1, .data$lat1)
  latlng2 <- hold_this %>% select(.data$lng2, .data$lat2)
  hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
  hold_this %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> hold_this

  hold_this %>%
    group_by(.data$ccode1, .data$year) %>%
    summarize(mincapdist = min(.data$capdist, na.rm=TRUE)) %>% ungroup() %>%
    rename(ccode = .data$ccode1) %>%
    left_join(data, .) -> data

}


#' @keywords internal
#' @noRd
.add_cap_dist_gw_state_year <- function(data, transsum) {

  # recall this going to be minimum distance for a given state. I don't know the
  # value of this information for a given, boilerplate project, but it's not
  # hard to do.

  capdys <- .capdays(system = 'gw')
  capdys$year <- as.POSIXlt(capdys$date)$year + 1900

  if(transsum %in% c("first", "jan1")) {

    capdys %>%
      slice(1, .by=c(.data$gwcode, .data$year)) -> capdyslice

  } else if(transsum %in% c("last", "dec31")) {

    capdys %>%
      slice(n(), .by=c(.data$gwcode, .data$year)) -> capdyslice

  }

  gw_ddy %>%
    left_join(., capdyslice %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode1"="gwcode","year"="year")) %>%
    rename(lat1 = .data$lat,
           lng1 = .data$lng)  %>%
    left_join(., capdyslice %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode2"="gwcode","year"="year")) %>%
    rename(lat2 = .data$lat,
           lng2 = .data$lng) -> hold_this

  latlng1 <- hold_this %>% select(.data$lng1, .data$lat1)
  latlng2 <- hold_this %>% select(.data$lng2, .data$lat2)
  hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
  hold_this %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> hold_this

  hold_this %>%
    group_by(.data$gwcode1, .data$year) %>%
    summarize(mincapdist = min(.data$capdist, na.rm=TRUE)) %>%
    ungroup() %>%
    rename(gwcode = .data$gwcode1) %>%
    left_join(data, .) -> data

}

#' @keywords internal
#' @noRd
.add_cap_dist_gw_dyad_year <- function(data, transsum) {

  # recall this going to be minimum distance for a given state. I don't know the
  # value of this information for a given, boilerplate project, but it's not
  # hard to do.

  capdys <- .capdays(system = 'gw')
  capdys$year <- as.POSIXlt(capdys$date)$year + 1900

  if(transsum %in% c("first", "jan1")) {

    capdys %>%
      slice(1, .by=c(.data$gwcode, .data$year)) -> capdyslice

  } else if(transsum %in% c("last", "dec31")) {

    capdys %>%
      slice(n(), .by=c(.data$gwcode, .data$year)) -> capdyslice

  }

  data %>%
    left_join(., capdyslice %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode1"="gwcode","year"="year")) %>%
    rename(lat1 = .data$lat,
           lng1 = .data$lng) %>%
    left_join(., capdyslice %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode2"="gwcode","year"="year")) %>%
    rename(lat2 = .data$lat,
           lng2 = .data$lng) -> data

  latlng1 <- data %>% select(.data$lng1, .data$lat1)
  latlng2 <- data %>% select(.data$lng2, .data$lat2)
  data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
  data %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> data


}

#' @keywords internal
#' @noRd
.add_cap_dist_cow_dyad_year <- function(data, transsum) {

  # recall this going to be minimum distance for a given state. I don't know the
  # value of this information for a given, boilerplate project, but it's not
  # hard to do.

  capdys <- .capdays(system = 'cow')
  capdys$year <- as.POSIXlt(capdys$date)$year + 1900

  if(transsum %in% c("first", "jan1")) {

    capdys %>%
      slice(1, .by=c(.data$ccode, .data$year)) -> capdyslice

  } else if(transsum %in% c("last", "dec31")) {

    capdys %>%
      slice(n(), .by=c(.data$ccode, .data$year)) -> capdyslice

  }

  data %>%
    left_join(., capdyslice %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
    rename(lat1 = .data$lat,
           lng1 = .data$lng) %>%
    left_join(., capdyslice %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
    rename(lat2 = .data$lat,
           lng2 = .data$lng) -> data

  latlng1 <- data %>% select(.data$lng1, .data$lat1)
  latlng2 <- data %>% select(.data$lng2, .data$lat2)
  data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
  data %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> data


}








#' @rdname add_capital_distance
#' @export

add_cap_dist <- function(...) peacesciencer::add_capital_distance(...)











# add_capital_distance <- function(data) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#     if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#
#       cow_capitals %>% rowwise() %>%
#         mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#         unnest(.data$year) %>%
#         select(.data$ccode, .data$year, .data$lat, .data$lng) %>%
#         # There will be duplicates for when the country moved.
#         # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
#         group_by(.data$ccode, .data$year) %>% slice(1) %>% ungroup() -> capital_years
#
#       data %>%
#         left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
#         rename(lat1 = .data$lat,
#                lng1 = .data$lng) %>%
#         left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
#         rename(lat2 = .data$lat,
#                lng2 = .data$lng) -> data
#
#       latlng1 <- data %>% select(.data$lng1, .data$lat1)
#       latlng2 <- data %>% select(.data$lng2, .data$lat2)
#       data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#       data %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> data
#
#       return(data)
#
#     } else { # Assuming it's G-W system
#
#       gw_capitals %>% rowwise() %>%
#         mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#         unnest(.data$year) %>%
#         select(.data$gwcode, .data$year, .data$lat, .data$lng) %>%
#         # There will be duplicates for when the country moved.
#         # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
#         group_by(.data$gwcode, .data$year) %>% slice(1) %>% ungroup() -> capital_years
#
#       data %>%
#         left_join(., capital_years %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode1"="gwcode","year"="year")) %>%
#         rename(lat1 = .data$lat,
#                lng1 = .data$lng) %>%
#         left_join(., capital_years %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode2"="gwcode","year"="year")) %>%
#         rename(lat2 = .data$lat,
#                lng2 = .data$lng) -> data
#
#       latlng1 <- data %>% select(.data$lng1, .data$lat1)
#       latlng2 <- data %>% select(.data$lng2, .data$lat2)
#       data$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#       data %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> data
#
#       return(data)
#
#     }
#
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#
#       cow_capitals %>% rowwise() %>%
#         mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#         unnest(.data$year) %>%
#         select(.data$ccode, .data$year, .data$lat, .data$lng) %>%
#         # There will be duplicates for when the country moved.
#         # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
#         group_by(.data$ccode, .data$year) %>% slice(1) %>% ungroup() -> capital_years
#
#       cow_ddy %>%
#         left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode1"="ccode","year"="year")) %>%
#         rename(lat1 = .data$lat,
#                lng1 = .data$lng) %>%
#         left_join(., capital_years %>% select(.data$ccode, .data$year, .data$lat, .data$lng), by=c("ccode2"="ccode","year"="year")) %>%
#         rename(lat2 = .data$lat,
#                lng2 = .data$lng) -> hold_this
#
#       latlng1 <- hold_this %>% select(.data$lng1, .data$lat1)
#       latlng2 <- hold_this %>% select(.data$lng2, .data$lat2)
#       hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#       hold_this %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> hold_this
#
#       hold_this %>% group_by(.data$ccode1, .data$year) %>%
#         summarize(mincapdist = min(.data$capdist, na.rm=TRUE)) %>% ungroup() %>%
#         rename(ccode = .data$ccode1) %>%
#         left_join(data, .) -> data
#
#       return(data)
#
#
#     } else { # Assuming it's G-W system
#
#       gw_capitals %>% rowwise() %>%
#         mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#         unnest(.data$year) %>%
#         select(.data$gwcode, .data$year, .data$lat, .data$lng) %>%
#         # There will be duplicates for when the country moved.
#         # Under those conditions, the first capital should be first. It's basically the Jan. 1 capital, if you will.
#         group_by(.data$gwcode, .data$year) %>% slice(1) %>% ungroup() -> capital_years
#
#       create_dyadyears(system = 'gw') %>%
#         left_join(., capital_years %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode1"="gwcode","year"="year")) %>%
#         rename(lat1 = .data$lat,
#                lng1 = .data$lng) %>%
#         left_join(., capital_years %>% select(.data$gwcode, .data$year, .data$lat, .data$lng), by=c("gwcode2"="gwcode","year"="year")) %>%
#         rename(lat2 = .data$lat,
#                lng2 = .data$lng) -> hold_this
#
#       latlng1 <- hold_this %>% select(.data$lng1, .data$lat1)
#       latlng2 <- hold_this %>% select(.data$lng2, .data$lat2)
#       hold_this$capdist <- distVincentySphere(latlng1, latlng2) / 1000
#       hold_this %>% select(-.data$lat1, -.data$lng1, -.data$lat2, -.data$lng2) -> hold_this
#
#       hold_this %>% group_by(.data$gwcode1, .data$year) %>%
#         summarize(mincapdist = min(.data$capdist)) %>% ungroup() %>%
#         rename(gwcode = .data$gwcode1) %>%
#         left_join(data, .) -> data
#
#       return(data)
#
#
#     }
#   }
#   else  {
#     stop("add_capital_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#
#   }
# }
