library(tidyverse)

read_csv("~/Dropbox/data/cow/alliance/4.1/alliance_v4.1_by_directed_yearly.csv") %>%
  select(ccode1, ccode2, year, left_censor, right_censor, defense:entente) -> cow_alliance

cow_alliance %>%
  select(-left_censor, -right_censor) %>%
  group_by(ccode1, ccode2, year) %>%
  # There will be duplicates.
  summarize_at(vars("defense","neutrality","nonaggression", "entente"), ~sum(.)) -> cow_alliance

cow_alliance %>%
  ungroup() %>%
  mutate_at(vars("defense","neutrality","nonaggression", "entente"), ~ifelse(. > 1, 1, .)) -> cow_alliance

cow_alliance %>%
  rename(cow_defense = defense,
         cow_neutral = neutrality,
         cow_nonagg = nonaggression,
         cow_entente = entente) -> cow_alliance

save(cow_alliance, file="data/cow_alliance.rda")

