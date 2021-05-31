#' Add Peace Years to Your Conflict Data
#'
#' @description \code{add_peace_years()} calculates peace years for your ongoing dyadic conflicts. The function
#' works for both the CoW-MID data and the Gibler-Miller-Little (GML) MID data.
#'
#' @return \code{add_peace_years()} takes a dyad-year data frame and adds peace years for ongoing dyadic conflicts.
#'
#' @details The function internally uses \code{sbtscs()} from \pkg{stevemisc}. In the interest of full disclosure,
#' \code{sbtscs()} leans heavily on \code{btscs()} from \pkg{DAMisc}. I optimized some code for performance.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#' @param pad an optional parameter, defaults to FALSE. If TRUE, the peace-year calculations fill in cases where panels are
#' unbalanced/have gaps. Think of a state like Germany disappearing for 45 years as illustrative of this.
#'
#' If \code{keep} is not specified in the function, the ensuing output returns everything.
#'
#' @references
#'
#' @references Armstrong, Dave. 2016. ``\pkg{DAMisc}: Dave Armstrong's Miscellaneous Functions.''
#' \emph{R package version 1.4-3}.
#'
#' Miller, Steven V. 2017. ``Quickly Create Peace Years for BTSCS Models with \code{sbtscs} in \code{stevemisc}.''
#' \url{http://svmiller.com/blog/2017/06/quickly-create-peace-years-for-btscs-models-with-stevemisc/}
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>%
#' add_gml_mids(keep = NULL) %>%
#' add_cow_mids(keep = NULL) %>%
#' add_contiguity() %>%
#' add_cow_majors() %>%
#' filter_prd()  %>%
#' add_peace_years()
#' }
#'

add_peace_years <- function(data, pad = FALSE) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_peace_years() leans on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. There will be future extensions to G-W system conflict data, but not right now.")

    }

    if (all(i <- c("gwcode1", "gwcode2") %in% colnames(data))) {

      stop("add_peace_years() leans on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. There will be future extensions to G-W system conflict data, but not right now.")

    }

    data$dyad <- NULL
    data$dyad <- paste0(data$ccode1,"-",data$ccode2)

    if (all(i <- c("cowmidongoing", "cowmidonset") %in% colnames(data))) {

      data <- sbtscs(data, .data$cowmidongoing, .data$year, .data$dyad, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "cowmidspell"
      attr(data, "ps_data_type") = "dyad_year"

    }

    if (all(i <- c("gmlmidongoing", "gmlmidonset") %in% colnames(data))) {

      data <- sbtscs(data, .data$gmlmidongoing, .data$year, .data$dyad, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "gmlmidspell"
      attr(data, "ps_data_type") = "dyad_year"


    }

    data$dyad <- NULL
    return(data)



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

  } else  {
    stop("add_peace_years() is only available for dyad-year data.")
  }

  return(data)
}
