library(tidyverse)
library(peacesciencer)
library(microbenchmark)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# Create some data ----

cow_leaderyears <- create_leaderyears(standardize_cow = TRUE)
gw_leaderyears <- create_leaderyears(standardize_cow = FALSE)


# cow_ddy
# gw_ddy <- create_dyadyears(system = "gw")
#
# cow_ddy_cowmid <- cow_ddy %>% add_cow_mids(keep = NULL)
cow_leader_glmmid <- create_leaderyears(standardize_cow = TRUE) %>% add_gml_mids(keep = NULL) %>% filter(between(year, 1816, 2010))
#

# https://stackoverflow.com/questions/43662457/convert-list-of-vectors-to-data-frame
# ^ inspiration for {microbenchmark} approach

leader_bench <- microbenchmark::microbenchmark(
  `add_contiguity()` = cow_leaderyears %>% add_contiguity(),
  `add_cow_majors()` = cow_leaderyears %>% add_cow_majors(),
  `add_gml_mids()` = cow_leaderyears %>% add_gml_mids(),
  `add_lead()` = cow_leaderyears %>% add_lead(),
  `add_lwuf()` = cow_leaderyears %>% add_lwuf(),
  `add_nmc()` = cow_leaderyears %>% add_nmc(),
  `add_sdp_gdp()` = cow_leaderyears %>% add_sdp_gdp(),
  `add_spells()` = cow_leader_glmmid %>% add_spells(),
  unit = "s",
  times = 100)

saveRDS(leader_bench, "~/Dropbox/projects/peacesciencer/data-raw/times/leader_bench.rds")
