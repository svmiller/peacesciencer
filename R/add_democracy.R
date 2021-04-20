#' Add democracy information to dyad-year or state-year data.
#'
#' @description \code{add_democracy()} allows you to add estimates of democracy to either dyad-year or state-year data.
#'
#'
#' @return \code{add_democracy()} takes a dyad-year data frame or state-year data frame and adds information
#' about the level of democracy for the state or two states in the dyad in a given year. If the data are dyad-year, the function
#' adds six total columns for the first state (i.e. \code{ccode1}) and the second state (i.e. \code{ccode2}) about the level
#' of democracy measured by the Varieties of Democracy project (\code{v2x_polyarchy}), the Polity project (\code{polity2}), and
#' Xavier Marquez' \code{QuickUDS} extensions/estimates. If the data are state-year, the function returns three additional columns
#' to the original data that contain that same information for a given state in a given year.
#'
#' @details The function leans on attributes of the data that are provided by the \code{create_dyadyear()} or
#' \code{create_stateyear()} function. Make sure that function (or data created by that function) appear at the top
#' of the proverbial pipe.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed") or a state-year data frame.
#'
#' @references
#'
#' Coppedge, Michael, John Gerring, Carl Henrik Knutsen, Staffan I. Lindberg, Jan Teorell, David Altman, Michael Bernhard, M. Steven Fish, Adam Glynn, Allen Hicken, Anna Luhrmann, Kyle L. Marquardt, Kelly McMann, Pamela Paxton, Daniel Pemstein, Brigitte Seim, Rachel Sigman, Svend-Erik Skaaning, Jeffrey Staton, Agnes Cornell, Lisa Gastaldi, Haakon Gjerløw, Valeriya Mechkova, Johannes von Römer, Aksel Sundtröm, Eitan Tzelgov, Luca Uberti, Yi-ting Wang, Tore Wig, and Daniel Ziblatt. 2020. ”V-Dem Codebook v10” Varieties of Democracy (V-Dem) Project.
#'
#' Marshall, Monty G., Ted Robert Gurr, and Keith Jaggers. 2017. "Polity IV Project: Political Regime Characteristics and Transitions, 1800-2017." Center for Systemic Peace.
#'
#' Marquez, Xavier, "A Quick Method for Extending the Unified Democracy Scores" (March 23, 2016).  \doi{10.2139/ssrn.2753830}
#'
#' Pemstein, Daniel, Stephen Meserve, and James Melton. 2010. Democratic Compromise: A Latent Variable Analysis of Ten Measures of Regime Type. Political Analysis 18 (4): 426-449.
#'
#' @examples
#'
#' cow_ddy %>% add_democracy()
#'
#' create_stateyears() %>% add_democracy()
#'
#'

add_democracy <- function(data) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_democracy() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    data %>% left_join(., ccode_democracy, by=c("ccode1"="ccode","year"="year")) %>%
      rename(v2x_polyarchy1 = .data$v2x_polyarchy,
             polity21 = .data$polity2,
             xm_qudsest1 = .data$xm_qudsest) %>%
      left_join(., ccode_democracy, by=c("ccode2"="ccode","year"="year")) %>%
      rename(v2x_polyarchy2 = .data$v2x_polyarchy,
             polity22 = .data$polity2,
             xm_qudsest2 = .data$xm_qudsest) -> data

      return(data)

    }


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (!all(i <- c("ccode") %in% colnames(data))) {

      stop("add_democracy() merges on the Correlates of War codes (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

    data %>%
      left_join(., ccode_democracy) -> data

      return(data)

    }

  } else  {
    stop("add_democracy() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
  }

  return(data)
}
