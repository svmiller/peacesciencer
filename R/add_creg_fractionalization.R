#' Add fractionalization/polarization estimates from CREG to your dyad-year or state-year data
#'
#' @description \code{add_creg_fractionalization()} allows you to add information
#' about the fractionalization/polarization of a state's ethnic and religious groups to your dyad-year
#' or state-year data.
#'
#' @return \code{add_creg_fractionalization()} takes a dyad-year data frame or state-year
#' data frame, whether the primary state identifiers are from the Correlates of War
#' system or the Gleditsch-Ward system, and returns information about the
#' fractionalization and polarization of the state(s) in a given year. The function returns four additional
#' columns when the data are state-year and returns eight additional columns when the data are dyad-year.
#' The columns returned are the fractionalization of ethnic groups, the polarization of ethnic groups, the
#' fractionalization of religious groups, and the polarization of religious groups. When the data are dyad-year,
#' the return doubles because it provides information for both states in the dyad.
#'
#' @details Please see the information for the underlying data \code{creg}, and the
#' associated R script in the \code{data-raw} directory, to see how these data are generated.
#'
#' The \code{creg} data have a few duplicates. When standardizing to true CoW codes, the duplicates
#' concern Serbia/Yugoslavia in 1991 and 1992 as well as Russia/the Soviet Union in 1991. When standardizing
#' to true Gleditsch-Ward codes, the duplicates concern Serbia/Yugoslavia in 1991 and Russia/Soviet Union
#' in 1991. In those cases, the function does a group-by arrange for the more fractionalized/polarized estimate
#' under the (reasonable, I think) assumption that these are estimates prior to the dissolution of those states.
#' If this is problematic, feel free to consult the underlying data and merge those in manually.
#'
#' The underlying data have both Gleditsch-Ward codes and Correlates of War codes. The merge it makes depends
#' on what you declare as the "master" system at the top of the pipe (i.e. in \code{create_dyadyears()} or
#' \code{create_stateyears()}). If, for example, you run \code{create_stateyears(system="cow")} and follow
#' it with \code{add_gwcode_to_cow()}, the merge will be on the Correlates of War codes and not the Gleditsch-Ward
#' codes. You can see the script mechanics to see how this is achieved.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame
#'
#' @references
#'
#' Alesina, Alberto, Arnaud Devleeschauwer, William Easterly, Sergio Kurlat and Romain Wacziarg. 2003.
#' "Fractionalization". \emph{Journal of Economic Growth} 8: 155-194.
#'
#' Montalvo, Jose G. and Marta Reynal-Querol. 2005. "Ethnic Polarization, Potential Conflict, and Civil Wars"
#' \emph{American Economic Review} 95(3): 796--816.
#'
#' Nardulli, Peter F., Cara J. Wong, Ajay Singh, Buddy Petyon, and Joseph Bajjalieh. 2012.
#' \emph{The Composition of Religious and Ethnic Groups (CREG) Project}. Cline Center for Democracy.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_creg_fractionalization()
#'
#' create_stateyears() %>% add_creg_fractionalization()
#'
#' create_stateyears(system = "gw") %>% add_creg_fractionalization()
#' }
#'
#' @importFrom rlang .data
#' @importFrom rlang .env


add_creg_fractionalization <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      creg %>%
        select(.data$ccode, .data$year, .data$ethfrac:.data$relpol) %>%
        group_by(.data$ccode, .data$year) %>%
        #filter(n() > 1) %>%
        arrange(.data$ccode, .data$year) %>%
        mutate_at(vars("ethfrac", "ethpol", "relfrac", "relpol"), ~ifelse(is.na(.) & n() > 1, max(., na.rm=T), .)) %>%
        distinct() %>%
        group_by(.data$ccode, .data$year) %>%
        # filter(n() > 1) %>%
        arrange(.data$ccode, .data$year, -.data$ethfrac, -.data$relfrac) %>%
        slice(1) -> hold_this

      hold_this %>%
        left_join(data, ., by=c("ccode1"="ccode","year"="year")) %>%
        rename(ethfrac1 = .data$ethfrac,
               ethpol1 = .data$ethpol,
               relfrac1 = .data$relfrac,
               relpol1 = .data$relpol) %>%
        left_join(., hold_this, by=c("ccode2"="ccode","year"="year"))  %>%
        rename(ethfrac2 = .data$ethfrac,
               ethpol2 = .data$ethpol,
               relfrac2 = .data$relfrac,
               relpol2 = .data$relpol) -> data

      return(data)

    } else { # Assuming it's G-W system

      creg %>%
        select(.data$gwcode, .data$year, .data$ethfrac:.data$relpol) %>%
        group_by(.data$gwcode, .data$year) %>%
        #filter(n() > 1) %>%
        arrange(.data$gwcode, .data$year) %>%
        mutate_at(vars("ethfrac", "ethpol", "relfrac", "relpol"), ~ifelse(is.na(.) & n() > 1, max(., na.rm=T), .)) %>%
        distinct() %>%
        group_by(.data$gwcode, .data$year) %>%
        # filter(n() > 1) %>%
        arrange(.data$gwcode, .data$year, -.data$ethfrac, -.data$relfrac) %>%
        slice(1) -> hold_this

      hold_this %>%
        left_join(data, ., by=c("gwcode1"="gwcode","year"="year")) %>%
        rename(ethfrac1 = .data$ethfrac,
               ethpol1 = .data$ethpol,
               relfrac1 = .data$relfrac,
               relpol1 = .data$relpol) %>%
        left_join(., hold_this, by=c("gwcode2"="gwcode","year"="year"))  %>%
        rename(ethfrac2 = .data$ethfrac,
               ethpol2 = .data$ethpol,
               relfrac2 = .data$relfrac,
               relpol2 = .data$relpol) -> data

      return(data)

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      creg %>%
        select(.data$ccode, .data$year, .data$ethfrac:.data$relpol) %>%
        group_by(.data$ccode, .data$year) %>%
        #filter(n() > 1) %>%
        arrange(.data$ccode, .data$year) %>%
        mutate_at(vars("ethfrac", "ethpol", "relfrac", "relpol"), ~ifelse(is.na(.) & n() > 1, max(., na.rm=T), .)) %>%
        distinct() %>%
        group_by(.data$ccode, .data$year) %>%
        # filter(n() > 1) %>%
        arrange(.data$ccode, .data$year, -.data$ethfrac, -.data$relfrac) %>%
        slice(1) %>%
        left_join(data, .) -> data

      return(data)


    } else { # Assuming it's G-W system

      creg %>%
        select(.data$gwcode, .data$year, .data$ethfrac:.data$relpol) %>%
        group_by(.data$gwcode, .data$year) %>%
        #filter(n() > 1) %>%
        arrange(.data$gwcode, .data$year) %>%
        mutate_at(vars("ethfrac", "ethpol", "relfrac", "relpol"), ~ifelse(is.na(.) & n() > 1, max(., na.rm=T), .)) %>%
        distinct() %>%
        group_by(.data$gwcode, .data$year) %>%
        # filter(n() > 1) %>%
        arrange(.data$gwcode, .data$year, -.data$ethfrac, -.data$relfrac) %>%
        slice(1) %>%
        left_join(data, .) -> data

      return(data)


    }
  }
  else  {
    stop("add_creg_fractionalization() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")

  }
}


