#' Add Thompson et al. (2021) strategic rivalry data to state-year or dyad-year data frame
#'
#' @description
#'
#' \code{add_strategic_rivalries()} merges in Thompson et al. (2021) strategic
#' rivalry data to a dyad-year or state-year data frame. The right-bound, as of
#' right now, are bound at 2020.
#'
#' @return
#'
#' \code{add_strategic_rivalries()} takes a state-year or dyad-year data frame
#' and adds information about ongoing strategic rivalries. It will also include
#' a simple dummy variable for whether there was an ongoing rivalry in the year
#' or not in the dyad-year data. For state-year data, it returns the count of
#' ongoing strategic rivalries for the state in the year meeting a certain
#' criteria (i.e. whether the state has an interventionary, ideological,
#' positional, or spatial rivalry in an ongoing year, and how many).
#'
#' @details
#'
#' \code{add_strategic_rivalries()} will include some other information derived
#' from the rivalry data that the user may not want (e.g. start year of the
#' rivalry). Feel free to select those out after the fact.
#'
#' Underneath the hood, the function subsets data to just all rivalry-year
#' observations on or after 1816. This will be in place as long as the
#' Correlates of War state system has a left-bound of 1816 on its temporal
#' domain.
#'
#' This function includes an on-the-fly adjustment for the Austria-Serbia
#' rivalry (`tssr_id = 76`). In this case, the last two years of that rivalry
#' are afforded to Austria (`ccode = 305`) when the bulk of the rivalry pertained
#' to the larger Austria-Hungary (`ccode = 300`). Previous versions of this
#' function that used the Thompson and Dreyer (2012) strategic rivalry data did
#' the same thing. It was rivalry #79 in that case.
#'
#' I could technically make such an adjustment on the fly for the France-Germany
#' rivalry as well in these data (`tssr_id = 22`). If the rivalry concludes in
#' 1955, per the data, it's conceivable that this rivalry should apply to the
#' first two years of statehood for West/East Germany. However, I lean on an
#' earlier version of the data in which this rivalry was classified as a
#' European great power rivalry (see: `rivalryno = 22` in `td_rivalries`). Thus,
#' it makes sense to square the actual rivalry end date with Germany's time as
#' a great power (and its elimination from the international system following
#' the second world war).
#'
#' I elect to not support the information on principal and asymmetric principal
#' rivalries for the time being. This is subject to change in future versions
#' of the package.
#'
#' @author Steven V. Miller
#'
#' @param data a dyad-year data frame (either "directed" or "non-directed")
#'
#' @references
#'
#' Miller, Steven V. 2019. "Create and Extend Strategic (International) Rivalry
#' Data in R". URL:
#' \url{https://svmiller.com/blog/2019/10/create-extend-strategic-rivalry-data-r/}
#'
#' Thompson, William R., Kentaro Sakuwa, and Prashant Hosur Suhas. 2021.
#' *Analyzing Strategic Rivalries in World Politics: Types of Rivalry,
#' Regional Variation, and Escalation/De-escalation*. Springer.
#'
#' @examples
#' \donttest{
#' # just call `library(tidyverse)` at the top of the your script
#' library(magrittr)
#' cow_ddy %>% add_strategic_rivalries()
#'
#' create_stateyears() %>% add_strategic_rivalries()
#' }

add_strategic_rivalries  <- function(data) {


  #ps_system <- attr(data, "ps_system")
  ps_type <- attr(data, "ps_data_type")

  #system_type <- paste0(ps_system, "_", ps_type)

  ry <- .rivalryyears()

  dispatch <- list(
    state_year = .add_strategic_rivalries_state_year,
    dyad_year = .add_strategic_rivalries_dyad_year
  )

  if (!ps_type %in% names(dispatch)) {

    stop("Unsupported ps_data_type. The data type must be 'dyad_year' or 'state_year'.")

  }

  data <- dispatch[[ps_type]](data, ry)

  return(data)

}


#' @keywords internal
#' @noRd
.rivalryyears <- function() {

  hold_this <- tss_rivalries
  names(hold_this)[names(hold_this) == "ccode2"] <- "tempymctempface"
  names(hold_this)[names(hold_this) == "ccode1"] <- "ccode2"
  names(hold_this)[names(hold_this) == "tempymctempface"] <- "ccode1"

  rivalries <- rbind(tss_rivalries, hold_this)
  rivalries <- rivalries[order(rivalries$tssr_id), ]

  ylist <- Map(seq, rivalries$start, rivalries$end)

  rows <- rep(seq_len(nrow(rivalries)), lengths(ylist))

  x <- data.frame(
    tssr_id = rivalries$tssr_id[rows],
    ccode1 = rivalries$ccode1[rows],
    ccode2 = rivalries$ccode2[rows],
    year = unlist(ylist),
    positional = rivalries$positional[rows],
    spatial = rivalries$spatial[rows],
    ideological = rivalries$ideological[rows],
    interventionary = rivalries$interventionary[rows]#,
    #principal = rivalries$principal[rows],
    #aprin = rivalries$aprin[rows]
  )

  # This is that ad-hoc change to the Austria-Serbia rivalry.

  x$ccode1 <- ifelse(x$ccode1 == 300 & x$year >= 1919, 305, x$ccode1)
  x$ccode2 <- ifelse(x$ccode2 == 300 & x$year >= 1919, 305, x$ccode2)

  # be mindful this is nuclear, but it'll do. If something goes wrong, consult
  # the raw data
  x[is.na(x)] <- 0

  x <- subset(x, x$year >= 1816)

  x <- x[order(x$tssr_id, x$ccode1, x$year), ]
  class(x) <- c("tbl_df", "tbl", class(x))

  return(x)

}


