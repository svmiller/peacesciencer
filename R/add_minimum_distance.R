#' Add minimum distance data to your data frame
#'
#' @description \code{add_minimum_distance()} allows you to add the minimum
#' distance (in kilometers) to a dyad-year, state-year, leader-year, or
#' leader-dyad-year data. These estimates span the temporal domain of 1886 to
#' 2019.
#'
#' @return
#'
#' \code{add_minimum_distance()} takes a (dyad-year, leader-year,
#' leader-dyad-year, state-year) data frame and adds the minimum distance
#' between the first state and the second state (in dyad-year or leader-dyad-year
#' data) or the minimum minimum (sic) distance for a given state in a given year
#' for data that are state-year or leader-year.
#'
#' @details
#'
#' The function leans on attributes of the data that are provided by one of the
#' "create" functions in this package (e.g. [create_dyadyears()] or
#' [create_stateyears()]).
#'
#' This function will add estimates to leader-level data (like the kind created
#' [create_leaderyears()] or [create_leaderdyadyears()]), but the standard
#' caveat applies that the minimum distance data merged into these kinds of
#' data should be understood as approximations.
#'
#' The function will create an on-the-fly directed version of the non-directed
#' data prior to merging, even if your data are non-directed. It's just easier
#' to do it that way and the concern for computation time is minimal.
#'
#' Underneath the hood, a grouped summarize function returning a minimum estimate
#' generates the value for state-year or leader-year data. If there is a given
#' year where there is no minimum distance recorded whatsoever, this value is
#' infinity. The function quietly corrects this underneath the hood, but the
#' summarize function that calculates this still returns this warning.
#'
#' The `use_extdata` argument checks for whether you have the "plus" version of
#' the data in the package's extdata directory. If you don't have it, the
#' function issues a stop suggesting that you should run [download_extdata()] to
#' get a copy of these data or to set `use_extdata` to be FALSE.
#'
#' [download_extdata()] has additional information about the data sets that
#' `use_extdata` would incorporate into your data. Check for "minimum distance"
#' in the documentation there, and be mindful of your state system that
#' \pkg{peacesciencer} is treating as your master system.
#'
#' ## On the `slice` Argument
#'
#' The `slice` argument is applicable only when `use_extdata` is TRUE and
#' determines how the minimum distance data are sliced prior to merging into
#' your data set. The "plussed up" version of the minimum distance data that you
#' can retrieve from [download_extdata()] and optionally use in this function
#' has every dyadic minimum distance from 1886 to 2019, by year, on Jan. 1,
#' June 30, Dec. 31, and at any point in a given year where the dyadic minimum
#' distance changed for one reason or another. A quick explanation follows.
#'
#' *"first"*: this is the default option. It will return the earliest observed
#' minimum distance in a given dyad-year. In most cases, this is Jan. 1 of a
#' given year. However, it need not be. For example, the minimum distance in
#' the Correlates of War version of the data for the United States and Canada is
#' on Jan. 10, 1920.
#'
#' *"jan1"*: entering this as the value in the `slice` argument returns the
#' minimum distance observed on Jan. 1 of the referent year. Using the above
#' case of Canada and the United States in 1920, this observation would be
#' missing for the year because the dyad did not exist on Jan. 1, 1920 in the
#' Correlates of War system. This incidentally the only option available to you
#' if `use_extdata` is set to FALSE. [cow_mindist] and [gw_mindist] are
#' benchmarked to Jan. 1 of a given year.
#'
#' *"june30"*: this is the recorded minimum distance, if one exists, for a dyad
#' on June 30 of a given year. This is a basic midway point of a calendar year.
#' Selecting this means there would be no minimum distance inserted for Germany
#' and Austria in 1938 in the Correlates of War system. Austria momentarily exits
#' the system on March 13, 1938.
#'
#' *"dec31"*: this is the recorded minimum distance, if one exists, for a dyad
#' on Dec. 31 of a given year. Selecting this means there would be no minimum
#' distance between the Republic of Vietnam and China in 1975 in the Correlates
#' of War system. The Republic of Vietnam was eliminated from the international
#' system on April 30 of that year.
#'
#' *"last"*: this will return the last observed minimum distance in a given
#' dyad-year. In most cases, this is Dec. 31 of a given year. However, it need
#' not be. In the above cases concerning some manner of system exit, the last
#' observed minimum distance would be used.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param use_extdata logical, defaults to TRUE. If TRUE, the function uses the
#' augmented version of the minimum distance data made available by way of the
#' [download_extdata()] function. If FALSE, the function uses either
#' `cow_mindist` or `gw_mindist` in the package.
#' @param slice concerns data subset behavior when `use_extdata` is TRUE. Can
#' be either "first" (the default option), "jan1", "june30", "last", or "dec31".
#' See details section for more.
#' @param ... optional, only to make the shortcut (`add_min_dist()`) work
#'
#' @references
#'
#' Schvitz, Guy, Luc Girardin, Seraina Ruegger, Nils B. Weidmann, Lars-Erik
#' Cederman, and Kristian Skrede Gleditsch. 2022. "Mapping The International
#' System, 1886-2017: The \code{CShapes} 2.0 Dataset." *Journal of Conflict
#' Resolution*. 66(1): 144-161.
#'
#' Weidmann, Nils B. and Kristian Skrede Gleditsch. 2010. "Mapping and Measuring
#' Country Shapes: The \code{cshapes} Package." *The R Journal* 2(1): 18-24.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_minimum_distance(use_extdata = FALSE)
#'
#' }
#'
#'
#' @importFrom rlang .data
#' @importFrom rlang .env
#'

