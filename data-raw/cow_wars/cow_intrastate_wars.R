library(tidyverse)

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
  mutate(cowcwonset = ifelse(row_number() == 1, 1, 0)) %>% ungroup() -> cow_war_intra



combat_resumes %>%
  rowwise() %>%
  mutate(year = list(seq(startyear2, endyear2))) %>%
  unnest(year) %>%
  select(warnum:warname, year, wartype:intnl, outcome, sideadeaths, sidebdeaths, ongo2007, resume_combat) %>%
  arrange(warnum, year) %>%
  group_by(warnum) %>%
  mutate(cowcwonset = ifelse(row_number() == 1, 1, 0))  %>% ungroup() %>%
  bind_rows(cow_war_intra, .) %>%
  mutate(resume_combat = ifelse(is.na(resume_combat), 0, resume_combat)) %>%
  arrange(warnum, -primary_state, year) -> cow_war_intra


cow_war_intra %>%
  mutate(cowcwongoing = 1) %>%
  select(warnum, warname, wartype, year, cowcwonset, cowcwongoing, resume_combat, everything()) -> cow_war_intra

save(cow_war_intra, file="data/cow_war_intra.rda")
