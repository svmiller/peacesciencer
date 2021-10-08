library(tidyverse)
library(peacesciencer)

attributes(gml_dirdisp)



whittle_conflicts_onsets <- function(data) {

  if(is.null(attributes(data)$ps_conflict_type)) {

    stop("The 'whittle' class of functions in {peacesciencer} only work on conflict available in the package.")
  }

  if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "gml") {

    data %>%
      group_by(.data$ccode1, .data$ccode2, .data$year)  %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      # Remove anything that's not a unique MID onset
      mutate(sddd = sd(.data$midonset),
             sddd = ifelse(is.na(.data$sddd), 0, .data$sddd)) %>%
      mutate(removeme = ifelse(.data$duplicated == 1 & .data$midonset == 0 & .data$sddd > 0, 1, 0)) %>%
      filter(.data$removeme != 1) %>%
      # remove detritus
      select(-.data$removeme, -.data$sddd) %>%
      # practice safe group_by()
      ungroup()  -> data


  } else if (length(attributes(data)$ps_data_type) > 0 && attributes(data)$ps_data_type == "dyad_year" &&  attributes(data)$ps_conflict_type == "cow-mid") {

    data %>%
      group_by(.data$ccode1, .data$ccode2, .data$year)  %>%
      mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
      # Remove anything that's not a unique MID onset
      mutate(sddd = sd(.data$disponset),
             sddd = ifelse(is.na(.data$sddd), 0, .data$sddd)) %>%
      mutate(removeme = ifelse(.data$duplicated == 1 & .data$disponset == 0 & .data$sddd > 0, 1, 0)) %>%
      filter(.data$removeme != 1) %>%
      # remove detritus
      select(-.data$removeme, -.data$sddd) %>%
      # practice safe group_by()
      ungroup() -> data



  } else  {
    stop("whittle_conflicts_onsets() doesn't recognize the data supplied to it.")
  }

  return(data)
}

gml_dirdisp
gml_dirdisp %>% whittle_conflicts_onsets()

cow_mid_dirdisps
cow_mid_dirdisps %>% whittle_conflicts_onsets()

ucdp_acd %>% whittle_conflicts_onsets()