add_minimum_distance <- function(data, use_extdata = TRUE, slice = "first") {

  if(length(slice) > 1 || !slice %in% c("first", "jan1", "june30", "last", "dec31")) {
    stop("slice must be one of 'first', 'jan1', 'june30', 'last', or 'dec31'. Specify only one.")
  }

  if(use_extdata == TRUE && attributes(data)$ps_system == "cow" && !file.exists(system.file("extdata", "cow_mindist_plus.rds", package="peacesciencer"))) {

    stop("You want to use the augmented version of the data, but do not have it in the 'extdata' directory. Try running download_extdata() or set use_extdata to FALSE.")

  }

  if(use_extdata == TRUE && attributes(data)$ps_system == "gw" && !file.exists(system.file("extdata", "gw_mindist_plus.rds", package="peacesciencer"))) {

    stop("You want to use the augmented version of the data, but do not have it in the 'extdata' directory. Try running download_extdata() or set use_extdata to FALSE.")

  }


  ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  system_type <- paste0(ps_system, "_", ps_type)

  if(ps_system == "cow") {
    mindists <- .process_cowmindists(use_extdata, slice)
  } else { # system == "gw"
    mindists <- .process_gwmindists(use_extdata, slice)
  }

  dispatch <- list(
    cow_dyad_year = .add_min_dist_cow_dyad_year,
    gw_dyad_year = .add_min_dist_gw_dyad_year,
    cow_state_year = .add_min_dist_cow_state_year,
    gw_state_year = .add_min_dist_gw_state_year,
    cow_leader_dyad_year = .add_min_dist_cow_dyad_year,
    gw_leader_dyad_year = .add_min_dist_gw_dyad_year,
    cow_leader_year = .add_min_dist_cow_state_year,
    gw_leader_year = .add_min_dist_gw_state_year
  )

  if (!system_type %in% names(dispatch)) {

    stop("Unsupported combination of ps_system and ps_data_type. System must be 'cow' or 'gw' and the data type must be 'dyad_year', 'leader_year ,`leader_dyad_year`, or 'state_year'.")

  }

  data <- dispatch[[system_type]](data, mindists)

  return(data)


}


