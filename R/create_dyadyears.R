#' Create dyad-years from state system membership data
#'
#' @description
#'
#' \code{create_dyadyears()} allows you to dyad-year data from either the
#' Correlates of War (CoW) state system membership data or the Gleditsch-Ward
#' (gw) system membership data. The function leans on state system data
#' available in \pkg{isard}.
#'
#' @return
#'
#' \code{create_dyadyears()} takes state system membership data provided by
#' either Correlates of War or Gleditsch-Ward and returns a dyad-year data
#' frame with one observation for each dyad-year.
#'
#' @details
#'
#' The function leans on data made available in the \pkg{isard} package.
#'
#' Underneath the hood, the function removes dyads that existed in the same year,
#' but not on any given day in the same year. For example, Suriname enters the
#' Correlates of War state system on Nov. 25, 1975, but the Republic of Vietnam
#' was eliminated from the state system on April 30 of the same year.
#'
#' Dyad-year data for the Gleditsch-Ward system will also include dyadic
#' indicators communicating whether the first state or second state is a
#' microstate. You may not want these and you can always remove them after the
#' fact.
#'
#' @author Steven V. Miller
#'
#' @references
#'
#' Miller, Steven V. 2019. ``Create Country-Year and (Non)-Directed Dyad-Year
#' Data With Just a Few Lines in R''
#' \url{https://svmiller.com/blog/2019/01/create-country-year-dyad-year-from-country-data/}
#'
#' Miller, Steven V. 2025. \pgk{isard}: Overflow Data for Quantitative Peace
#' Science Research. \url{https://CRAN.R-project.org/package=isard}
#'
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years. Correlates of War
#' is the default.
#' @param mry optional, defaults to TRUE. If TRUE, the function extends the
#' script beyond the most recent system membership updates to include
#' observation to the most recently concluded calendar year. For example, the
#' Gleditsch-Ward data extend to the end of 2017. When \code{mry == TRUE}, the
#' function returns more recent years (e.g. 2018, 2019) under the assumption
#' that states alive at the end of 2017 are still alive today. Use with some
#' care.
#' @param directed optional, defaults to TRUE. If TRUE, the function returns
#' so-called "directed" dyad-year data. In directed dyad-year data,
#' France-Germany (220-255) and Germany-France (255-220) are observationally
#' different. If FALSE, the function returns non-directed data. In non-directed
#' data, France-Germany and Germany-France in the same year are the same
#' observation. The standard here is to drop cases where the country code for
#' the second observation is less than the country code for the first
#' observation.
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
create_dyadyears <- function(system = "cow", mry = TRUE,
                             directed = TRUE, subset_years) {

  if (system == "cow") {

    # Will be leaning on {isard} for this going forward
    systemdat <- isard::cw_system

    if (mry == TRUE) {

      mry <- as.numeric(format(Sys.Date(), "%Y"))-1
      systemdat$styear <- .pshf_year(systemdat$start)
      systemdat$endyear <- .pshf_year(systemdat$end)
      # If the data were entirely self-contained in the package, I could get
      # away with being a bit lazy here. However, the data exist in another
      # package right now so I have to be a bit more literal in this. There's
      # always a pathway to failure, but right now the singular pathway to
      # failure is if Dec. 31 is incidentally a date in which a state system
      # member was eliminated in the last year of the data. God help us if that
      # happens, though...
      systemdat$endyear <- ifelse(systemdat$endyear == max(systemdat$endyear) &
                                    .pshf_month(systemdat$end) == 12, mry,
                                  systemdat$endyear)

      systemdat <- systemdat[,c("ccode", "cw_name", "styear", "endyear")]

      max_endyear <- max(systemdat$endyear)

    } else {

      systemdat$styear <- .pshf_year(systemdat$start)
      systemdat$endyear <- .pshf_year(systemdat$end)

      systemdat <- systemdat[,c("ccode", "cw_name", "styear", "endyear")]

      max_endyear <- max(systemdat$endyear)

    }


    systemdat %>%
      # Select just the stuff we need
      select(.data$ccode, .data$styear, .data$endyear) %>%
      # Expand the data, create two ccodes as well
      expand(ccode1=.data$ccode, ccode2=.data$ccode, year=seq(1816, max_endyear)) %>%
      # Filter out where ccode1 == ccode2
      filter(.data$ccode1!=.data$ccode2) %>%
      left_join(., systemdat, by=c("ccode1"="ccode")) %>%
      # ...and filter out cases where the years don't align.
      filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
      # Get rid of styear and endyear to do it again.
      select(-.data$styear,-.data$endyear) %>%
      # And do it again, this time for ccode2
      left_join(., systemdat, by=c("ccode2"="ccode")) %>%
      # Again, filter out cases where years don't align.
      filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
      # And select just what we need.
      select(.data$ccode1, .data$ccode2, .data$year) -> data

    if (directed == TRUE) {

      data -> data

    } else {
      filter(data, .data$ccode2 > .data$ccode1) -> data
    }

    # remove false dyads
    data %>% anti_join(., false_cow_dyads) -> data

    attr(data, "ps_data_type") = "dyad_year"
    attr(data, "ps_system") = "cow"


    } else if(system == "gw") {



      # Will be leaning on {isard} for this going forward
      systemdat <- isard::gw_system

      # I don't think in terms of G-W system dates, but this is going to bug
      # me if I don't check. I'm pretty sure it's just the microstates that
      # are different here.

      # gw_states
      # systemdat
      #
      # gw_states %>%
      #   rename(start = startdate,
      #          end = enddate) %>%
      #   select(gwcode, start) %>%
      #   anti_join(systemdat, .) %>% data.frame

      # yep. Sure is. And it means I'm going to have to adjust the "false"
      # data frame.


      if (mry == TRUE) {


        mry <- as.numeric(format(Sys.Date(), "%Y"))-1
        systemdat$styear <- .pshf_year(systemdat$start)
        systemdat$endyear <- .pshf_year(systemdat$end)
        # If the data were entirely self-contained in the package, I could get
        # away with being a bit lazy here. However, the data exist in another
        # package right now so I have to be a bit more literal in this. There's
        # always a pathway to failure, but right now the singular pathway to
        # failure is if Dec. 31 is incidentally a date in which a state system
        # member was eliminated in the last year of the data. God help us if that
        # happens, though...
        systemdat$endyear <- ifelse(systemdat$endyear == max(systemdat$endyear) &
                                      .pshf_month(systemdat$end) == 12, mry,
                                    systemdat$endyear)

        systemdat <- systemdat[,c("gwcode", "gw_name", "microstate", "styear", "endyear")]

        max_endyear <- max(systemdat$endyear)


      } else {

        systemdat$styear <- .pshf_year(systemdat$start)
        systemdat$endyear <- .pshf_year(systemdat$end)

        systemdat <- systemdat[,c("gwcode", "gw_name", "microstate", "styear", "endyear")]
        max_endyear <- max(systemdat$endyear)

      }
      systemdat %>%
        #mutate(styear = .pshf_year(.data$startdate)) %>%
        # Select just the stuff we need
        select(.data$gwcode, .data$styear, .data$endyear) %>%
        # Expand the data, create two ccodes as well
        expand(gwcode1=.data$gwcode,
               gwcode2=.data$gwcode,
               year=seq(1816, max_endyear)) %>%
        # Filter out where ccode1 == ccode2
        filter(.data$gwcode1 != .data$gwcode2) %>%
        left_join(., systemdat, by=c("gwcode1"="gwcode")) %>%
        # ...and filter out cases where the years don't align.
        filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
        # Get rid of styear and endyear to do it again.
        select(-.data$styear,-.data$endyear, -.data$gw_name) %>%
        rename(microstate1 = .data$microstate) %>%
        # And do it again, this time for ccode2
        left_join(., systemdat, by=c("gwcode2"="gwcode")) %>%
        # Again, filter out cases where years don't align.
        filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
        rename(microstate2 = .data$microstate) %>%
        # And select just what we need.
        select(.data$gwcode1, .data$gwcode2, .data$year,
               .data$microstate1, .data$microstate2) -> data

      if (directed == TRUE) {

        data -> data

      } else {
        filter(data, .data$gwcode2 > .data$gwcode1) -> data
      }

      # remove false dyads
      data %>% anti_join(., false_gw_dyads) -> data

      attr(data, "ps_data_type") = "dyad_year"
      attr(data, "ps_system") = "gw"

    }


  if (!missing(subset_years)) {
    data <- subset(data, data$year %in% subset_years)
  } else {
    data <- data
  }

  return(data)
}
