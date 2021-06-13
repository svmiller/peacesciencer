library(tidyverse)
library(peacesciencer)
library(microbenchmark)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# Create some data ----

cow_ddy
gw_ddy <- create_dyadyears(system = "gw")

cow_ddy_cowmid <- cow_ddy %>% add_cow_mids(keep = NULL)
cow_ddy_gmlmmid <- cow_ddy %>% add_gml_mids(keep = NULL)


# https://stackoverflow.com/questions/43662457/convert-list-of-vectors-to-data-frame
# ^ inspiration for {microbenchmark} approach

dyad_bench <- microbenchmark::microbenchmark(
  `add_archigos()` = cow_ddy %>% add_archigos(),
  `add_atop_alliance()` = cow_ddy %>% add_atop_alliance(),
  `add_capital_distance()` = cow_ddy %>% add_capital_distance(),
  `add_ccode_to_gw()` = gw_ddy %>% add_ccode_to_gw(),
  `add_contiguity()` = cow_ddy %>% add_contiguity(),
  `add_cow_alliance()` = cow_ddy %>% add_cow_alliance(),
  `add_cow_majors()` = cow_ddy %>% add_cow_majors(),
  `add_cow_mids(keep=NULL)` = cow_ddy %>% add_cow_mids(keep=NULL),
  `add_cow_trade()` = cow_ddy %>% add_cow_trade(),
  `add_cow_wars(type="inter")` = cow_ddy %>% add_cow_wars(type = "inter"),
  `add_creg_fractionalization() [CoW]` = cow_ddy %>% add_creg_fractionalization(),
  `add_creg_fractionalization() [G-W]` = gw_ddy %>% add_creg_fractionalization(),
  `add_democracy() [CoW]` = cow_ddy %>% add_democracy(),
  `add_democracy() [G-W]` = gw_ddy %>% add_democracy(),
  `add_gml_mids(keep=NULL)` = cow_ddy %>% add_gml_mids(keep=NULL),
  `add_gwcode_to_cow()` = cow_ddy %>% add_gwcode_to_cow(),
  `add_igos()` = cow_ddy %>% add_igos(),
  `add_minimum_distance() [CoW]` = cow_ddy %>% add_minimum_distance(),
  `add_minimum_distance() [G-W]` = gw_ddy %>% add_minimum_distance(),
  `add_nmc()` = cow_ddy %>% add_nmc(),
  `add_peace_years() [CoW-MID]` = cow_ddy_cowmid %>% add_peace_years(),
  `add_peace_years() [GML MID]` = cow_ddy_gmlmmid %>% add_peace_years(),
  `add_rugged_terrain() [CoW]` = cow_ddy %>% add_rugged_terrain(),
  `add_rugged_terrain() [G-W]` = gw_ddy %>% add_rugged_terrain(),
  `add_sdp_gdp() [CoW]` = cow_ddy %>% add_sdp_gdp(),
  `add_sdp_gdp() [G-W]` = gw_ddy %>% add_sdp_gdp(),
  `add_strategic_rivalries()` = cow_ddy %>% add_strategic_rivalries(),
  `filter_prd() [+ add_contiguity() + add_cow_majors()]` = cow_ddy %>% filter_prd(),
  unit = "s",
  times = 100)

saveRDS(dyad_bench, "~/Dropbox/projects/peacesciencer/data-raw/times/dyad_bench.rds")
