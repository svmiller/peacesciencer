# Note that this depends on the creation of `archigos` as a data frame, which is
# already included in this package. `archigos.R` in this directory describes
# the creation of this data.

library(tidyverse)

archigos %>%
  rowwise() %>%
  mutate(date = list(seq(startdate, enddate, by="1 day"))) %>%
  unnest(date) %>%
  mutate(year = lubridate::year(date)) %>%
  filter(year >= 1870) %>%
  arrange(date) %>%
  group_by(gwcode, year) %>%
  mutate(jan1obsid = first(obsid),
         dec31obsid = last(obsid),
         leadertransition = ifelse(jan1obsid != dec31obsid, 1, 0),
         n_leaders = n_distinct(leadid),
         irregular = ifelse(leadertransition == 1 & any(exit == "Irregular"), 1, 0)) %>%
  group_by(gwcode, year) %>%
  select(gwcode, year, leadertransition, irregular, n_leaders, jan1obsid, dec31obsid) %>%
  group_by(gwcode, year) %>%
  slice(1) %>% ungroup() -> archigossums

archigossums

save(archigossums, file="data/archigossums.rda")
