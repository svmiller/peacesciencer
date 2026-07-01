#' Add dyadic foreign policy similarity measures to your data
#'
#' @description
#'
#' \code{add_fpsim()} allows you to add a variety of dyadic foreign policy
#' similarity measures to your (dyad-year, leader-dyad-year) data frame
#'
#' @return
#'
#' \code{add_fpsim()} takes a (dyad-year, leader-dyad-year) data frame and
#' adds information about the dyadic foreign policy similarity, based on
#' several measures calculated and offered by Frank Haege.
#'
#' @details
#'
#' \pkg{fpsim} is a suggested package for \pkg{peacesciencer} users and is
#' responsible for the calculation of these estimates of dyadic foreign policy
#' similarity.
#'
#' Check the documentation for \code{download_extdata()} for more information
#' about the data that this function uses.
#'
#' Be mindful that the data are fundamentally dyad-year and that extensions to
#' leader-level data should be understood as approximations for leaders-dyads
#' in a given dyad-year.
#'
#' The data this function uses are directed dyad-year and the merge is a
#' left-join, making this function agnostic about whether your dyad-year
#' (or leader-dyad-year) data are directed or non-directed.
#'
#' The data offered here are my own extensions of dyadic foreign policy similarity
#' based on information made available by the ATOP project and the UNGA-DM Database.
#' However, it is deeply indebted to work done by Frank Haege. You should
#' really cite Haege (2011) if you use these data.
#'
#' Haege's (2011) article reads at first glance as agnostic about which of these
#' particular measures you should consider a "preferred" or "default" measure of
#' dyadic foreign policy similarity. Indeed, the 2011 publication in
#' *Political Analysis* mostly drives the point home that *S* has important
#' limitations and the multiple variants Haege calculates are not substitutable.
#' This means a user interested in measuring dyadic foreign policy similarity
#' might have to cycle through all of them to assess their varying effects
#' whereas a user interested in this as just a control variable for the model
#' can (probably) get by with picking just one and not belaboring the measure
#' any further. This information point may be overkill, but it's something you
#' should take into consideration.
#'
#' ## Suggested Defaults
#'
#' An evaluation of the data, the article, and an email exchange with Frank Haege
#' some years back leads to the following points the user should consider. What
#' follows is a rationale for why users should think of kappa as a default
#' measure for dyadic foreign policy similarity of the measures available, though
#' why the "valued" equivalent for the alliance data is an inadvisable default.
#' The example at the end of the document offers the operational "nudge" for
#' what the user should want from this function.
#'
#' - The choice of measure will in part depend on the temporal
#' domain. If the user has just a post-WWII sample, the UN voting measures
#' offer better coverage. We're all partial to the alliance data, though,
#' because of its 19th century coverage.
#' - Haege implores the use of chance-corrected measures, like Cohen's (1960)
#' kappa or Scott's (1955) pi. Of the two, Haege suggests kappa over pi. The
#' rationale is the user would need to build in a very strong assumption that
#' the baseline propensity of forming a tie in the dyad is the same for
#' both members of the dyad to make Scott's (1955) pi as appropriate an estimate
#' as Cohen's (1960) kappa even as both have the important chance correction.
#' - The choice of squared versus absolute distances is arbitrary. Users
#' probably do not think about the differences, or know about the differences.
#' *S* was usually calculated with absolute differences in software packages,
#' though this was never usually belabored to the user. Comparability with *S*
#' might be an argument in favor of absolute distance as a default, but keep
#' in mind that squared distances are much more commonly used in most other
#' types of distance and association metrics.
#' - The choice of binary or valued is also a design choice for the user to
#' consider on the full merits, though the practice of valuing alliance ties
#' on a quantitative scale builds in strong assumptions about the scale of
#' alliance strength as presented in something like the Correlates of War
#' or ATOP typology. *S* has traditionally done this by default, which is
#' another reason its application in a lot of quantitative peace science
#' research is suspect.
#'
#' I offer further discussion on issues with treating alliances as a source of
#' information about dyadic foreign policy similarity on my blog. I don't impugn
#' its use, but just be mindful of what alliances ultimately are and what they
#' ultimately do.
#'
#' \url{https://svmiller.com/blog/2026/06/alliances-weighting-foreign-policy-similarity/}
#'
#'
#' @author Steven V. Miller
#'
#' @param data a data frame with appropriate \pkg{peacesciencer} attributes
#' @param keep an optional parameter, specified as a character vector, about
#' what dyadic foreign policy similarity measure(s) the user wants returned
#' from this function. If `keep` is not specified, the function returns all
#' 14 dyadic foreign policy similarity measures calculated by Haege (2011).
#' Otherwise, the function subsets the underlying data to just what the
#' user wants and merges in that.
#'
#' @references
#'
#' For any use of these data whatsoever (except for Tau-b), please cite
#' Haege (2011).
#'
#' - Haege, Frank M. 2011. "Choice or Circumstance? Adjusting Measures of
#' Foreign Policy Similarity for Chance Agreement."
#' *Political Analysis* 19(3): 287-305.
#'
#'
#' ## Citations for the Particular Similarity Measure You Choose
#'
#' Additional citations depend on what particular measure of similarity you're
#' using, whether Kendall's (1938) Tau-b, Signorino and Ritter's (1999) *S*,
#' Cohen's (1960, 1968) kappa and Scott's (1955) pi. Haege (2011) is part of a chorus
#' arguing against the use of *S*, though *S* measures are included in these
#' data if you elect to ignore the chorus and use this measure. Likewise, Tau-b
#' is in here, though it is not a good measure of dyadic foreign policy
#' similarity for reasons that Signorino and Ritter (1999) mention.
#' Haege (2011) argues for a chance-corrected measure of dyadic foreign policy
#' similarity, either Cohen's (1960) kappa or Scott's (1955) pi.
#'
#' - Cohen, Jacob. 1960. "A Coefficient of Agreement for Nominal Scales."
#' *Educational and Psychological Measurement* 20(1): 37-46.
#'
#' - Cohen, Jacob. 1968. "Weighted Kappa: Nominal Scale Agreement with Provision
#' for Scaled Disagreement or Partial Credit." *Psychological Bulletin*
#' 70(4): 213–220.
#'
#' - Kendall, M.G. 1938. "A New Measure of Rank Correlation."
#' *Biometrika* 30(1/2): 81--93.
#'
#' - Scott, William A. 1955. "Reliability of Content Analysis: The Case of
#' Nominal Scale Coding." *Public Opinion Quarterly* 19(3): 321--5.
#'
#' - Signorino, Curtis S. and Jeffrey M. Ritter. "Tau-b or Not Tau-B: Measuring
#' the Similarity of Foreign Policy Positions." 43(1): 115--44.
#'
#' ## Citations for the Underlying Data Informing the Similarity Measure
#'
#' Haege (2011) also suggests you cite the underlying data informing the
#' similarity measure, whether it is UN voting or alliances.
#'
#' - Fjelstul, Joshua, Simon Hug, and Christopher Kilby. 2022. "Decision-Making
#' in the United Nations General Assembly: A Comprehensive Database of
#' Resolutions, Decisions, and Votes." *Villanova School of Business Economics
#' Working Paper* 56.
#'
#' - Leeds, Brett Ashley, Jeffrey M. Ritter, Sara McLaughlin Mitchell, and
#' Andrew G. Long. 2002. "Alliance Treaty Obligations and Provisions, 1815-1944."
#' *International Interactions* 28: 237-60.
#'
#'
#'
#' @examples
#' \dontrun{
#' # just call `library(tidyverse)` at the top of the your script.
#' library(magrittr)
#' # The function below works, but depends on
#' # running `download_extdata()` beforehand.
#' cow_ddy %>% add_fpsim()
#'
#' # Select just the two kappa measures that are suggested defaults.
#' # `kallyb`: kappa for binary alliance data if you have pre-WWII data.
#' # `kvotev`: kappa for UN voting data if you just post-WWII data.
#' cow_ddy %>% add_fpsim(keep=c("kallyb", "kvotev"))
#'
#' }



