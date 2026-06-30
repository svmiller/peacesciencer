library(tidyverse)

cow_nmc <- read_csv("~/Koofr/data/cow/nmc/7.0/NMC-70-abridged.csv") %>%
  select(-version, -stateabb) %>%
  mutate_at(vars(-ccode, -year), ~ifelse(. == -9, NA, .)) %>% print()

save(cow_nmc, file="data/cow_nmc.rda")