#' @keywords internal
#' @noRd
.process_cowmindists <- function(use_extdata, slice) {

  if(use_extdata == TRUE) {

    aaa <- readRDS(system.file("extdata", "cow_mindist_plus.rds", package="peacesciencer"))

    hold_this <- aaa
    names(hold_this)[names(hold_this) == "ccode2"] <- "tempymctempface"
    names(hold_this)[names(hold_this) == "ccode1"] <- "ccode2"
    names(hold_this)[names(hold_this) == "tempymctempface"] <- "ccode1"

    aaa <- rbind(aaa, hold_this)

    ##################################
    # ---- Now we start slicing ---- #
    ##################################

    if(slice == 'first') {

      # This is a data set of 8.8 million rows, so I'm trading some semblance of
      # assurance for speed here.
      aaa %>%
        filter(!is.na(.data$mindist)) %>%
        distinct(.data$ccode1, .data$ccode2, .data$year,
                 .keep_all = TRUE) -> aaa

    } else if(slice == "last") {

      # Another hacky solution, given the circumstances. Re-arrange and then
      # use distinct(). slice(n():1) would work here too but I'd prefer to be a
      # bit more explicit in how I do this.
      aaa %>%
        #slice(n():1) %>%  # This would work in combination with the distinct()
        arrange(desc(.data$ccode1), desc(.data$ccode2), desc(.data$date)) %>%
        filter(!is.na(.data$mindist)) %>%
        distinct(.data$ccode1, .data$ccode2, .data$year,
                 .keep_all = TRUE) -> aaa

    } else if(slice == "jan1") {

      # Note that "jan1" is not equivalent to "first", unlike the sister function
      # for capital differences. It quite literally matters if this minimum
      # distance was recorded on Jan. 1. That would mean the USA-CAN dyad would
      # not appear here because it enters on Jan. 10 of 1920. Use with that in
      # mind.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 1 & .data$day == 1) -> aaa

    } else if(slice == "dec31") {

      # See above. Basically "dec31" is not equivalent to "last" because it
      # would omit minimum distances if the dyad disappeared before the end of
      # the calendar year.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 12 & .data$day == 31) -> aaa

    } else if(slice == "june30") {

      # See above. There isn't a better way I can conjure for getting mid-year
      # observations. This just is what it is, and you use it with that in mind.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 6 & .data$day == 30) -> aaa

    }




  } else {

    aaa <- cow_mindist

    hold_this <- aaa
    names(hold_this)[names(hold_this) == "ccode2"] <- "tempymctempface"
    names(hold_this)[names(hold_this) == "ccode1"] <- "ccode2"
    names(hold_this)[names(hold_this) == "tempymctempface"] <- "ccode1"

    aaa <- rbind(aaa, hold_this)

  }


  return(aaa)


}

#' @keywords internal
#' @noRd
.process_gwmindists <- function(use_extdata, slice) {

  if(use_extdata == TRUE) {

    aaa <- readRDS(system.file("extdata", "gw_mindist_plus.rds", package="peacesciencer"))

    hold_this <- aaa
    names(hold_this)[names(hold_this) == "gwcode2"] <- "tempymctempface"
    names(hold_this)[names(hold_this) == "gwcode1"] <- "gwcode2"
    names(hold_this)[names(hold_this) == "tempymctempface"] <- "gwcode1"

    aaa <- rbind(aaa, hold_this)

    ##################################
    # ---- Now we start slicing ---- #
    ##################################

    if(slice == 'first') {

      # This is a data set of 8.8 million rows, so I'm trading some semblance of
      # assurance for speed here.
      aaa %>%
        filter(!is.na(.data$mindist)) %>%
        distinct(.data$gwcode1, .data$gwcode2, .data$year,
                 .keep_all = TRUE) -> aaa

    } else if(slice == "last") {

      # Another hacky solution, given the circumstances. Re-arrange and then
      # use distinct(). slice(n():1) would work here too but I'd prefer to be a
      # bit more explicit in how I do this.
      aaa %>%
        #slice(n():1) %>%  # This would work in combination with the distinct()
        arrange(desc(.data$gwcode1), desc(.data$gwcode2), desc(.data$date)) %>%
        filter(!is.na(.data$mindist)) %>%
        distinct(.data$gwcode1, .data$gwcode2, .data$year,
                 .keep_all = TRUE) -> aaa

    } else if(slice == "jan1") {

      # Note that "jan1" is not equivalent to "first", unlike the sister function
      # for capital differences. It quite literally matters if this minimum
      # distance was recorded on Jan. 1. That would mean the USA-CAN dyad would
      # not appear here because it enters on Jan. 10 of 1920. Use with that in
      # mind.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 1 & .data$day == 1) -> aaa

    } else if(slice == "dec31") {

      # See above. Basically "dec31" is not equivalent to "last" because it
      # would omit minimum distances if the dyad disappeared before the end of
      # the calendar year.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 12 & .data$day == 31) -> aaa

    } else if(slice == "june30") {

      # See above. There isn't a better way I can conjure for getting mid-year
      # observations. This just is what it is, and you use it with that in mind.
      aaa$month <- as.POSIXlt(aaa$date)$mon + 1
      aaa$day <- as.POSIXlt(aaa$date)$mday

      filter(aaa, .data$month == 6 & .data$day == 30) -> aaa

    }




  } else {

    aaa <- gw_mindist

    hold_this <- aaa
    names(hold_this)[names(hold_this) == "gwcode2"] <- "tempymctempface"
    names(hold_this)[names(hold_this) == "gwcode1"] <- "gwcode2"
    names(hold_this)[names(hold_this) == "tempymctempface"] <- "gwcode1"

    aaa <- rbind(aaa, hold_this)

  }


  return(aaa)


}