add_fpsim <- function(data, keep) {

  if (!file.exists(system.file("extdata", "FPSIM.rds", package="peacesciencer"))) {

    msg <- paste0(
      # Note: I hate that this is the most legible way of doing it because it looks like a chatbot did it...
      # Alas...
      "\n\nDyadic foreign policy similarity data are stored remotely and must be downloaded separately. ",
      "This error disappears after successfully running `download_extdata()`. ",
      "Thereafter, the function works with no problem and the data (`FPSIM`) can be loaded for additional exploration. ",
      "You can check to be sure you've downloaded the data by inspecting the extdata/ directory for this package, here:\n\n",
      system.file("extdata", package="peacesciencer")

    )

    stop(msg, call. = FALSE)

    }

  ps_type <- attr(data, "ps_data_type")

  dispatch <- list(
    dyad_year = .add_fpsim_dyad_year,
    leader_dyad_year = .add_fpsim_dyad_year
  )

  if (is.null(ps_type) || !ps_type %in% names(dispatch)) {

    stop("Unexpected or unsupported ps_data_type. Expected dyad_year or leader_dyad_year")

  }

  data <- dispatch[[ps_type]](data, keep)

  return(data)

}


#' @keywords internal
#' @noRd
.add_fpsim_dyad_year <- function(data, keep) {

  fpsim <- readRDS(system.file("extdata", "FPSIM.rds", package="peacesciencer"))

  if (!missing(keep)) {

    fpsim <- subset(fpsim, select = c("year", "ccode1", "ccode2", keep))

    } else {

      fpsim <- fpsim

    }

  fpsim %>% left_join(data, .) -> data

  return(data)

}







# add_fpsim <- function(data, keep) {
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("dyad_year", "leader_dyad_year")) {
#
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_fpsim() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#       if (!file.exists(system.file("extdata", "dyadic_fp_similarity.rds", package="peacesciencer"))) {
#
#         stop("Dyadic foreign policy similarity data are stored remotely and must be downloaded separately.\nThis error disappears after successfully running `download_extdata()`. Thereafter, the function works with no problem and the dyadic trade data (`cow_trade_ddy`) can be loaded for additional exploration.")
#
#       } else {
#
#         fpsim_data <- readRDS(system.file("extdata", "dyadic_fp_similarity.rds", package="peacesciencer"))
#
#
#         if (!missing(keep)) {
#           fpsim_data <- subset(fpsim_data, select = c("year", "ccode1", "ccode2", keep))
#         } else {
#           fpsim_data <- fpsim_data
#         }
#
#         fpsim_data %>%
#           left_join(data, .) -> data
#
#         return(data)
#
#       }
#
#     }
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type %in% c("state_year", "leader_year")) {
#
#    stop("add_fpsim() right now only works with dyadic data (either dyad-year or leader-dyad-year).")
#
#
#
#   } else  {
#     stop("add_fpsim() requires a data/tibble with attributes$ps_data_type of leader_dyad_year or dyad_year. Try running create_dyadyears() or create_leaderdyadyears() at the start of the pipe.")
#   }
#
#   return(data)
# }
