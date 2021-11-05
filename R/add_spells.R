#' Add "Spells" to Data
#'
#' @description
#'
#' \code{add_spells()} calculates "spells" in your state-year, leader-year,
#' or dyad-year data. The application here is mostly concerned with
#' things like "peace spells" between conflicts in a given cross-sectional
#' unit (e.g. a state or dyad).
#'
#' @return
#'
#' \code{add_spells()} takes a dyad-year, leader-year, or  state-year data
#' frame and adds spells for ongoing conflicts. Dyadic conflict data supported
#' include the Correlates of War (CoW) Militarized Interstate Dispute (MID)
#' data set and the Gibler-Miller-Little (GML) corrections to CoW-MID.
#' State-level conflict data supported in this function include the UCDP
#' armed conflict data and the CoW intra-state war data. Leader-year
#' conflict data supported include the GML MID data.
#'
#' @details
#'
#' The function internally uses \code{ps_spells()} from \pkg{stevemisc}. In
#' the interest of full disclosure, \code{ps_spells()} leans heavily on
#' \code{add_duration()} from \pkg{spduration}. I optimized some code
#' for performance.
#'
#' Thinking of an application like peace-years, \code{add_spells()} will
#' only calculate the peace years and will leave the temporal dependence
#' adjustment to the taste of the researcher. Importantly, I do not recommend
#' manually creating splines or square/cube terms because it creates more
#' problems in adjusting for temporal dependence in model predictions.
#' In a regression formula in R, you can specify the Carter and Signorino
#' (2010) approach as
#' \code{... + gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3)} (assuming
#' you ran \code{add_spells()} on a dyad-year data frame including the
#' Gibler-Miller-Little conflict data). The Beck et al. cubic splines approach
#' is \code{... + splines::bs(gmlmidspell, 4)}. This function includes the
#' spell and three splines (hence the 4 in the command). Either approach
#' makes for easier model predictions, given R's functionality.
#'
#' Thinking of our dyadic analyses of conflict, I've always understood
#' that something like "peace-years" should be calculated on the ongoing
#' event and not the onset of the event. Think of something like the
#' Iran-Iraq War (MID#2115) as illustrative here. The MID (which became
#' a war) started in 1980 and ended in 1988. There are no other bilateral
#' incidents between Iran-Iraq independent of the war, per Correlates of War
#' coding rules. If peace years are calculated at the "onset" of the event,
#' it would list peace-years between the two countries from 1981 to 1988.
#' I've never understood that to make sense, but still I've seen others insist
#' this is the correct way to do it. \code{add_peace_years()} would force the
#' calculation on the ongoing event, which I still maintain is correct.
#' \code{add_spells()} will allow you to calculate on onsets, even if
#' ongoing events are the default.
#'
#' The underlying function for \code{add_spells()} will stop without a return
#' if there are NAs bracketing observed events. The surest way
#' this will happen is if you're doing something like a dyad-year analysis
#' of inter-state conflicts from 1816 to 2010, but \code{create_dyadyears()}
#' created observations from 2011 to 2020 for you as well. Remove those
#' before using this function and confine the temporal domain to just those
#' time-units (e.g. years) for which there is observed event data.
#' See what I do in the example below.
#'
#' @author Steven V. Miller
#'
#' @param data an applicable data frame (e.g. leader-year, dyad-year, state-year, as created in \pkg{peacesciencer})
#' @param conflict_event_type type of event for which spells should be calculated, either "ongoing" or "onset".
#' Default is "ongoing". If "ongoing", the spells are calculated on the presence of an ongoing event.
#' If "onset", spells are calculated on the onset of a conflict event with successive zeros (if observed) calculated as "peace".
#' See Details section for more.
#' @param ongo If TRUE, successive 1s are considered ongoing events and treated as NA after the first 1. If FALSE, successive 1s
#' are all treated as failures. Defaults to FALSE.
#'
#' @references
#'
#' Beger, Andreas, Daina Chiba, Daniel W. Hill, Jr, Nils W. Metternich, Shahryar Minhas and Michael D. Ward. 2018.
#' ``\pkg{spduration}: Split-Population and Duration (Cure) Regression.'' \emph{R package version 0.17.1}.
#'
#' Beck, Nathaniel, Jonathan N. Katz, and Richard Tucker. 1998. "Taking Time Seriously: Time-Series-Cross-Section
#' Analysis with a Binary Dependent Variable." \emph{American Journal of Political Science} 42(4): 1260--1288.
#'
#' Carter, David B. and Curtis S. Signorino. 2010. "Back to the Future: Modeling Time Dependence in Binary Data."
#' \emph{Political Analysis} 18(3): 271--292.
#'
#' @examples
#'
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#'
#' aaa <- subset(cow_ddy, year <= 2010)
#'
#' aaa %>%
#' add_gml_mids(keep = NULL) %>%
#' add_cow_mids(keep = NULL) %>%
#' add_contiguity() %>%
#' add_cow_majors() %>%
#' filter_prd()  %>%
#' add_spells()
#' }
#'

