library(tidyverse)

read_csv("~/Dropbox/data/cow/mid/5/MIDA 5.0.csv") %>%
  select(dispnum, styear, stmon, outcome, settle, fatality, mindur, maxdur, hiact, hostlev, recip) -> cow_mid_disps

save(cow_mid_disps, file="data/cow_mid_disps.rda")

