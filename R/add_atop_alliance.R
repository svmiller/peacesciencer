#' Add Alliance Treaty Obligations and Provisions (ATOP) alliance data to a dyad-year data frame
#'
#' @description \code{add_atop_alliance()} allows you to add Alliance Treaty
#' Obligations and Provisions (ATOP) data to a (dyad-year, leader-dyad-year)
#' data frame.
#'
#' @return \code{add_atop_alliance()} takes a (dyad-year, leader-dyad-year) data
#' frame and adds information about the alliance pledge in that given dyad-year
#' from the ATOP data. These include whether there was an alliance with a
#' defense pledge, an offense pledge, neutrality pledge, non-aggression pledge,
#' or pledge for consultation in time of crisis. It also includes a simple
#' indicator communicating whether there was an alliance of any kind whatsoever.
#'
#' @details Data are from version 5.1 of ATOP.
#'
#' This function will also work with leader-dyad-years, though users should be
#' careful with leader-level applications of alliance data. Alliance data are
#' primarily communicated yearly, making it possible---even likely---that at
#' least one leader-dyad in a given year is credited with an alliance that was
#' not active in the particular leader-dyad. The ATOP alliance data are not
#' communicated with time measurements more granular than the year, at least for
#' dyad-years. The alliance-level data provided by ATOP do have termination
#' dates, but I am unaware how well these start and termination dates coincide
#' with particular members joining after the fact or exiting early. The alliance
#' phase data appear to communicate that "phases" are understood as beginning or
#' ending when the underlying document is amended in such a way that it affects
#' one of their variable codings, but this may or may not be because of a
#' signatory joining after the fact or exiting early. More guidance will be
#' useful going forward, but use these data for leader-level analyses with that
#' in mind.
#'
#' It's conceivable that the simple alliance dummy can be 1 but all the
#' provisions can be 0. See the section below for a case when this happens.
#'
#' ## On the `ndir` Argument
#'
#' Consider this Belgium-France directed dyad-year from 1832 as illustrative of
#' what you'll want to consider in the `ndir` argument. This is an interesting
#' case where it's an alliance with Belgium making no pledge of any kind to
#' France. France, instead, is making a defensive pledge to Belgium.
#'
#' | **ccode1** | **ccode2** | **year** | **atop_defense** | **atop_offense** | **atop_neutral** | **atop_nonagg** | **atop_consul** |
#' |:----------:|:----------:|:--------:|:----------------:|:----------------:|:----------------:|:---------------:|:---------------:|
#' |      211|    220| 1832|            0|            0|            0|           0|           0|
#' |    220|      211| 1832|            1|            0|            0|           0|           0|
#'
#' A lot of \pkg{peacesciencer} functionality prior to version 1.2 had leaned on
#' collapsing directed dyad-year data to non-directed dyad-year data through
#' simple subsets of the data where `ccode2` is larger than `ccode1`. Here,
#' that is a questionable decision absent clarification from the user. In this
#' case, Belgium (211) has made no pledge to defend France (220), though France
#' has made a pledge to defend Belgium in the event of an attack.
#'
#' If the data supplied in the `data` argument in this function are directed
#' dyad-years, there is no issue for merging. `add_atop_alliance()` performs a
#' quick assessment of whether there is any instance in which `ccode1` is greater
#' than `ccode2`. If there are such observations, the data are assumed to be
#' directed dyad-year and the merging proceeds without further consideration. If
#' there are no instances in which `ccode1` is greater than `ccode2`, the data
#' are assumed to be non-directed dyad-years and the behavior of this function
#' hinges on the logical condition supplied to the `ndir` argument. If `ndir` is
#' `TRUE` (default), the function assumes you are aware the data you have are
#' non-directed while the alliance data are directed. It will then summarize the
#' directed dyad-year data looking for the highest observed value in the
#' dyad-year in either direction. In the above illustration, it would mean that
#' the Belgium-France dyad would have a defense pledge in 1832 no matter how the
#' non-directed dyad is entered in the data. If `ndir` is `FALSE`, the function
#' performs a simple merge on matching dyad-year keys. In the above illustration,
#' it would mean a Belgium-France dyad in 1832 would have no defense pledge
#' because it was incidentally the case that the defense pledge that does appear
#' in that dyad is made by the state with the higher state code. Use this
#' argument with that in mind if your data are non-directed.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param ndir logical, defaults to `TRUE`. This argument specifies the behavior
#' of function whether the dyad-year data in the `data` argument is non-directed.
#' See Details section for more.
#'
#' @references
#'
#' Leeds, Brett Ashley, Jeffrey M. Ritter, Sara McLaughlin Mitchell, and
#' Andrew G. Long. 2002. "Alliance Treaty Obligations and Provisions, 1815-1944."
#' *International Interactions* 28: 237-60.
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_atop_alliance()
#'
#' @export



