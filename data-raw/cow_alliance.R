library(tidyverse)
# We're going to have to be careful here. Turns out the directed dyad-year data aren't directed at all.
# See: https://github.com/svmiller/peacesciencer/issues/13
# So, we'll have to use undirected data, then direct them manually

# read_csv("~/Dropbox/data/cow/alliance/4.1/alliance_v4.1_by_directed_yearly.csv") %>%
#   select(ccode1, ccode2, year, left_censor, right_censor, defense:entente) -> cow_alliance
#
# cow_alliance %>%
#   select(-left_censor, -right_censor) %>%
#   group_by(ccode1, ccode2, year) %>%
#   # There will be duplicates.
#   summarize_at(vars("defense","neutrality","nonaggression", "entente"), ~sum(.)) -> cow_alliance
#
# cow_alliance %>%
#   ungroup() %>%
#   mutate_at(vars("defense","neutrality","nonaggression", "entente"), ~ifelse(. > 1, 1, .)) -> cow_alliance
#
# cow_alliance %>%
#   rename(cow_defense = defense,
#          cow_neutral = neutrality,
#          cow_nonagg = nonaggression,
#          cow_entente = entente) -> cow_alliance
# ^ old, for posterity.

read_csv("~/Dropbox/data/cow/alliance/4.1/alliance_v4.1_by_dyad_yearly.csv") %>%
  select(ccode1, ccode2, year, defense:entente) %>%
  group_by(ccode1, ccode2, year) %>%
  # There will be duplicates.
  summarize_at(vars("defense","neutrality","nonaggression", "entente"), ~sum(., na.rm=T)) %>%
  ungroup() %>%
  mutate_at(vars("defense","neutrality","nonaggression", "entente"), ~ifelse(. > 1, 1, .)) -> hold_this

hold_this %>%
  # There are two observations (2-666, 651-666) where year == 0
  # This was an error in the dyad-year data, based on the dyad data.
  # In the 2-666 case, it should be 1981 to 1991. This was an entente.
  # In the 651-666 case, it should be 1979 to 2012. This is a nonagg.
  filter(year == 0) %>%
  mutate(startyear = c(1981, 1979),
         endyear = c(1991, 2012)) %>%
  rowwise() %>%
  mutate(year = list(seq(startyear, endyear))) %>%
  unnest(year) %>%
  select(-startyear, -endyear) %>%
  bind_rows(hold_this, .) %>%
  # Let's get rid of those zero years now....
  filter(year != 0) %>%
  arrange(ccode1, ccode2, year) -> hold_this

hold_this %>%
  rename(ccode1 = ccode2,
         ccode2 = ccode1) %>%
  bind_rows(hold_this, .) %>%
  rename(cow_defense = defense,
         cow_neutral = neutrality,
         cow_nonagg = nonaggression,
         cow_entente = entente) -> cow_alliance


save(cow_alliance, file="data/cow_alliance.rda")

