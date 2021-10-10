library(tidyverse)

archigos <- haven::read_dta("/home/steve/Dropbox/data/archigos/Archigos_4.1_stata14.dta")

archigos %>%
  select(ccode, leadid, leader, gender, startdate, enddate, entry, exit, exitcode) %>%
  mutate(startdate = lubridate::ymd(startdate),
         enddate = lubridate::ymd(enddate)) -> archigos

save(archigos, file="data/archigos.rda")


# Proof of concept for state-year
# Remember: nominal left bound for the temporal domain is 1870. Leaders day of Jan. 1, 1870 have their start date/dates recorded.
# Thinking to myself here in light of conversation with Jeff.
# For state-year, we want:
# - was there a leader transition in the year?
# - number of leaders in the year, possibly? Couldn't be too hard
# - was there an irregular leader exit?
# - leader ID on Jan. 1 of the year
# - leader ID on Dec. 31 of the year

archigos %>%
  rowwise() %>%
  mutate(date = list(seq(startdate, enddate, by="1 day"))) %>%
  unnest(date) %>%
  mutate(year = year(date)) %>%
  filter(ccode == 2 | ccode == 20) %>%
  filter(year >= 1870) %>%
  arrange(date) -> example


example %>%
  group_by(ccode, year) %>%
  mutate(jan1leadid = first(leadid),
         dec31leadid = last(leadid),
         leadertransition = ifelse(jan1leadid != dec31leadid, 1, 0),
         n_leaders = n_distinct(leadid),
         irregular = ifelse(leadertransition == 1 & any(exit == "Irregular"), 1, 0),
         ) -> example

example %>%
  group_by(ccode, year) %>%
  select(ccode, year, leadertransition, irregular, n_leaders, jan1leadid, dec31leadid) %>%
  group_by(ccode, year) %>%
  slice(1)


# ^ cool cool. I think that'll do it.
