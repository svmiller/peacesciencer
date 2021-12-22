library(tidyverse)

cow_nmc <- read_csv("/home/steve/Dropbox/data/cow/nmc/6.0/NMC-60-abridged.csv") %>%
  select(-version, -stateabb) %>%
  mutate_at(vars(-ccode, -year), ~ifelse(. == -9, NA, .)) %>% print()

save(cow_nmc, file="data/cow_nmc.rda")
