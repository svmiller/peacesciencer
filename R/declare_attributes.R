#' Declare \pkg{peacesciencer}-specific attributes to data
#'
#' @description \code{declare_attributes()} allows the user to
#' declare \pkg{peacesciencer}-specific attributes to data they
#' bring from outside the package. This allows the user to use
#' package functions as shortcuts, where appropriate.
#'
#' @return \code{declare_attributes()} takes a data frame and
#' adds \pkg{peacesciencer}-specific attributes to the data frame.
#' This will allow the user to take advantage of many of the
#' functions in this package without starting the process with one
#' of the "create" functions. If nothing is declared in the function,
#' no attribute is added and the function just returns the original
#' data without any change.
#'
#' @details The function's documentation will include what attributes
#' are available to be declared. No doubt, the list of potential
#' attributes will grow in time, but the attributes that can be declared
#' are limited to just what I've built into the package to this
#' point. Users cannot declare more than one attribute of a given
#' type (i.e. a user cannot declare the system to be both Correlates of War
#' and Gleditsch-Ward).
#'
#' The idea here is, basically, to allow the user to use functions in
#' \pkg{peacesciencer} for data they have created or have acquired from
#' elsewhere. However, this functions provides *no* assurances about quality
#' control in the various merges built elsewhere into this package. This package
#' aggressively tests functions for data generated in-house. If your outside
#' data have merges, the various "add" functions may not perfectly perform. There
#' is no real way I can control for this since the data are coming from outside
#' the package and not through one of the "create" functions. In your particular
#' case, that may not be much of a problem. However, it's the user's
#' responsibility to do their own quality control in this situation.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame for which you want \pkg{peacesciencer}-specific attributes
#' @param data_type optional, but a character vector of length 1 coinciding with the type of data the user believes
#' the data frame is. Options include: 'dyad_year', 'leader_day', 'leader_year', 'leader_dyad_year', 'state_day', or 'state_year'.
#' @param system optional, but a character vector of length 1 coinciding with the state system of the data. If specified at all,
#' must be 'cow' or 'gw'.
#' @param conflict_type optional, and applicable to just conflict data and the "whittle" class functions in \pkg{peacesciencer}. If specified,
#' must be a character vector of length 1 that is either 'cow' or 'gml'.
#'
#'
#' @examples
#'
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' data.frame(ccode = 2, year = c(1816:1830)) -> usa_years
#'
#' usa_years %>% declare_attributes(data_type = 'state_year', system = 'cow')
#'



declare_attributes <- function(data, data_type, system, conflict_type) {

  if (!missing(data_type)) {
    if(length(data_type) > 1) {
      stop("You cannot specify more than one data type. Pick one of 'dyad_year', 'leader_day', 'leader_year', 'leader_dyad_year', 'state_day', or 'state_year'.")
    }


    if (!(data_type %in% c("dyad_year", "leader_dyad_year", "leader_day", "leader_year", "state_day", "state_year")))
    {
      stop("Right now, {peacesciencer} only recognizes the following data types: 'dyad_year', 'leader_day', 'leader_year', 'leader_dyad_year', 'state_day', 'state_year'.")
    } else {

    attr(data, "ps_data_type") <- data_type
    }
  }

  if (!missing(system)) {
    if(length(system) > 1) {
      stop("You cannot specify more than one system type. Pick either 'cow' or 'gw'.")
    }

    if (!(system %in% c("cow", "gw")))
    {
      stop("{peacesciencer} is only really designed for Correlates of War ('cow') or Gleditsch-Ward ('gw') state-system data.")
    } else {

      attr(data, "ps_system") <- system
    }
  }

  if (!missing(conflict_type)) {
    if(length(conflict_type) > 1) {
      stop("You cannot specify more than one conflict type. Pick either 'cow' or 'gml'.")
    }

    if (!(system %in% c("cow", "gml")))
    {
      stop("Right now, {peacesciencer} only recognizes the following conflict data types as particular attribute: 'cow' or 'gml'.")
    } else {

      attr(data, "ps_conflict_type") <- conflict_type
    }
  }

  return(data)
}
