# http://svmiller.com/blog/2021/05/convert-cow-mid-data-to-dispute-year/

library(lubridate)
library(tidyverse) # for most things
library(sqldf)     # for some early-on SQL magic
library(kableExtra)

# This is how it works in my setup.
# MIDA: dispute-level. MIDB: participant-level

MIDB <- haven::read_dta("~/Dropbox/data/cow/mid/5/MIDB 5.0.dta")

MIDB %>%
  mutate(stdate = make_date(styear, stmon, ifelse(stday == -9, 1, stday)),
         enddate = make_date(endyear, endmon, 1),
         endday2 = ifelse(endday != -9, endday, day(ceiling_date(enddate, unit = "month")-1)),
         enddate = make_date(endyear, endmon, endday2)) %>%
  rowwise() %>%
  mutate(date = list(seq(stdate, enddate, by = "1 day"))) %>%
  unnest(date) %>%
  arrange(dispnum, date, ccode) %>%
  mutate(year = year(date),
         month = month(date),
         day = day(date)) -> longPart

sqldf("select A.dispnum dispnum, A.ccode ccode1, B.ccode ccode2,
      A.year year1, B.year year2, A.month month1, B.month month2, A.day day1, B.day day2,
      A.sidea sidea1, B.sidea sidea2,
             A.fatality fatality1, B.fatality fatality2,
             A.fatalpre fatalpre1, B.fatalpre fatalpre2,
             A.hiact hiact1, B.hiact hiact2, A.hostlev hostlev1, B.hostlev hostlev2,
             A.orig orig1, B.orig orig2
             from longPart A join longPart B using (dispnum)
             where A.ccode != B.ccode AND
             sidea1 != sidea2 AND year1 == year2 AND month1 == month2 AND day1 == day2
             order by A.ccode, B.ccode") %>% as_tibble() %>%
  # Some nip-and-tuck...
  rename(year = year1) %>%
  select(-year2, -month1:-day2) %>%
  group_by(dispnum, ccode1, ccode2, year, sidea1, sidea2) %>% slice(1) %>%
  arrange(dispnum) %>%
  ungroup() -> dDisp


dDisp %>%
  group_by(dispnum, ccode1, ccode2, year) %>%
  tally() %>% filter(n > 1)


dDisp %>%
  # Simple ongoing variable. This one is easy.
  mutate(dispongoing = 1) -> dDisp


dDisp %>%
  group_by(dispnum, ccode1, ccode2) %>%
  # Now, here are two ways for calculating onsets:
  # grouping by dispnum, ccode1, and ccode2, find the first observation
  # This should, btw, take care of those  cases where there was side-switching. Mostly in WW2, naturally.
  mutate(first = ifelse(row_number() == 1, 1, 0)) %>%
  # Now, for cases where states dropped out and dropped in again, let's do a quick solution here.
  # If the lag difference between years is > 1, it's a new onset.
  # Thus, midonset is any first observation or a case where the ydiff > 1.
  # This will help a little bit with MID#4273.
  mutate(ydiff = year - lag(year, 1),
         disponset = ifelse(first == 1 | ydiff > 1, 1, 0)) %>%
  select(dispnum:year,  dispongoing, disponset, everything(), -first, -ydiff) %>%
  ungroup() -> dDisp


dDisp %>%
  mutate(disponset = case_when(
    dispnum == 4095 & (ccode1 == 350 | ccode2 == 350) & year %in% c(1999, 2000) ~ 1,
    dispnum == 4137 & (ccode1 == 343 | ccode2 == 343) & year == 1999 ~ 1,
    dispnum == 4182 & (ccode1 == 652 | ccode2 == 652) & year %in% c(1994, 1995, 1996) ~ 1,
    dispnum == 4273 & (ccode1 == 690 | ccode2 == 690) & year == 2002 ~ 1,
    dispnum == 4676 & (ccode1 == 385 | ccode2 == 385) & year == 2012 ~ 1,
    # The Denmark example will be overkill, but there's no harm in doing this.
    dispnum == 4676 & (ccode1 == 390 | ccode2 == 390) & year == 2011 ~ 1,
    dispnum == 4678 & (ccode1 == 200 | ccode2 == 200) & year == 2014 ~ 1,
    dispnum == 4678 & (ccode1 == 366 | ccode2 == 366) & year == 2014 ~ 1,
    dispnum == 4678 & (ccode1 == 385 | ccode2 == 385) & year == 2014 ~ 1,
    dispnum == 4680 & (ccode1 == 732 | ccode2 == 732) & year == 2014 ~ 1,
    dispnum == 4691 & (ccode1 == 2 | ccode2 == 2) & year %in% c(2013, 2014) ~ 1,
    TRUE ~ disponset
  )) -> cow_mid_dirdisps

attr(cow_mid_dirdisps, "ps_data_type") = "dyad_year"
attr(cow_mid_dirdisps, "ps_system") = "cow"

save(cow_mid_dirdisps, file="data/cow_mid_dirdisps.rda")
