library(tidyverse)

cow_war_extra_raw <- read_csv("~/Dropbox/data/cow/wars/Extra-StateWarData_v4.0.csv") %>%
  rename_all(tolower) %>%
  select(warnum:interven, outcome, batdeath, nonstatedeaths) %>%
  print()


cow_war_extra_raw









cow_war_intra_raw <- read_csv("~/Dropbox/data/cow/wars/Intra-StateWarData_v4.1.csv") %>%
  rename_all(tolower) %>%
  select(warnum:endyear2, outcome, sideadeaths, sidebdeaths) %>%
  filter(wartype %in% c(4,5)) %>%
  mutate(wartype = ifelse(wartype == 4, "central control", "local issues")) %>%
  mutate(primary_state = ifelse(ccodea != -8 & sideb != "-8", 1, 0),
         ongo2007 = ifelse(endyear1 == -7, 1, 0)) %>%
  select(warnum:wartype, primary_state, everything()) %>%
  print()


cow_war_intra_raw %>%
  filter(startyear2 != -8) %>%
  mutate(resume_combat = 1) -> combat_resumes

# warnum 585 ("Yellow Cliff Revolt") has an NA for endyear1. I'm just going to guess 1866.
# That's kind of what Dixon and Sarkees imply in their book.

cow_war_intra_raw %>%
  mutate(endyear1 = ifelse(endyear1 == -7, 2007, endyear1)) %>%
  mutate(endyear1 = ifelse(warnum == 585, 1866, endyear1)) %>%
  rowwise() %>%
  mutate(year = list(seq(startyear1, endyear1))) %>%
  unnest(year) %>%
  select(warnum:warname, year, wartype:intnl, outcome, sideadeaths, sidebdeaths, ongo2007) %>%
  arrange(warnum, year) %>%
  group_by(warnum) %>%
  mutate(cowintraonset = ifelse(row_number() == 1, 1, 0)) %>% ungroup() -> cow_war_intra



combat_resumes %>%
  rowwise() %>%
  mutate(year = list(seq(startyear2, endyear2))) %>%
  unnest(year) %>%
  select(warnum:warname, year, wartype:intnl, outcome, sideadeaths, sidebdeaths, ongo2007, resume_combat) %>%
  arrange(warnum, year) %>%
  group_by(warnum) %>%
  mutate(cowintraonset = ifelse(row_number() == 1, 1, 0))  %>% ungroup() %>%
  bind_rows(cow_war_intra, .) %>%
  mutate(resume_combat = ifelse(is.na(resume_combat), 0, resume_combat)) %>%
  arrange(warnum, -primary_state, year) -> cow_war_intra


cow_war_intra %>%
  mutate(cowintraongoing = 1) %>%
  select(warnum, warname, wartype, year, cowintraonset, cowintraongoing, resume_combat, everything()) -> cow_war_intra

save(cow_war_intra, file="data/cow_war_intra.rda")


# fiddle with things...

cow_war_intra %>%
  rename(ccode = ccodea) %>%
  filter(primary_state == 1) %>%
  # filter(wartype == "central control") %>%
  group_by(ccode, year) %>%
  mutate(intrawarnums = paste0(.data$warnum, collapse = "; ")) %>%
  #filter(n() > 1) %>%
  select(warnum:wartype, ccode, year, everything()) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0),
         sd = sd(cowcwonset)) %>%
  # Remove anything that's not a unique war onset
  mutate(removeme = case_when(
    duplicated == 1 & sd > 0 & cowcwonset == 0 ~ 1,
    TRUE ~ 0
  )) %>%
  filter(removeme == 0) %>%
  group_by(ccode, year) %>%
  # filter(n() > 1) %>%
  mutate_at(vars(contains("deaths")), ~ifelse(. < 0, NA, .)) %>%
  rowwise() %>%
  mutate(deaths = sideadeaths + sidebdeaths) %>%
  mutate(deaths = case_when(
    is.na(deaths) & is.na(sidebdeaths) ~ sideadeaths,
    is.na(deaths) & is.na(sideadeaths) ~ sidebdeaths,
    TRUE ~ deaths
  )) %>%
  group_by(ccode, year) %>%
  mutate(duplicated = ifelse(n() > 1, 1, 0)) %>%
  arrange(-deaths) %>%
  slice(1) %>%
  ungroup() %>%
  select(warnum:cowcwongoing, intnl, outcome, sideadeaths, sidebdeaths) %>%
  # selecting on primary states means there are no -8s, just -9s where missing
  mutate_at(vars(contains("deaths")), ~ifelse(is.na(.), -9, .)) -> the_data



cow_war_intra %>%
  rename(ccode = ccodea) %>%
  filter(primary_state == 1) %>%
  filter(wartype == "central control") %>%
  mutate_at(vars(contains("deaths")), ~ifelse(. < 0, NA, .)) %>% data.frame
