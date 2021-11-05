#' Add dyadic foreign policy similarity measures to your data
#'
#' @description \code{add_fpsim()} allows you to add a variety of dyadic foreign policy similarity measures to your
#' (dyad-year, leader-dyad-year) data frame
#'
#' @return \code{add_fpsim()} takes a (dyad-year, leader-dyad-year) data frame and
#' adds information about the dyadic foreign policy similarity, based on several measures calculated and offered by Frank Haege.
#'
#' @details
#'
#' For the dyad-year (and leader-dyad-year) data, there must be some kind of information loss in order to reduce the disk space
#' data like these command. In this case, all calculations are rounded to three decimal spots. I do not think this to be terribly
#' problematic, though I admit I do not like it. If this is a problem for your research question (though I can't imagine it would be),
#' you may want to consider not using this function for dyad-year or leader-dyad-year data.
#'
#' Be mindful that the data are fundamentally dyad-year and that extensions to leader-level data should be understood
#' as approximations for leaders-dyads in a given dyad-year.
#'
#' The data this function uses are directed dyad-year and the merge is a left-join, making this function agnostic about
#' whether your dyad-year (or leader-dyad-year) data are directed or non-directed.
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param keep an optional parameter, specified as a character vector, about what
#' dyadic foreign policy similarity measure(s) the user wants returned from this function. If
#' `keep` is not specified, the function returns all 14 dyadic foreign policy similiarity measures
#' calculated by Haege (2011). Otherwise, the function subsets the underlying data to just what the
#' user wants and merges in that.
#'
#' @references
#'
#' ## The Main Source of the Data
#'
#' For any use of these data whatsoever, please cite Haege (2011). Data are version 2.0.
#'
#' - Haege, Frank M. 2011. "Choice or Circumstance? Adjusting Measures of Foreign Policy Similarity for Chance Agreement."
#' \emph{Political Analysis} 19(3): 287-305.
#'
#' ## Citations for the Particular Similarity Measure You Choose
#'
#' Additional citations depend on what particular measure of similarity you're using,
#' either Signorino and Ritter's (1999) "S", Cohen's (1960) kappa and Scott's (1955) pi. Haege (2011) is
#' part of a chorus arguing against the use of "S", though "S" measures are included in these data if you elect
#' to ignore the chorus and use this mesure. Haege (2011) instead argues for a chance-corrected measure of dyadic
#' foreign policy similarity, either Cohen's (1960) kappa or Scott's (1955) pi.
#'
#' - Cohen, Jacob. 1960. "A Coefficient of Agreement for Nominal Scales." *Educational and Psychological Measurement* 20(1): 37-46.
#'
#' - Scott, William A. 1955. "Reliability of Content Analysis: The Case of Nominal Scale Coding." *Public Opinion Quarterly* 19(3): 321--5.
#'
#' - Signorino, Curtis S. and Jeffrey M. Ritter. "Tau-b or Not Tau-B: Measuring the Similarity of Foreign Policy Positions." 43(1): 115--44.
#'
#' ## Citations for the Underlying Data Informing the Similarity Measure
#'
#' Haege (2011) also suggests you cite the underlying data informing the similarity measure, whether it is UN voting or alliances. In his case,
#' he recommended a Voeten citation from 2013 and the alliance data proper. In the case of the alliances, I know Gibler's (2009)
#' book is recommended even if the alliance data have since been updated (and reflected in this measure). In the UN voting data, my
#' understanding is the 2017 paper in *Journal of Conflict Resolution* is also the preferred citation.
#'
#' - Bailey, Michael A., Anton Strezhnev, and Erik Voeten. 2017. "Estimating the Dynamic State Preferences from United Nations Voting Data."
#' *Journal of Conflict Resolution* 61(2): 430--456.
#'
#' - Gibler, Douglas M. 2009. *International Military Alliances, 1648-2008*. Washington DC: CQ Press.
#'
#' @examples
#' \dontrun{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' # The function below works, but depends on running `download_extdata()` beforehand.
#' cow_ddy %>% add_fpsim()
#'
#' # Select just kappa and pi from binary alliance data
#' cow_ddy %>% add_fpsim(keep=c("kappaba", "piba"))
#'
#' }

add_fpsim <- function(data, keep) {

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_fpsim() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")


    } else {

      if (!file.exists(system.file("extdata", "dyadic_fp_similarity.rds", package="peacesciencer"))) {

        stop("Dyadic foreign policy similarity data are stored remotely and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem and the dyadic trade data (`cow_trade_ddy`) can be loaded for additional exploration.")

      } else {

        fpsim_data <- readRDS(system.file("extdata", "dyadic_fp_similarity.rds", package="peacesciencer"))


        if (!missing(keep)) {
          fpsim_data <- subset(fpsim_data, select = c("year", "ccode1", "ccode2", keep))
        } else {
          fpsim_data <- fpsim_data
        }

        fpsim_data %>%
          left_join(data, .) -> data

        return(data)

      }

    }

  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {

   stop("add_fpsim() right now only works with dyadic data (either dyad-year or leader-dyad-year).")



  } else  {
    stop("add_fpsim() requires a data/tibble with attributes$ps_data_type of leader_dyad_year or dyad_year. Try running create_dyadyears() or create_leaderdyadyears() at the start of the pipe.")
  }

  return(data)
}
