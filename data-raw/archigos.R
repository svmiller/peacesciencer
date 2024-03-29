library(tidyverse)

# archigos <- haven::read_dta("~/Dropbox/data/archigos/Archigos_4.1_stata14.dta")

haven::read_dta("~/Dropbox/data/archigos/Archigos_4.1_stata14.dta") %>%
  select(obsid, ccode, leadid, leader, yrborn, gender, startdate, enddate, entry, exit, exitcode) %>%
  mutate(startdate = lubridate::ymd(startdate),
         enddate = lubridate::ymd(enddate),
         # Gonna hard-code the -999 yrborns to be NA
         # earliest birth is 1797 in these data anyway, so this is safe...
         yrborn = ifelse(yrborn < 1700, NA, yrborn)) %>%
  # renaming ccode to be gwcode, since these are Gleditsch-Ward states and not CoW states
  rename(gwcode = ccode) -> archigos

# Gonna futz with some character encoding problems here.
archigos %>%
  mutate_at(vars( "obsid", "leadid", "leader", "gender", "entry", "exit", "exitcode"),
            list(enc = ~stringi::stri_enc_isascii(.)))

#^ leader names...

archigos %>%
  mutate_at(vars( "obsid", "leadid", "leader", "gender", "entry", "exit", "exitcode"),
            list(enc = ~stringi::stri_enc_isascii(.))) %>% filter(leader_enc == FALSE) %>%
  distinct(obsid, gwcode, leader) -> rename_these

rename_these %>%
  mutate(leader_corrected = c("Hernandez", "Saca Gonzalez",
                              "Julian Trujillo Largacha",
                              "Cesar Gaviria Trujillo",
                              "Gabriel Garcia Moreno",
                              "Marcos A. Morinigo",
                              "Higinio Morinigo",
                              "Sebastian Pinera",
                              "Sauli Ninisto",
                              "Louis Gerhard De Geer",
                              "Stefan Lofven",
                              "Lars Lokke Rasmussen",
                              "Lars Lokke Rasmussen",
                              "Fernando de Araujo"),
         correctme = 1) %>%
  left_join(archigos, .) %>%
  mutate(correctme = ifelse(is.na(correctme), 0, correctme)) %>%
  mutate(leader = ifelse(correctme == 1, leader_corrected, leader)) %>%
  select(obsid:exitcode) -> archigos

archigos %>%
  mutate_at(vars( "obsid", "leadid", "leader", "gender", "entry", "exit", "exitcode"),
            list(enc = ~stringi::stri_enc_isascii(.))) %>% summary



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
