#' Add democracy information to a data frame
#'
#' @description \code{add_democracy()} allows you to add estimates of democracy to your data.
#'
#'
#' @return
#'
#' \code{add_democracy()} takes a (dyad-year, leader-year, leader-dyad-year,
#' state-year) data frame and adds information about the level of democracy
#' for the state or two states in the dyad in a given year. If the data are
#' dyad-year or leader-dyad-year, the function adds six total columns for
#' the first state  (i.e. `ccode1` or `gwcode1`) and the second state (i.e.
#' `ccode2` or  `gwcode2`) about the level of democracy measured by the
#' Varieties of  Democracy project (`v2x_polyarchy`), the Polity project
#' (`polity2`), and Xavier Marquez' `QuickUDS` extensions/estimates. If the
#' data are state-year or leader-year, the function returns three additional
#' columns to the original data that contain that same information for a given
#' state in a given year.
#'
#' @details
#'
#' Be mindful that the data are fundamentally state-year and that extensions to
#' leader-level data should be understood as approximations for leaders in a
#' given state-year.
#'
#' A vignette on the package's website talks about how these data are here
#' primarily to encourage you to maximize the number of observations in the
#' analysis to follow. Xavier Marquez' `QuickUDS` estimates have the best
#' coverage. If democracy is ultimately a control variable, or otherwise a
#' variable not of huge concern for the analysis (i.e. the user has no
#' particular stake on the best measurement of democracy or the best
#' conceptualization and operationalization of "democracy"), please
#' use Marquez' estimates instead of Polity or V-dem. If the user is
#' doing an analysis of inter-state conflict, and across the standard
#' post-1816 domain in conflict studies,  *definitely* don't use
#' the Polity data because the extent of its missingness is both large and
#' unnecessary. Please read the vignette describing these issues
#' here: \url{http://svmiller.com/peacesciencer/articles/democracy.html}
#'
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#'
#' @references
#'
#' Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg,
#' Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn,
#' Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela
#' Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik
#' Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerlow,
#' Valeriya Mechkova, Johannes von Romer, Aksel Sundtrom, Eitan Tzelgov,
#' Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020.
#' "V-Dem Codebook v10" Varieties of Democracy (V-Dem) Project.
#'
#' Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017.
#' "Polity IV Project: Political Regime Characteristics and Transitions,
#' 1800-2017." Center for Systemic Peace.
#'
#' Marquez, Xavier, "A Quick Method for Extending the Unified Democracy
#' Scores" (March 23, 2016).  \doi{10.2139/ssrn.2753830}
#'
#' Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. "Democratic
#' Compromise: A Latent Variable Analysis of Ten Measures of Regime Type."
#' *Political Analysis* 18(4): 426-449.
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' cow_ddy %>% add_democracy()
#'
#' create_stateyears(system="gw") %>% add_democracy()
#' create_stateyears(system="cow") %>% add_democracy()
#'

add_democracy <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      data %>% left_join(., ccode_democracy, by=c("ccode1"="ccode","year"="year")) %>%
        rename(v2x_polyarchy1 = .data$v2x_polyarchy,
               polity21 = .data$polity2,
               xm_qudsest1 = .data$xm_qudsest) %>%
        left_join(., ccode_democracy, by=c("ccode2"="ccode","year"="year")) %>%
        rename(v2x_polyarchy2 = .data$v2x_polyarchy,
               polity22 = .data$polity2,
               xm_qudsest2 = .data$xm_qudsest) -> data

      return(data)

    } else { # assuming it's G-W

      data %>% left_join(., gwcode_democracy, by=c("gwcode1"="gwcode","year"="year")) %>%
        rename(v2x_polyarchy1 = .data$v2x_polyarchy,
               polity21 = .data$polity2,
               xm_qudsest1 = .data$xm_qudsest) %>%
        left_join(., gwcode_democracy, by=c("gwcode2"="gwcode","year"="year")) %>%
        rename(v2x_polyarchy2 = .data$v2x_polyarchy,
               polity22 = .data$polity2,
               xm_qudsest2 = .data$xm_qudsest) -> data

      return(data)



    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

    if (length(attributes(data)$ps_system) > 0 && attributes(data)$ps_system == "cow") {

      data %>%
        left_join(., ccode_democracy) -> data

      return(data)

    } else { # assuming it's G-W

      data %>%
        left_join(., gwcode_democracy) -> data

      return(data)

    }

  } else  {
    stop("add_democracy() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
