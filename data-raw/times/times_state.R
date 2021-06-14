library(tidyverse)
library(peacesciencer)
library(microbenchmark)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# Create some data ----

sy_gw <- create_stateyears(system = "gw")
sy_gw_ucdp <- create_stateyears(system = "gw") %>% add_ucdp_acd()
sy_cow <- create_stateyears()
sy_cow_intra <- create_stateyears() %>% add_cow_wars(type="intra")


# https://stackoverflow.com/questions/43662457/convert-list-of-vectors-to-data-frame
# ^ inspiration for {microbenchmark} approach

state_bench <- microbenchmark::microbenchmark(
  `add_archigos()` = sy_cow %>% add_archigos(),
  `add_capital_distance()` = sy_cow %>% add_capital_distance(),
  `add_ccode_to_gw()` = sy_gw %>% add_ccode_to_gw(),
  `add_contiguity()` = sy_cow %>% add_contiguity(),
  `add_cow_majors()` = sy_cow %>% add_cow_majors(),
  `add_cow_trade()` = sy_cow %>% add_cow_trade(),
  `add_cow_wars(type="intra")` = sy_cow %>% add_cow_wars(type = "intra"),
  `add_creg_fractionalization() [CoW]` = sy_cow %>% add_creg_fractionalization(),
  `add_creg_fractionalization() [G-W]` = sy_gw %>% add_creg_fractionalization(),
  `add_democracy() [CoW]` = sy_cow %>% add_democracy(),
  `add_democracy() [G-W]` = sy_gw %>% add_democracy(),
  `add_gwcode_to_cow()` = sy_cow %>% add_gwcode_to_cow(),
  `add_igos()` = sy_cow %>% add_igos(),
  `add_minimum_distance() [CoW]` = sy_cow %>% add_minimum_distance(),
  `add_minimum_distance() [G-W]` = sy_gw %>% add_minimum_distance(),
  `add_nmc()` = sy_cow %>% add_nmc(),
  `add_peace_years() [CoW Intra-State Wars]` = sy_cow_intra %>% add_peace_years(),
  `add_peace_years() [(G-W) UCDP ACD]` = sy_gw_ucdp %>% add_peace_years(),
  `add_rugged_terrain() [CoW]` = sy_cow %>% add_rugged_terrain(),
  `add_rugged_terrain() [G-W]` = sy_gw %>% add_rugged_terrain(),
  `add_sdp_gdp() [CoW]` = sy_cow %>% add_sdp_gdp(),
  `add_sdp_gdp() [G-W]` = sy_gw %>% add_sdp_gdp(),
  `add_strategic_rivalries()` = sy_cow %>% add_strategic_rivalries(),
  `add_ucdp_acd()` = sy_gw %>% add_ucdp_acd(),
  unit = "s",
  times = 100)

saveRDS(state_bench, "~/Dropbox/projects/peacesciencer/data-raw/times/state_bench.rds")
