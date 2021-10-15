library(tidyverse)
gw_sdp_gdp <- read_csv("~/Dropbox/data/surplus-gdp/gdp_pop_sdp_estimates.csv") %>%
  rename(gwcode = gwno,
         wbgdp2011est = WorldBank_gdp_2011_ppp_estimate,
         wbpopest = WorldBank_pop_estimate,
         sdpest = sdp) %>%
  select(gwcode, year, wbgdp2011est,wbpopest,sdpest) %>%
  mutate(wbgdppc2011est = log(exp(wbgdp2011est)/exp(wbpopest) +1)) %>%
  print()


# Save a remote version, just in case.
saveRDS(gw_sdp_gdp, "~/Dropbox/svmiller.github.io/R/peacesciencer/gw_sdp_gdp.rds")

# I don't like that I'm doing this, but I think it makes the most sense for future space considerations
# Basically, I'm going to round the information provided here to three decimal points.
# These "economic" data are routinely the biggest in the package, and it's because of the decimal points.
# JUSTIFICATION: these data are estimated/simulated anyways, and the information loss this will do
#   is just at the 1/1000ths decimal point.

gw_sdp_gdp %>%
  mutate_at(vars(wbgdp2011est:ncol(.)), ~round(., 3)) -> gw_sdp_gdp

save(gw_sdp_gdp, file="data/gw_sdp_gdp.rda")