#' @keywords internal
#' @noRd
.add_min_dist_cow_dyad_year <- function(data, mindists) {

  a <- mindists[ , c("ccode1", "ccode2", "year", "mindist")]


  left_join(data, a,
            by=c("ccode1" = "ccode1",
                 "ccode2" = "ccode2",
                 "year" = "year")) -> data

}


#' @keywords internal
#' @noRd
.add_min_dist_gw_dyad_year <- function(data, mindists) {

  a <- mindists[ , c("gwcode1", "gwcode2", "year", "mindist")]


  left_join(data, a,
            by=c("gwcode1" = "gwcode1",
                 "gwcode2" = "gwcode2",
                 "year" = "year")) -> data

}



#' @keywords internal
#' @noRd
.add_min_dist_cow_state_year <- function(data, mindists) {

  a <- mindists[ , c("ccode1", "ccode2", "year", "mindist")]

  a %>%
    # slice_min(.data$mindist,
    #           by=c(.data$ccode1, .data$year)) %>%
    # filter(year == 1914 & ccode1 == 339)
    summarize(minmindist = min(.data$mindist, na.rm = TRUE),
              .by = c(.data$ccode1, .data$year)) -> hold_this

  # There will be occasional entries that, for one reason or another,
  # do not have minimum distances observed. This happens to Albania in 1914.
  hold_this %>% #filter(year == 1914 & ccode1 == 339)
    mutate(minmindist = ifelse(.data$minmindist == Inf, NA,
                               .data$minmindist)) -> hold_this

   left_join(data, hold_this,
             by=c("ccode"="ccode1",
                  "year"="year")) -> data

}

#' @keywords internal
#' @noRd
.add_min_dist_gw_state_year <- function(data, mindists) {

  a <- mindists[ , c("gwcode1", "gwcode2", "year", "mindist")]

  a %>%
    summarize(minmindist = min(.data$mindist, na.rm = TRUE),
              .by = c(.data$gwcode1, .data$year)) -> hold_this

  # There will be occasional entries that, for one reason or another,
  # do not have minimum distances observed. This happens to Albania in 1914 in
  # the CoW data. It also happens to Zambia in 1954 in the G-W data.
  hold_this %>%
    mutate(minmindist = ifelse(.data$minmindist == Inf, NA,
                               .data$minmindist)) -> hold_this

  left_join(data, hold_this,
            by=c("gwcode"="gwcode1",
                 "year"="year")) -> data

}


#' @rdname add_minimum_distance
#' @export

add_min_dist <- function(...) peacesciencer::add_minimum_distance(...)



























# aadd_minimum_distance <- function(data) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#   if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#     # Just to deal with all cases, we're going to create a directed version
#     cow_mindist %>%
#       rename(ccode1 = .data$ccode2,
#              ccode2 = .data$ccode1) %>%
#       bind_rows(cow_mindist, .) -> hold_cow
#
#     data %>%
#       left_join(., hold_cow) -> data
#
#     return(data)
#
#   } else if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "gw") {
#
#     gw_mindist %>%
#       rename(gwcode1 = .data$gwcode2,
#              gwcode2 = .data$gwcode1) %>%
#       bind_rows(gw_mindist, .) -> hold_gw
#
#     data %>%
#       left_join(., hold_gw) -> data
#
#     return(data)
#
#   } else {
#
#     stop("add_minimum_distance() requires either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
#   }
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {
#
#       cow_mindist %>%
#         group_by(.data$ccode1, .data$year) %>%
#         summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
#         ungroup()  %>%
#         rename(ccode = .data$ccode1) %>%
#         left_join(data, .) -> data
#
#       return(data)
#
#     } else if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "gw") {
#
#       gw_mindist %>%
#         group_by(.data$gwcode1, .data$year) %>%
#         summarize(minmindist = min(.data$mindist, na.rm = TRUE)) %>%
#         ungroup()  %>%
#         rename(gwcode = .data$gwcode1) %>%
#         left_join(data, .) -> data
#
#       return(data)
#
#     } else {
#
#       stop("add_minimum_distance() requires either Correlates of War ('cow') or Gleditsch-Ward ('gw') as system type.")
#     }
#
#   } else {
#
#     stop("add_minimum_distance() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#
#   }
#
# }
#



