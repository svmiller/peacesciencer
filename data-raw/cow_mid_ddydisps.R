library(tidyverse)
library(peacesciencer)


cow_mid_dirdisps %>%
  group_by(ccode1, ccode2, year)  %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  # Remove anything that's not a unique MID onset
  mutate(sd = sd(disponset),
         sd = ifelse(is.na(sd), 0, sd)) %>%
  mutate(removeme = ifelse(duplicated == 1 & disponset == 0 & sd > 0, 1, 0)) %>%
  filter(removeme != 1) %>%
  # remove detritus
  select(-removeme, -sd) %>%
  # practice safe group_by()
  ungroup() -> hold_this

hold_this %>%
  left_join(., cow_mid_disps %>% select(dispnum, fatality)) %>%
  mutate(fatality = ifelse(fatality == -9, .5, fatality)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the highest fatality
  filter(fatality == max(fatality)) %>%
  mutate(fatality = ifelse(fatality == .5, -9, fatality)) %>%
  arrange(ccode1, ccode2, year) %>%
  # practice safe group_by()
  ungroup() -> hold_this


hold_this %>%
  left_join(., cow_mid_disps %>% select(dispnum, hostlev)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the highest hostlev
  filter(hostlev == max(hostlev)) %>%
  arrange(ccode1, ccode2, year) %>%
  # practice safe group_by()
  ungroup() -> hold_this
#> Joining, by = "dispnum"


hold_this %>%
  left_join(., cow_mid_disps %>% select(dispnum, mindur, maxdur)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the highest mindur
  filter(mindur == max(mindur)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the highest maxdur
  filter(maxdur == max(maxdur)) %>%
  # practice safe group_by()
  ungroup() -> hold_this
#> Joining, by = "dispnum"


hold_this %>%
  left_join(., cow_mid_disps %>% select(dispnum, recip)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the reciprocated ones, where non-reciprocated ones exist
  filter(recip == max(recip)) %>%
  arrange(ccode1, ccode2, year) %>%
  # practice safe group_by()
  ungroup() -> hold_this
#> Joining, by = "dispnum"

hold_this %>%
  left_join(., cow_mid_disps %>% select(dispnum, stmon)) %>%
  arrange(ccode1, ccode2, year) %>%
  group_by(ccode1, ccode2, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  group_by(ccode1, ccode2, year, duplicated) %>%
  # Keep the reciprocated ones, where non-reciprocated ones exist
  filter(stmon == min(stmon)) %>%
  arrange(ccode1, ccode2, year) %>%
  # practice safe group_by()
  ungroup() -> cow_mid_ddydisps

cow_mid_ddydisps %>%
  rename(cowmidongoing = dispongoing,
         cowmidonset = disponset) -> cow_mid_ddydisps



save(cow_mid_ddydisps, file="data/cow_mid_ddydisps.rda")

