library(tidyverse)
library(qs)

# This is just the dyadic_formatv3.csv, but compressed because Jesus this file is huge.
QIGO <- qs::qread("~/Dropbox/data/cow/igo/dyadic_formatv3.qs") %>%
  # If it's negative, it's either missing or IGO not in existence
  mutate_at(vars(AALCO:ncol(.)), ~ifelse(. < 0, NA, .))

QIGO  %>%
  select(AALCO:ncol(.)) -> the_igos

QIGO$dyadigos <- rowSums(the_igos[,1:ncol(the_igos)], na.rm=TRUE)

QIGO %>% select(ccode1, ccode2, year, dyadigos) -> cow_igo_ndy

save(cow_igo_ndy, file="data/cow_igo_ndy.rda")

read_csv("~/Dropbox/data/cow/igo/state_year_formatv3.csv") %>%
  # If it's negative, it's either missing or IGO not in existence
  mutate_at(vars(AAAID:ncol(.)), ~ifelse(. < 0, NA, .)) %>%
  select(-state) %>%
  group_by(ccode, year) %>%
  gather(igo, member_code, AAAID:ncol(.)) %>%
  mutate(full = ifelse(member_code == 1, 1, 0),
         associate = ifelse(member_code == 2, 1, 0),
         observer = ifelse(member_code == 3, 1, 0),
         anytype = ifelse(member_code >= 1, 1, 0)) -> SY_IGO

SY_IGO %>%
  summarize(sum_igo_full = sum(full, na.rm=T),
            sum_igo_associate = sum(associate, na.rm=T),
            sum_igo_observer = sum(observer, na.rm=T),
            sum_igo_anytype = sum(anytype, na.rm=T)) %>%
  ungroup() -> cow_igo_sy


save(cow_igo_sy, file="data/cow_igo_sy.rda")
