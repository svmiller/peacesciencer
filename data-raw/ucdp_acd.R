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

ucdp_acd %>%
  mutate(type_of_conflict = case_when(
    type_of_conflict == 1 ~ "extrasystemic",
    type_of_conflict == 2 ~ "interstate",
    type_of_conflict == 3 ~ "intrastate",
    type_of_conflict == 4 ~ "II",
  )) -> ucdp_acd

ucdp_acd %>%
  mutate(incompatibility = case_when(
    incompatibility == 1 ~ "territory",
    incompatibility == 2 ~ "government",
    incompatibility == 3 ~ "both"
  )) -> ucdp_acd

save(ucdp_acd, file="data/ucdp_acd.rda")


# Here is where I fiddle with things...

ucdp_acd %>%
  mutate(gwcode = gwno_a) %>%
  bind_rows(., ucdp_acd %>% mutate(gwcode = gwno_a_2nd)) %>%
  bind_rows(., ucdp_acd %>% mutate(gwcode = gwno_b)) %>%
  bind_rows(., ucdp_acd %>% mutate(gwcode = gwno_b_2nd)) %>%
  filter(!is.na(gwcode)) %>%
  mutate(sidea = case_when(gwcode == gwno_a ~ 1,
                           gwcode == gwno_a_2nd ~ 1,
                           TRUE ~ 0)) %>%
  select(conflict_id, year, gwcode, sidea, everything()) %>%
  arrange(year, conflict_id) %>%
  filter(type_of_conflict == 2) %>% summary


ucdp_acd %>%
  distinct(start_date2)



ucdp_acd %>%
  filter(is.na(gwno_b)) %>%
  distinct(type_of_conflict)


ucdp_acd %>%
  filter(type_of_conflict %in% c(1, 3)) %>% summary


ucdp_acd %>%
  filter(!is.na(gwno_b))


ucdp_acd %>%
  filter(conflict_id == 11345) %>%
  data.frame



ucdp_acd %>%
  filter(type_of_conflict == 3) %>%
  mutate(epstyear = lubridate::year(start_date2),
         ependyear = lubridate::year(ep_end_date)) %>%
  mutate()





create_stateyears(system = "gw") %>%
  add_ucdp_acd()
  group_by(conflict_id, gwno_a, year) %>% slice(1) %>%
  arrange(conflict_id, gwno_a, year) %>%
  group_by(conflict_id, gwno_a) %>%
  mutate(ucdponset = ifelse(row_number() == 1, 1, 0)) %>%
  group_by(gwno_a, year) %>%
  summarize(ucdpongoing = 1,
            maxintensity = max(intensity_level),
            ucdponset = max(ucdponset),
            conflict_ids = paste0(conflict_id, collapse = "; ")) %>%
  ungroup() %>%
  rename(gwcode = gwno_a) %>%
  left_join(create_stateyears() %>% filter(year >= 1945), .)

ucdp_acd %>%
  select(gwno_a,  start_date2, ep_end_date)



