library(tidyverse)

read_csv("~/Dropbox/projects/mid-project/gml-mid-data/2.2.1/gml-mida-2.2.1.csv") %>%
  select(dispnum, styear, stmon, outcome, settle, fatality, mindur, maxdur, hiact, hostlev, recip) -> gml_mid_disps

save(gml_mid_disps, file="data/gml_mid_disps.rda")

