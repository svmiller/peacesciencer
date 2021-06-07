library(tidyverse)
library(lubridate)
library(sqldf)

cow_war_inter_raw <- read_csv("~/Dropbox/data/cow/wars/Inter-StateWarData_v4.0.csv") %>%
  rename_all(tolower) %>%
  select(warnum:endyear2, initiator, outcome, batdeath) %>%
  print()

# Are there any missing months, god help us?

cow_war_inter_raw %>%
  filter_at(vars(contains("month")), any_vars(. == -9))

# thank god. any missing days?

cow_war_inter_raw %>%
  filter_at(vars(contains("day")), any_vars(. == -9))


# Even better

# Anything ongoing as of 12/31/2007?
cow_war_inter_raw %>%
  filter_at(vars(contains("day")), any_vars(. == -7))

# interesting, but good for data purposes.

# Let's isolate the combat resumption episodes. We'll deal with them later.

cow_war_inter_raw %>%
  filter(startyear2 != -8) %>%
  mutate(resume_combat = 1) -> combat_resumes



cow_war_inter_raw %>%
  mutate(stdate = make_date(startyear1, startmonth1, startday1),
         enddate = make_date(endyear1, endmonth1, endday1)) %>%
  rowwise() %>%
  mutate(date = list(seq(stdate, enddate, by = "1 day"))) %>%
  unnest(date) %>%
  select(warnum:side, date, initiator, batdeath, outcome) %>%
  arrange(warnum, date, ccode) %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date)) -> base_dates



base_dates

combat_resumes %>%
  mutate(stdate = make_date(startyear2, startmonth2, startday2),
         enddate = make_date(endyear2, endmonth2, endday2)) %>%
  rowwise() %>%
  mutate(date = list(seq(stdate, enddate, by = "1 day"))) %>%
  unnest(date) %>%
  select(warnum:side, date, initiator, batdeath, outcome) %>%
  arrange(warnum, date, ccode) %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date)) -> resume_dates


sqldf("select A.warnum warnum, A.ccode ccode1, B.ccode ccode2,
      A.year year1, B.year year2, A.month month1, B.month month2, A.day day1, B.day day2,
      A.side sidea1, B.side sidea2,
      A.initiator initiator1, B.initiator initiator2,
      A.outcome outcome1, B.outcome outcome2,
      A.batdeath batdeath1, B.batdeath batdeath2
             from base_dates A join base_dates B using (warnum)
             where A.ccode != B.ccode AND
             sidea1 != sidea2 AND year1 == year2 AND month1 == month2 AND day1 == day2
             order by A.ccode, B.ccode") %>% as_tibble() %>%
  # Some nip-and-tuck...
  rename(year = year1) %>%
  select(-year2, -month1:-day2) %>%
  group_by(warnum, ccode1, ccode2, year, sidea1, sidea2) %>% slice(1) %>%
  arrange(warnum) %>%
  ungroup() -> base_war_years

base_war_years %>%
  arrange(warnum, ccode1, ccode2, year) %>%
  group_by(warnum, ccode1, ccode2) %>%
  mutate(cowinterongoing = 1,
         cowinteronset = ifelse(row_number() == 1, 1, 0),
         resume = 0) %>% ungroup() -> base_war_years


sqldf("select A.warnum warnum, A.ccode ccode1, B.ccode ccode2,
      A.year year1, B.year year2, A.month month1, B.month month2, A.day day1, B.day day2,
      A.side sidea1, B.side sidea2,
      A.initiator initiator1, B.initiator initiator2,
      A.batdeath batdeath1, B.batdeath batdeath2
             from resume_dates A join resume_dates B using (warnum)
             where A.ccode != B.ccode AND
             sidea1 != sidea2 AND year1 == year2 AND month1 == month2 AND day1 == day2
             order by A.ccode, B.ccode") %>% as_tibble() %>%
  # Some nip-and-tuck...
  rename(year = year1) %>%
  select(-year2, -month1:-day2) %>%
  group_by(warnum, ccode1, ccode2, year, sidea1, sidea2) %>% slice(1) %>%
  arrange(warnum) %>%
  ungroup() -> resume_war_years

resume_war_years %>%
  arrange(warnum, ccode1, ccode2, year) %>%
  group_by(warnum, ccode1, ccode2) %>%
  mutate(cowinterongoing = 1,
         cowinteronset = ifelse(row_number() == 1, 1, 0),
         resume = 1) %>% ungroup() -> resume_war_years


bind_rows(base_war_years, resume_war_years) %>%
  mutate_at(vars(contains("initi")), ~ifelse(. == 1, 1, 0)) %>%
  select(warnum:year, cowinterongoing, cowinteronset, everything()) -> cow_war_inter


save(cow_war_inter, file="data/cow_war_inter.rda")


# fiddle with things...


