library(tidyverse)

cow_sdp_gdp <- readRDS("~/Dropbox/data/surplus-gdp/master.rds") %>%
  select(ccode, year, WorldBank_gdp_2011_ppp_estimate, WorldBank_pop_estimate, gdp_surplus1095_truncated) %>%
  rename(wbgdp2011est = WorldBank_gdp_2011_ppp_estimate,
         wbpopest = WorldBank_pop_estimate,
         sdpest = gdp_surplus1095_truncated) %>%
  # IIRC, R seems to get squeamish with file sizes for really large nominal numbers, like these. So +1 and log
  # That'll standardize with the gw_* data frame next as well.
  mutate_at(vars(wbgdp2011est, wbpopest, sdpest), ~log(.+1)) %>%
  # I'm *pretty sure* Anders et al. are including years for which the state is not in the CoW system.
  # That'd explain why there are more rows in here than they should be.
  # The ultimate test for this for when left_join creates duplicates.
  # I don't think they will here, but that's why I test for that.
  print()

save(cow_sdp_gdp, file="data/cow_sdp_gdp.rda")

gw_sdp_gdp <- read_csv("~/Dropbox/data/surplus-gdp/gdp_pop_sdp_estimates.csv") %>%
  rename(gwcode = gwno,
         wbgdp2011est = WorldBank_gdp_2011_ppp_estimate,
         wbpopest = WorldBank_pop_estimate,
         sdpest = sdp) %>%
  select(gwcode, year, wbgdp2011est,wbpopest,sdpest) %>%
  print()

save(gw_sdp_gdp, file="data/gw_sdp_gdp.rda")

# fiddling with things here...

create_stateyears() %>%
  left_join(., cow_surplus_gdp)

create_stateyears(system = "gw") %>%
  left_join(., gw_surplus_gdp)

cow_surplus_gdp %>%
  group_by(ccode, year) %>%
  tally() %>%
  arrange(-n)
