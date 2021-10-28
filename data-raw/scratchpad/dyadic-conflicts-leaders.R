library(tidyverse)
library(peacesciencer)
library(lubridate)

leaderdays <- create_leaderdays(standardize_cow = TRUE) %>% select(obsid, ccode, date)

gml_part %>%
  filter(.data$allmiss_leader_start == 0 & .data$allmiss_leader_end == 0) %>%
  mutate(stdate = as.Date(paste0(.data$styear,"/", .data$stmon,"/", .data$dummy_stday)),
         enddate = as.Date(paste0(.data$endyear,"/", .data$endmon,"/", .data$dummy_endday))) %>%
  rowwise() %>%
  mutate(date = list(seq(.data$stdate, .data$enddate, by = "1 day")),
         gmlmidonset = list(ifelse(date == min(.data$date), 1, 0))) %>%
  unnest(c(.data$date, .data$gmlmidonset)) %>%
  mutate(gmlmidongoing = 1) %>%
  select(dispnum, ccode, date, gmlmidonset, gmlmidongoing, sidea, orig, obsid_start, obsid_end) %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date)) -> longpart

library(sqldf)

sqldf("select A.dispnum dispnum, A.ccode ccode1, B.ccode ccode2,
      A.year year1, B.year year2, A.month month1, B.month month2, A.day day1, B.day day2,
      A.sidea sidea1, B.sidea sidea2,
             A.orig orig1, B.orig orig2,
             A.obsid_start obsid_start1, B.obsid_start obsid_start2,
             A.obsid_end obsid_end1, B.obsid_end obsid_end2
             from longpart A join longpart B using (dispnum)
             where A.ccode != B.ccode AND
             sidea1 != sidea2 AND year1 == year2 AND month1 == month2 AND day1 == day2
             order by A.dispnum, A.ccode, B.ccode") %>% as_tibble() %>%
  rename(year = year1,
         month = month1,
         day = day1)  -> dyadic_conflict_leader_days

dyadic_conflict_leader_days %>%
  select(-year2, -month2, -day2) %>%
  mutate(date = make_date(year, month, day)) %>%
  select(dispnum, ccode1, ccode2, date, everything(), -year, -month,-day) -> dyadic_conflict_leader_days

longpart %>% select(dispnum, ccode, date, gmlmidonset, gmlmidongoing)  %>%
  rename(ccode1 = ccode,
         gmlmidonset1 = gmlmidonset,
         gmlmidongoing1 = gmlmidongoing) %>%
  left_join(dyadic_conflict_leader_days, .) -> dyadic_conflict_leader_days

longpart %>% select(dispnum, ccode, date, gmlmidonset, gmlmidongoing)  %>%
  rename(ccode2 = ccode,
         gmlmidonset2 = gmlmidonset,
         gmlmidongoing2 = gmlmidongoing) %>%
  left_join(dyadic_conflict_leader_days, .) -> dyadic_conflict_leader_days


dyadic_conflict_leader_days

dyadic_conflict_leader_days %>%
  # This will create duplicates, and that's normal, because it's picking up leader transitions. We want those.
  left_join(., leaderdays %>% rename(ccode1 = ccode, obsid1 = obsid)) %>%
  left_join(., leaderdays %>% rename(ccode2 = ccode, obsid2 = obsid)) -> dyadic_conflict_leader_days

# dyadic_conflict_leader_days %>%
#   arrange(dispnum, ccode1, ccode2, obsid1, obsid2, date) %>%
#   mutate(year = lubridate::year(date)) %>%
#   group_by(dispnum, obsid1, obsid2, year) %>%
#   filter(row_number() == 1) # %>% slice(1) %>% ungroup() %>% slice(1) %>% data.frame()

saveRDS(dyadic_conflict_leader_days, "~/Dropbox/svmiller.github.io/R/peacesciencer/dyadic_conflict_leader_days.rds")


dyadic_conflict_leader_days %>%
  arrange(dispnum, ccode1, ccode2, obsid1, obsid2, date) %>%
  mutate(year = lubridate::year(date)) %>%
  group_by(dispnum, obsid1, obsid2, year) %>%
  filter(row_number() == 1) %>%
  ungroup() %>%
  # Create new onsets/ongoings. The ongoings are easy.
  # The onsets are recoded such that if either side is a 1, it's a new entry for at least one of them and thus a new dyadic onset.
  mutate(gmlmidongoing = 1,
         gmlmidonset = ifelse(gmlmidonset1 == 1 | gmlmidonset2 == 1, 1, 0)) %>%
  select(dispnum:ccode2, obsid1, obsid2, year, sidea1:orig2, gmlmidongoing, gmlmidonset, obsid_start1:obsid_end2) -> dyadic_conflict_leader_years



attr(dyadic_conflict_leader_years, "ps_data_type") = "leader_dyad_year"
attr(dyadic_conflict_leader_years, "ps_system") = "cow"
attr(dyadic_conflict_leader_years, "ps_conflict_type") = "gml"


saveRDS(dyadic_conflict_leader_years, "~/Dropbox/svmiller.github.io/R/peacesciencer/dyadic_conflict_leader_years.rds")

gml_mid_dirleaderdisps <- dyadic_conflict_leader_years

save(gml_mid_dirleaderdisps, file="data/gml_mid_dirleaderdisps.rda")



dyadic_conflict_leader_years <- readRDS("~/Dropbox/svmiller.github.io/R/peacesciencer/dyadic_conflict_leader_years.rds")

dyadic_conflict_leader_years %>%
  wc_onsets() %>%
  wc_fatality() %>%
  wc_hostility() %>%
    wc_duration() %>%
    wc_recip() %>%
  wc_stmon() -> gml_mid_ddlydisps

save(gml_mid_ddlydisps, file="data/gml_mid_ddlydisps.rda")
