library(tidyverse)

cow_nmc <- read_csv("/home/steve/Dropbox/data/cow/cinc/NMC_5_0.csv") %>%
  select(-version, -stateabb)

save(cow_nmc, file="data/cow_nmc.rda")
