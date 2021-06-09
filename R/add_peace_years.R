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
#' Importantly, the underlying function (\code{sbtscs()} in \pkg{stevemisc}, by way of \code{btscs()} in \pkg{DAMisc})
#' has important performance issues if you're trying to run it when your event data are sandwiched by observations
#' without any event data. Here's what I mean. Assume you got the full Gleditsch-Ward state-year data from 1816 to 2020
#' and then added the UCDP armed conflict data to it. If you want the peace-years for this, the function will fail because
#' every year from 1816 to 1945 (along with 2020, as of writing) have no event data. You can force the function to "not fail"
#' by setting \code{pad = TRUE} as an argument, but it's not clear this is advisable for this reason. Assume you wanted event data
#' in UCDP for just the extrasystemic onsets. The data start in 1946 and, in 1946, the United Kingdom,
#' Netherlands, and France had extrasystemic conflicts. For *all* years before 1946, the events are imputed as 1
#' for those countries that had 1s in the first year of observation and everyone else is NA and implicitly assumed to be a zero.
#' For those NAs, the function runs a sequence resulting in some wonky spells in 1946 that are not implied by (the absence of) the
#' data. In fact, none of those are implied by the asbsence of data before 1946.
#'
#' The function works just fine if you truncate your temporal domain to reflect the nature of your event data. Basically,
#' if you want to use this function more generally, filter your dyad-year or state-year data to make sure there are no years
#' without any event data recorded (e.g. why would you have a CoW-MID analyses of dyad-years with observations before 1816?). This
#' is less a problem when years with all-NAs succeed (and do not precede) the event data. For example, the UCDP conflict data
#' run from 1946 to 2019 (as of writing). Having 2020 observations in there won't compromise the function output when \code{pad = TRUE}
#' is included as an argument.
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

  ps_btscs <- function(data, event, tvar, csunit, pad_ts = FALSE) {
    hold_this <- data
    tvar <- enquo(tvar)
    event <- enquo(event)
    csunit <- enquo(csunit)
    data <- filter(data, !is.na(!!event))
    data <- select(data, !!event, !!tvar, !!csunit)
    data <- arrange(data, !!csunit, !!tvar)
    sumevents <- data %>%
      group_by(!!csunit) %>%
      mutate(tot = sum(!!event, na.rm=T))
    noevents <- sumevents %>%
      group_by(!!csunit) %>%
      filter(.data$tot == 0) %>%
      mutate(spell = seq_along(!!tvar) - 1)
    data <- sumevents %>%
      group_by(!!csunit) %>%
      filter(.data$tot > 0) %>%
      as.data.frame()
    tvar <- quo_name(tvar)
    event <- quo_name(event)
    csunit <- quo_name(csunit)
    # Taken from Dave Armstrong's DAMisc package.
    data$orig_order <- 1:nrow(data)
    data <- data[order(data[[csunit]], data[[tvar]]), ]
    spells <- function(x) {
      tmp <- rep(0, length(x))
      runcount <- 0
      for (j in 2:length(x)) {
        if (x[j] == 0 & x[(j - 1)] == 0) {
          tmp[j] <- runcount <- runcount + 1
        }
        if (x[j] != 0 & x[(j - 1)] == 0) {
          tmp[j] <- runcount + 1
          runcount <- 0
        }
        if (x[j] == 0 & x[(j - 1)] != 0) {
          tmp[j] <- runcount <- 0
        }
      }
      tmp
    }
    sp <- split(data, data[[csunit]])
    if (pad_ts) {
      sp <- lapply(sp, function(x) x[match(seq(min(x[[tvar]], na.rm = T), max(x[[tvar]], na.rm = T)),
                                           x[[tvar]]), ])
      for (i in 1:length(sp)) {
        if (any(is.na(sp[[i]][[event]]))) {
          sp[[i]][[event]][which(is.na(sp[[i]][[event]]))] <- 1
        }
        if (any(is.na(sp[[i]][[tvar]]))) {
          sp[[i]][[tvar]] <- seq(min(sp[[i]][[tvar]], na.rm = T), max(sp[[i]][[tvar]], na.rm = T))
        }
        if (any(is.na(sp[[i]][[csunit]]))) {
          sp[[i]][[csunit]][which(is.na(sp[[i]][[csunit]]))] <- mean(sp[[i]][[csunit]], na.rm = T)
        }
      }
    }
    sp <- lapply(1:length(sp), function(x) {
      cbind(sp[[x]], data.frame(spell = spells(sp[[x]][[event]])))
    })
    data <- do.call(rbind, sp)
    if (!pad_ts) {
      if (any(is.na(data$orig_order))) {
        data <- data[-which(is.na(data$orig_order)), ]
      }
      data <- data[data$orig_order, ]
    } else {
      data <- data[order(data[[csunit]], data[[tvar]]), ]
    }
    data$orig_order <- NULL
    data <- bind_rows(data, noevents)
    data$tot <- NULL
    data <- select(data, -!!event)
    #data <- as_tibble(data[order(data[[csunit]], data[[tvar]]), ])
    data <- left_join(hold_this, data)
    return(data)
  }

  attr_ps_data_type <- attributes(data)$ps_data_type
  attr_ps_system <- attributes(data)$ps_system

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

      data <- ps_btscs(data, .data$cowmidongoing, .data$year, .data$dyad, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "cowmidspell"

      attr(data, "ps_data_type") <- attr_ps_data_type
      attr(data, "ps_system") <-  attr_ps_system

    }

    if (all(i <- c("gmlmidongoing", "gmlmidonset") %in% colnames(data))) {

      data <- ps_btscs(data, .data$gmlmidongoing, .data$year, .data$dyad, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "gmlmidspell"

      attr(data, "ps_data_type") <- attr_ps_data_type
      attr(data, "ps_system") <-  attr_ps_system


    }

    if (all(i <- c("cowinterongoing", "cowinteronset") %in% colnames(data))) {

      data <- ps_btscs(data, .data$cowinterongoing, .data$year, .data$dyad, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "cowinterspell"

      attr(data, "ps_data_type") <- attr_ps_data_type
      attr(data, "ps_system") <-  attr_ps_system


    }


    data$dyad <- NULL
    return(data)



  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {

    if (all(i <- c("ucdpongoing", "ucdponset") %in% colnames(data))) {

      data <- ps_btscs(data, .data$ucdpongoing, .data$year, .data$gwcode, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "ucdpspell"

      attr(data, "ps_data_type") <- attr_ps_data_type
      attr(data, "ps_system") <-  attr_ps_system

    }

    if (all(i <- c("cowintraongoing", "cowintraonset") %in% colnames(data))) {

      data <- ps_btscs(data, .data$cowintraongoing, .data$year, .data$ccode, pad_ts = pad)
      names(data)[names(data) == "spell"] <- "cowintraspell"

      attr(data, "ps_data_type") <- attr_ps_data_type
      attr(data, "ps_system") <-  attr_ps_system

    }

  } else  {
    stop("add_peace_years() sees nothing that needs peace years right now.")
  }

  return(data)
}
