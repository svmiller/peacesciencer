library(tidyverse)

ucdp_acd <- readxl::read_excel("~/Dropbox/data/ucdpprio/acd/ucdp-prio-acd-201.xlsx")

# I'mma select just what I want

ucdp_acd %>%
  select(conflict_id, year, gwno_a, gwno_a_2nd, gwno_b, gwno_b_2nd,
         incompatibility, intensity_level, type_of_conflict:ep_end_date) -> ucdp_acd

# Oof, I hate how UCDP does this. Alas, let's do it. I'd think this work.
# conflict_id == 420, 252, and 412 should be a nice trial balloon to how well this works.
# conflict_id == 218 = Kashmir. Also a good trial balloon for how well I'm capturing recurring conflicts and conflicts that span years.
# conflict_id == 11345 = South Sudan, which has no end date. Also a good trial balloon.

ucdp_acd %>%
  mutate(gwno_a = strsplit(as.character(gwno_a), ",")) %>%
  unnest(gwno_a) %>%
  mutate(gwno_a_2nd = strsplit(as.character(gwno_a_2nd), ",")) %>%
  unnest(gwno_a_2nd) %>%
  mutate(gwno_b = strsplit(as.character(gwno_b), ",")) %>%
  unnest(gwno_b) %>%
  mutate(gwno_b_2nd = strsplit(as.character(gwno_b_2nd), ",")) %>%
  unnest(gwno_b_2nd) -> ucdp_acd


ucdp_acd %>%
  mutate_at(vars("start_date", "start_date2", "ep_end_date"), ~lubridate::ymd(.)) %>%
  mutate_at(vars("gwno_a", "gwno_a_2nd", "gwno_b", "gwno_b_2nd"), ~as.numeric(.)) -> ucdp_acd

save(ucdp_acd, file="data/ucdp_acd.rda")


# Here is where I fiddle with things...

ucdp_acd %>%
  filter(type_of_conflict %in% c(1, 3)) %>% summary


ucdp_acd %>%
  filter(conflict_id == 11345) %>%
  data.frame


ucdp_acd %>%
  filter(!is.na(gwno_a) & is.na(gwno_b) & !is.na(gwno_b_2nd))
  # filter(conflict_id == 412) %>%
  select(conflict_id, gwno_a, gwno_a_2nd, gwno_b, gwno_b_2nd) %>%
  mutate_at(vars("gwno_a", "gwno_a_2nd", "gwno_b", "gwno_b_2nd"), ~as.numeric(.))
