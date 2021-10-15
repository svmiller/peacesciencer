library(tidyverse)

cow_sdp_gdp <- readRDS("~/Dropbox/data/surplus-gdp/master.rds") %>%
  select(ccode, year, WorldBank_gdp_2011_ppp_estimate, WorldBank_pop_estimate, gdp_surplus1095_truncated) %>%
  rename(wbgdp2011est = WorldBank_gdp_2011_ppp_estimate,
         wbpopest = WorldBank_pop_estimate,
         sdpest = gdp_surplus1095_truncated) %>%
  mutate(wbgdppc2011est = wbgdp2011est/wbpopest) %>%
  # IIRC, R seems to get squeamish with file sizes for really large nominal numbers, like these. So +1 and log
  # That'll standardize with the gw_* data frame next as well.
  mutate_at(vars(wbgdp2011est, wbpopest, sdpest, wbgdppc2011est), ~log(.+1)) %>%
  # I'm *pretty sure* Anders et al. are including years for which the state is not in the CoW system.
  # That'd explain why there are more rows in here than they should be.
  # The ultimate test for this for when left_join creates duplicates.
  # I don't think they will here, but that's why I test for that.
  print()


# Save a remote version, just in case.
saveRDS(cow_sdp_gdp, "~/Dropbox/svmiller.github.io/R/peacesciencer/cow_sdp_gdp.rds")

# I don't like that I'm doing this, but I think it makes the most sense for future space considerations
# Basically, I'm going to round the information provided here to three decimal points.
# These "economic" data are routinely the biggest in the package, and it's because of the decimal points.
# JUSTIFICATION: these data are estimated/simulated anyways, and the information loss this will do
#   is just at the 1/1000ths decimal point.

cow_sdp_gdp %>%
  mutate_at(vars(wbgdp2011est:ncol(.)), ~round(., 3)) -> cow_sdp_gdp

save(cow_sdp_gdp, file="data/cow_sdp_gdp.rda")
