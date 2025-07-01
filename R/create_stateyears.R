#' Create state-years from state system membership data
#'
#' @description
#'
#' \code{create_stateyears()} allows you to generate state-year data from either
#' the Correlates of War (CoW) state system membership data or the Gleditsch-Ward
#' (gw) system membership data.
#'
#' @return \code{create_stateyears()} takes state system membership data provided
#' by either Correlates of War or Gleditsch-Ward and returns a simple state-year
#' data frame. The Gleditsch-Ward state-years also include an indicator for
#' whether the state is a microstate.
#'
#' @details
#'
#' The function leans on data made available in the \pkg{isard} package.
#'
#' @author Steven V. Miller
#'
#' @references Miller, Steven V. 2019. ``Create Country-Year and (Non)-Directed
#' Dyad-Year Data With Just a Few Lines in R''
#' \url{http://svmiller.com/blog/2019/01/create-country-year-dyad-year-from-country-data/}
#'
#' @param system a character specifying whether the user wants Correlates of War
#' state-years ("cow") or Gleditsch-Ward ("gw") state-years. Correlates of War is the
#' default.
#' @param mry optional, defaults to TRUE. If TRUE, the function extends the
#' script beyond the most recent system membership updates to include observation
#' to the most recently concluded calendar year. For example, the Gleditsch-Ward
#' data extend to the end of 2017. When \code{mry == TRUE}, the function returns
#' more recent years (e.g. 2018, 2019) under the assumption that states alive at
#' the end of 2016 or 2020 are still alive today. Use with some care.
#' @param subset_years and optional character vector for subsetting the years
#' returned to just some temporal domain of interest to the user. For example,
#' `c(1816:1820)` would subset the data to just all state-years in 1816, 1817,
#' 1818, 1819, and 1820. Be advised that it's easiest to subset the data after
#' the full universe of state-year data have been created. This means you could,
#' if you choose, effectively overwrite `mry = TRUE` with this argument since
#' the `mry` argument is applied at the expansion of the state system data
#' into state-year data.
#'
#' @examples
#'
#' # CoW is default, will include years beyond 2016 (most recent CoW update)
#' create_stateyears()
#'
#' # Gleditsch-Ward, include most recent years
#' create_stateyears(system="gw")
#'
#'
create_stateyears <- function(system = "cow", mry = TRUE, subset_years) {

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


    } else {

      systemdat$styear <- .pshf_year(systemdat$start)
      systemdat$endyear <- .pshf_year(systemdat$end)
      systemdat <- systemdat[,c("ccode", "cw_name", "styear", "endyear")]

    }

    # cow_states %>%
    #   rowwise() %>%
    #   mutate(year = list(seq(.data$styear, .data$endyear2))) %>%
    #   unnest(c(.data$year)) %>%
    #   arrange(.data$ccode, .data$year) %>%
    #   select(.data$ccode, .data$statenme, .data$year) %>%
    #   distinct(.data$ccode, .data$statenme, .data$year) -> data

    ylist <- Map(seq, systemdat$styear, systemdat$endyear)
    rows <- rep(seq_len(nrow(systemdat)), lengths(ylist))

    data <- data.frame(ccode = systemdat$ccode[rows],
                       cw_name = systemdat$cw_name[rows],
                       year = unlist(ylist))

    data <- data[order(data$ccode, data$year), ]

    attr(data, "ps_data_type") = "state_year"
    attr(data, "ps_system") = "cow"

  } else if(system == "gw") {

    # Will be leaning on {isard} for this going forward
    systemdat <- isard::gw_system

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

    } else {

      systemdat$styear <- .pshf_year(systemdat$start)
      systemdat$endyear <- .pshf_year(systemdat$end)

      systemdat <- systemdat[,c("gwcode", "gw_name", "microstate", "styear", "endyear")]

    }

    # gw_states %>%
    #   mutate(styear = .pshf_year(.data$startdate)) %>%
    #   rowwise() %>%
    #   mutate(year = list(seq(.data$styear, .data$endyear))) %>%
    #   unnest(c(.data$year)) %>%
    #   arrange(.data$gwcode, .data$year) %>%
    #   select(.data$gwcode, .data$statename, .data$year)  %>%
    #   distinct(.data$gwcode, .data$statename, .data$year)  -> data

    ylist <- Map(seq, systemdat$styear, systemdat$endyear)
    rows <- rep(seq_len(nrow(systemdat)), lengths(ylist))

    data <- data.frame(gwcode = systemdat$gwcode[rows],
                       gw_name = systemdat$gw_name[rows],
                       microstate = systemdat$microstate[rows],
                       year = unlist(ylist))

    data <- data[order(data$gwcode, data$year), ]

    attr(data, "ps_data_type") = "state_year"
    attr(data, "ps_system") = "gw"

  }


  if (!missing(subset_years)) {
    data <- subset(data, data$year %in% subset_years)
  } else {
    data <- data
  }


  class(data) <- c("tbl_df", "tbl", class(data))

  return(data)
}
