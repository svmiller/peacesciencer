library(tidyverse)
library(peacesciencer)
library(microbenchmark)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# Create some data ----

download_extdata()

cow_leaderdyadyears <- create_leaderdyadyears(system = 'cow')

# cow_ddy
# gw_ddy <- create_dyadyears(system = "gw")
#
# cow_ddy_cowmid <- cow_ddy %>% add_cow_mids(keep = NULL)
cow_leaderdyad_glmmid <- cow_leaderdyadyears %>% add_gml_mids(keep = NULL) %>% filter(between(year, 1816, 2010))
#

# https://stackoverflow.com/questions/43662457/convert-list-of-vectors-to-data-frame
# ^ inspiration for {microbenchmark} approach

leader_bench <- microbenchmark::microbenchmark(
  `add_contiguity()` = cow_leaderdyadyears %>% add_contiguity(),
  `add_cow_majors()` = cow_leaderdyadyears %>% add_cow_majors(),
  `add_gml_mids()` = cow_leaderdyadyears %>% add_gml_mids(),
  `add_lead()` = cow_leaderdyadyears %>% add_lead(),
  `add_lwuf()` = cow_leaderdyadyears %>% add_lwuf(),
  `add_nmc()` = cow_leaderdyadyears %>% add_nmc(),
  `add_sdp_gdp()` = cow_leaderyears %>% add_sdp_gdp(),
  `add_spells()` = cow_leaderdyad_glmmid %>% add_spells(),
  unit = "s",
  times = 100)

saveRDS(leader_bench, "~/Dropbox/projects/peacesciencer/data-raw/times/leader_bench.rds")
