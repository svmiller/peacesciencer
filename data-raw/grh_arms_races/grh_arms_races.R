library(tidyverse)
library(stevemisc)

readxl::read_excel("~/Dropbox/projects/peacesciencer/data-raw/grh_arms_races/grh_arms_races.xlsx") %>%
  select(-state1, -state2) -> grh_arms_races


save(grh_arms_races, file="data/grh_arms_races.rda")