add_atop_alliance <- function(data, ndir = TRUE) {

  ps_type <- attr(data, "ps_data_type")


  if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

    stop("add_atop_alliance() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")

  }

  ndir_id <- nrow(subset(data, data$ccode1 > data$ccode2))
  is_ndir <- ifelse(ndir_id == 0, TRUE, FALSE)
  # if non-directed, must be 0, given standard practice and how {peacesciencer}
  # operates.

  dispatch <- list(
    dyad_year = .add_atop_alliance,
    leader_dyad_year = .add_atop_alliance
  )

  if (is.null(ps_type) || !(ps_type %in% names(dispatch))) {
    stop("add_atop_alliance() requires a data/tibble with attributes$ps_data_type of dyad_year or leader_dyad_year. Try running create_dyadyears() or create_leaderdyadyears() at the start of the pipe.")
  }

  data <- dispatch[[ps_type]](data, ndir, nd = is_ndir)

  return(data)

}


#' @keywords internal
#' @noRd

.add_atop_alliance <- function(data, ndir, nd) {

  atop_alliance$atop_alliance <- 1

  # If I'm the one making and curating these data, it works. This is approach is
  # hacky af.
  atop_alliance <- atop_alliance[, c(1:3, ncol(atop_alliance),
                                     4:(ncol(atop_alliance)-1))]


  if(nd == FALSE) {
    # the data are directed dyad-year, contingent on the determination made
    # above. The data are assumed to be generated by {peacesciencer}, which
    # behaves in a way that makes this work.



    atop_alliance %>%
      left_join(data, .) %>%
      mutate_at(vars("atop_alliance", "atop_defense", "atop_offense",
                     "atop_neutral", "atop_nonagg", "atop_consul"),
                ~ifelse(is.na(.) & between(.data$year, 1815, 2018), 0, .)) -> data

  } else { # the data are non-directed and now require a consideration of the `ndir` argument

    if(ndir == TRUE) { # the default, which assumes you want a summary of the dyad in either direction.

      atop_alliance %>%
        mutate(ccodel = ifelse(.data$ccode1 > .data$ccode2, .data$ccode2, .data$ccode1),
               ccodeh = ifelse(.data$ccode1 > .data$ccode2, .data$ccode1, .data$ccode2)) -> hold_this

      hold_this %>%
        mutate(across(starts_with("atop_"), max), .by=c(.data$ccodel, .data$ccodeh, .data$year)) %>%
        #filter(ccodel == 211 & ccodeh == 220 & year == 1832)
        filter(.data$ccode2 > .data$ccode1) %>%
        select(-.data$ccodel, -.data$ccodeh) %>%
        left_join(data, .) %>%
        mutate_at(vars("atop_defense", "atop_offense", "atop_neutral",
                       "atop_nonagg", "atop_consul"),
                  ~ifelse(is.na(.) & between(.data$year, 1815, 2018), 0, .)) -> data


    } else { # ndir = FALSE

      atop_alliance %>%
        left_join(data, .) %>%
        mutate_at(vars("atop_alliance", "atop_defense", "atop_offense",
                       "atop_neutral", "atop_nonagg", "atop_consul"),
                  ~ifelse(is.na(.) & between(.data$year, 1815, 2018), 0, .)) -> data


    }

    }

}












# add_atop_alliance <- function(data) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_atop_alliance() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#       atop_alliance %>%
#         left_join(data, .) %>%
#         mutate_at(vars("atop_defense", "atop_offense", "atop_neutral", "atop_nonagg", "atop_consul"), ~ifelse(is.na(.) & year <= 2018, 0, .)) -> data
#     }
#
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#     stop("Right now, there is only support for dyad-year data.")
#
#   } else  {
#     stop("add_atop_alliance() requires a data/tibble with attributes$ps_data_type of dyad_year or leader_dyad_year. Try running create_dyadyears() or create_leaderdyadyears() at the start of the pipe.")
#   }
#
#   return(data)
# }
