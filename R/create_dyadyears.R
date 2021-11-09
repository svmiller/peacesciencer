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
#' @param subset_years and optional character vector for subsetting the years
#' returned to just some temporal domain of interest to the user. For example,
#' `c(1816:1820)` would subset the data to just all dyad-years in 1816, 1817,
#' 1818, 1819, and 1820. Be advised that it's easiest to subset the data after
#' the full universe of dyad-year data have been created. This means you could,
#' if you choose, effectively overwrite `mry = TRUE` with this argument since
#' the `mry` argument is applied at the expansion of the state system data,
#' which occurs at the start of the function.
#'
#' @examples
#' \donttest{
#' # CoW is default, will include years beyond 2016 (most recent CoW update)
#' create_dyadyears()
#'
#' # Gleditsch-Ward, include most recent years
#' create_dyadyears(system="gw")
#'
#' # Gleditsch-Ward, don't include most recent years
#' create_dyadyears(system="gw", mry=FALSE)
#'
#' # Gleditsch-Ward, don't include most recent years, directed = FALSE
#' create_dyadyears(system="gw", mry=FALSE, directed = FALSE)
#' }
#'
create_dyadyears <- function(system = "cow", mry = TRUE, directed = TRUE, subset_years) {

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
      select(.data$ccode, .data$styear, .data$endyear) %>%
      # Expand the data, create two ccodes as well
      expand(ccode1=.data$ccode, ccode2=.data$ccode, year=seq(1816,max_endyear)) %>%
      # Filter out where ccode1 == ccode2
      filter(.data$ccode1!=.data$ccode2) %>%
      left_join(., cow_states, by=c("ccode1"="ccode")) %>%
      # ...and filter out cases where the years don't align.
      filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
      # Get rid of styear and endyear to do it again.
      select(-.data$styear,-.data$endyear) %>%
      # And do it again, this time for ccode2
      left_join(., cow_states, by=c("ccode2"="ccode")) %>%
      # Again, filter out cases where years don't align.
      filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
      # And select just what we need.
      select(.data$ccode1, .data$ccode2, .data$year) -> data

    attr(data, "ps_data_type") = "dyad_year"
    attr(data, "ps_system") = "cow"

    if (directed == TRUE) {

      data -> data

    } else {
      filter(data, .data$ccode2 > .data$ccode1) -> data
    }

    # remove false dyads
    data %>% anti_join(., false_cow_dyads) -> data

    } else if(system == "gw") {
      gw_states$styear <- .pshf_year(gw_states$startdate)
      if (mry == TRUE) {
        mry <- as.numeric(format(Sys.Date(), "%Y"))-1
        gw_states$endyear = ifelse(.pshf_year(gw_states$enddate) == max(.pshf_year(gw_states$enddate)), mry, .pshf_year(gw_states$enddate))
        max_endyear <- max(gw_states$endyear)
      } else {
        gw_states$endyear <- .pshf_year(gw_states$enddate)
        max_endyear <- max(gw_states$endyear)
      }
      gw_states %>%
        mutate(styear = .pshf_year(.data$startdate)) %>%
        # Select just the stuff we need
        select(.data$gwcode, .data$styear, .data$endyear) %>%
        # Expand the data, create two ccodes as well
        expand(gwcode1=.data$gwcode, gwcode2=.data$gwcode, year=seq(1816,max_endyear)) %>%
        # Filter out where ccode1 == ccode2
        filter(.data$gwcode1 != .data$gwcode2) %>%
        left_join(., gw_states, by=c("gwcode1"="gwcode")) %>%
        # ...and filter out cases where the years don't align.
        filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
        # Get rid of styear and endyear to do it again.
        select(-.data$styear,-.data$endyear) %>%
        # And do it again, this time for ccode2
        left_join(., gw_states, by=c("gwcode2"="gwcode")) %>%
        # Again, filter out cases where years don't align.
        filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
        # And select just what we need.
        select(.data$gwcode1, .data$gwcode2, .data$year) -> data

      attr(data, "ps_data_type") = "dyad_year"
      attr(data, "ps_system") = "gw"

      if (directed == TRUE) {

        data -> data

      } else {
        filter(data, .data$gwcode2 > .data$gwcode1) -> data
      }

      # remove false dyads
      data %>% anti_join(., false_gw_dyads) -> data

    }

  if (!missing(subset_years)) {
    data <- subset(data, data$year %in% subset_years)
  } else {
    data <- data
  }

  return(data)
}