#' @keywords internal
#' @noRd
#'
.add_strategic_rivalries_state_year <- function(data, ry) {

  if (!all(i <- c("ccode") %in% colnames(data))) {

    stop("add_strategic_rivalries() merges on Correlates of War codes (ccode), which your data don't have right now.")
  }


  aggregate(cbind(n_ideological = ideological,
                  n_interventionary = interventionary,
                  n_positional = positional,
                  n_spatial = spatial) ~ ccode1 + year,
            data = ry,
            FUN = function(x) sum(x, na.rm = TRUE)) -> aaa

  left_join(data, aaa,
            by=c("ccode" = "ccode1",
                 "year" = "year")) %>%
      mutate_at(vars("n_ideological", "n_interventionary",
                     "n_positional", "n_spatial"),
                ~ifelse(is.na(.) & .data$year <= 2020, 0, .)) -> data

return(data)



}


#' @keywords internal
#' @noRd
#'
.add_strategic_rivalries_dyad_year <- function(data, ry) {

  if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
    stop("add_strategic_rivalries() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
    }

  left_join(data, ry) %>%
    mutate(ongoingrivalry = ifelse(is.na(.data$tssr_id) & .data$year <= 2020,
                                   0, 1)) %>%
    mutate_at(vars("ideological", "interventionary", "positional", "spatial"),
              ~ifelse(is.na(.) & .data$year <= 2020, 0, .)) -> data

  return(data)


}









# aadd_strategic_rivalries <- function(data, across_types = 1) {
#
#
#
#
#   td_rivalries %>%
#     bind_rows(td_rivalries %>% rename(ccode1 = .data$ccode2, ccode2 = .data$ccode1), .) %>%
#     arrange(.data$rivalryno) %>%
#     select(.data$rivalryno, .data$rivalryname, .data$ccode1, .data$ccode2,
#            .data$styear, .data$endyear, .data$region, .data$type1, .data$type2, .data$type3) %>%
#     rowwise() %>%
#     mutate(year = list(seq(.data$styear, .data$endyear))) %>%
#     # Unnest the list, which will expand the data.
#     unnest(c(.data$year)) %>%
#     # Minor note: ccode change for Austria, post-1918 for rivalryno 79.
#     mutate(ccode1 = ifelse(.data$ccode1 == 300 & .data$year >= 1919, 305, .data$ccode1),
#            ccode2 = ifelse(.data$ccode2 == 300 & .data$year >= 1919, 305, .data$ccode2)) -> hold_this
#
#   if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year") {
#
#     if (!all(i <- c("ccode1", "ccode2") %in% colnames(data))) {
#
#       stop("add_strategic_rivalries() merges on two Correlates of War codes (ccode1, ccode2), which your data don't have right now. Make sure to run create_dyadyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#
#     } else {
#
#       hold_this %>%
#         left_join(data, .) %>%
#         mutate(ongoingrivalry = ifelse(is.na(.data$type1), 0, 1)) -> data
#
#       return(data)
#
#     }
#
#
#   } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "state_year") {
#
#     if (!all(i <- c("ccode") %in% colnames(data))) {
#
#       stop("add_strategic_rivalries() merges on Correlates of War codes (ccode), which your data don't have right now. Make sure to run create_stateyears() at the top of the pipe. You'll want the default option, which returns Correlates of War codes.")
#
#     } else{
#
#       if(across_types == 1) {
#         type_vars <- quo(c(.data$type1))
#
#       } else if (across_types == 2) {
#         type_vars <- quo(c(.data$type1, .data$type2))
#       } else if (across_types == 3) {
#         type_vars <- quo(c(.data$type1, .data$type2, .data$type3))
#       } else {
#         stop("across_types must be 1, 2, or 3.")
#       }
#
#       hold_this %>%
#         select(.data$ccode1, .data$ccode2, .data$year, .data$type1:.data$type3) %>%
#         mutate_all(~ifelse(is.na(.), "NA", .)) %>%
#         rowwise() %>%
#         mutate(ideological = ifelse("ideological" %in% !!type_vars, 1, 0),
#                interventionary = ifelse("interventionary" %in% !!type_vars, 1, 0),
#                positional = ifelse("positional" %in% !!type_vars, 1, 0),
#                spatial = ifelse("spatial" %in% !!type_vars, 1, 0)) %>%
#         group_by(.data$ccode1, .data$year) %>%
#         summarize(ideological = sum(.data$ideological),
#                   interventionary = sum(.data$interventionary),
#                   positional = sum(.data$positional),
#                   spatial = sum(.data$spatial)) %>%
#         # mutate_at(vars("ideological", "interventionary", "positional", "spatial"), ~ifelse(. >= 1, 1, 0)) %>%
#         ungroup() %>%
#         rename(ccode = .data$ccode1) %>%
#         left_join(data, .) %>%
#         mutate_at(vars("ideological", "interventionary", "positional", "spatial"), ~ifelse(is.na(.), 0, .)) -> data
#
#       return(data)
#     }
#
#     } else  {
#       stop("add_strategic_rivalries() requires a data/tibble with attributes$ps_data_type of state_year or dyad_year. Try running create_dyadyears() or create_stateyears() at the start of the pipe.")
#       return(data)
#     }
#
#
#   }