add_spells <- function(data, conflict_event_type = "ongoing", ongo = FALSE) {

  attr_ps_data_type <- attributes(data)$ps_data_type
  attr_ps_system <- attributes(data)$ps_system

  if(!(conflict_event_type %in% c("ongoing", "onset"))) {

    stop("The argument `conflict_event_type` must be either 'ongoing' or 'onset'. See function documentation for more.")

  }

  if("spell" %in% colnames(data)) {

    stop("I see a column here with the name `spell` and am reticent to overwrite it. Consider renaming this column or deleting it before continuing.")

  }

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {

    if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {

      stop("add_spells() leans on two Correlates of War codes (ccode1, ccode2) for dyad-year spells, which your data don't have right now. There will be future extensions to G-W system conflict data, but not right now.")

    }


    if("dyad" %in% colnames(data)) {

      warning("I see a column here with the name `dyad` and I am going to overwrite it with my own dyadic identifier.")

    }

    data$dyad <- NULL
    data$dyad <- paste0(data$ccode1,"-",data$ccode2)

    # GML MID (dyadic) ----
    if (all(i <- c("gmlmidongoing", "gmlmidonset") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$gmlmidongoing, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$gmlmidonset, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidspell"

      }


    }


    # CoW-MID (dyadic) ---
    if (all(i <- c("cowmidongoing", "cowmidonset") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$cowmidongoing, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowmidspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$cowmidonset, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowmidspell"

      }


    }

    # CoW Interstate War (dyadic) ---
    if (all(i <- c("cowinterongoing", "cowinteronset") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$cowinterongoing, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowinterspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$cowinteronset, .data$year, .data$dyad, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowinterspell"

      }


    }

  }  else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    # UCDP conflicts (state-year) ---
    if (all(i <- c("ucdpongoing", "ucdponset") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$ucdpongoing, .data$year, .data$gwcode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "ucdpspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$ucdponset, .data$year, .data$gwcode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "ucdpspell"

      }


    }


    # CoW intra-state wars (state-year) ---
    if (all(i <- c("cowintraongoing", "cowintraonset") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$cowintraongoing, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowintraspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$cowintraonset, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "cowintraspell"

      }


    }

    # GML MIDs (state-year) ---
    if (all(i <- c("gmlmidongoing", "gmlmidonset", "gmlmidongoing_init", "gmlmidonset_init") %in% colnames(data))) {

      if (conflict_event_type == "ongoing") {

        data <- ps_spells(data, .data$gmlmidongoing, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidspell"

        data <- ps_spells(data, .data$gmlmidongoing_init, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidinitspell"


      } else { # assuming it's onset...

        data <- ps_spells(data, .data$gmlmidonset, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidspell"

        data <- ps_spells(data, .data$gmlmidonset_init, .data$year, .data$ccode, ongoing = ongo)
        names(data)[names(data) == "spell"] <- "gmlmidinitspell"

      }


    }

  }  else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_year")  {

    if (conflict_event_type == "ongoing") {

    data <- ps_spells(data, .data$gmlmidongoing, .data$year, .data$obsid, ongoing = ongo)
    names(data)[names(data) == "spell"] <- "gmlmidspell"

    data <- ps_spells(data, .data$gmlmidongoing_init, .data$year, .data$obsid, ongoing = ongo)
    names(data)[names(data) == "spell"] <- "gmlmidinitspell"

    } else { # assuming you want onsets...

      data <- ps_spells(data, .data$gmlmidonset, .data$year, .data$obsid, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidspell"

      data <- ps_spells(data, .data$gmlmidonset_init, .data$year, .data$obsid, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidinitspell"

      }



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "leader_dyad_year") {

    if("dyad" %in% colnames(data)) {

      warning("I see a column here with the name `dyad` and I am going to overwrite it with my own dyadic identifier.")

    }

    data$dyad <- NULL
    data$dyad <- paste0(data$obsid1,"-",data$obsid2)

    if (c("gmlmidongoing") %in% colnames(data)) {
      # ^ are the GML mid data in there...

    if (conflict_event_type == "ongoing") {

      data <- ps_spells(data, .data$gmlmidongoing, .data$year, .data$dyad, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidspell"

      data <- ps_spells(data, .data$gmlmidongoing_init, .data$year, .data$dyad, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidinitspell"

    } else { # assuming you want onsets...

      data <- ps_spells(data, .data$gmlmidonset, .data$year, .data$dyad, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidspell"

      data <- ps_spells(data, .data$gmlmidonset_init, .data$year, .data$dyad, ongoing = ongo)
      names(data)[names(data) == "spell"] <- "gmlmidinitspell"

    }
    }

  } else {
    stop("add_spells() sees nothing that needs spells right now.")
  }


data$dyad <- NULL
return(data)
  }
