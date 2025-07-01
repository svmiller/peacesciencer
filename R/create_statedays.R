#' Create state-days from state system membership data
#'
#' @description \code{create_statedays()} allows you to create state-day data from
#' either the Correlates of War (CoW) state system membership data or the
#' Gleditsch-Ward (gw) system membership data. The function leans on internal
#' data provided in the package.
#'
#' @return \code{create_statedays()} takes state system membership data provided
#' by either Correlates of War or Gleditsch-Ward and returns a simple state-day
#' data frame. The Gleditsch-Ward state days include the indicator communicating
#' whether the state is a microstate.
#'
#' @author Steven V. Miller
#'
#' @details
#'
#' The function leans on data made available in the \pkg{isard} package.
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
#' data extend to the end of 2020. When \code{mry == TRUE}, the function returns
#' more recent years (e.g. 2018, 2019) under the assumption that states alive
#' at the end of 2016 or 2020 are still alive today. Use with some care.
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
#' }
#'
#'
create_statedays <- function(system = "cow", mry = TRUE) {

  if (system == "cow") {

    # Will be leaning on {isard} for this going forward
    systemdat <- isard::cw_system



    if (mry == TRUE) {

      mry <- as.numeric(format(Sys.Date(), "%Y"))-1

      aaa <- as.POSIXlt(systemdat$end)

      # okay, this is always wonky, but remember that POSIXlt class stores years
      # as integers with base index value of 100. Thus, 2016 would be represented
      # as 116. 2016 - 1900 = 116. Further, the month of December is 11 since 'mon'
      # starts counting at 0, and not 1. However, 'mday' does not do this. It
      # starts at 1. Thus, Dec. 31, 2016 (the current right bound of the CoW domain
      # would have a 'year' value of 116, a 'mon' value of 11, and a 'mday' value
      # of 31. It's a bit wonky to internalize, but you get used to it.

      aaa$year <- ifelse(aaa$year == max(aaa$year) &
                           aaa$mon == 11 &
                           aaa$mday == 31,
                         mry - 1900,
                         aaa$year)

      systemdat$end <- as.Date(aaa)

    } else {

      # do nothing...

    }


    daylist <- Map(seq, systemdat$start, systemdat$end,
                   MoreArgs = list(by = "day"))

    rows <- rep(seq_len(nrow(systemdat)), lengths(daylist))

    data <- data.frame(
      ccode = systemdat$ccode[rows],
      cw_name = systemdat$cw_name[rows],
      date = as.Date(unlist(daylist), origin='1970-01-01')
    )


    # cow_states %>%
    #   mutate(stdate = as.Date(paste0(.data$styear,"/", .data$stmonth,"/", .data$stday)),
    #          enddate = as.Date(paste0(.data$endyear2, "/", .data$endmonth,"/",.data$endday))) %>%
    #   rowwise() %>%
    #   mutate(date = list(seq(.data$stdate, .data$enddate, by = '1 day'))) %>%
    #   unnest(date) %>%
    #   select(.data$ccode, .data$statenme, .data$date) -> data

    attr(data, "ps_data_type") = "state_day"
    attr(data, "ps_system") = "cow"

    #return(data)

  } else if(system == "gw") {

    # Will be leaning on {isard} for this going forward
    systemdat <- isard::gw_system

    if (mry == TRUE) {


      mry <- as.numeric(format(Sys.Date(), "%Y"))-1

      aaa <- as.POSIXlt(systemdat$end)

      # okay, this is always wonky, but remember that POSIXlt class stores years
      # as integers with base index value of 100. Thus, 2016 would be represented
      # as 116. 2016 - 1900 = 116. Further, the month of December is 11 since 'mon'
      # starts counting at 0, and not 1. However, 'mday' does not do this. It
      # starts at 1. Thus, Dec. 31, 2016 (the current right bound of the CoW domain
      # would have a 'year' value of 116, a 'mon' value of 11, and a 'mday' value
      # of 31. It's a bit wonky to internalize, but you get used to it.

      aaa$year <- ifelse(aaa$year == max(aaa$year) &
                           aaa$mon == 11 &
                           aaa$mday == 31,
                         mry - 1900,
                         aaa$year)

      systemdat$end <- as.Date(aaa)


    } else {

      # do nothing...

    }

    daylist <- Map(seq, systemdat$start, systemdat$end,
                   MoreArgs = list(by = "day"))

    rows <- rep(seq_len(nrow(systemdat)), lengths(daylist))

    data <- data.frame(
      gwcode = systemdat$gwcode[rows],
      gw_name = systemdat$gw_name[rows],
      microstate = systemdat$microstate[rows],
      date = as.Date(unlist(daylist), origin='1970-01-01')
    )

    attr(data, "ps_data_type") = "state_day"
    attr(data, "ps_system") = "gw"

    #return(data)

  }

  class(data) <- c("tbl_df", "tbl", class(data))

  return(data)
}
