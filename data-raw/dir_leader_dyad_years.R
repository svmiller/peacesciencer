library(tidyverse)
library(stevemisc)
library(peacesciencer)
library(lubridate)

archigos %>%
  rowwise() %>%
  mutate(date = list(seq(startdate, enddate, by = "1 day"))) %>%
  unnest(date) -> leader_days


dir_leader_dyad_years <- as_tibble()

for (i in 1870:2015) {
  start_date <- paste(i, "01", "01", sep="-")
  end_date <- paste(i, "12", "31", sep="-")

  leader_days %>%
    filter(year(date) == i) %>%
    select(ccode, leadid, startdate, enddate) %>%
    expand(leadid1 = leadid, leadid2 = leadid,
           date=seq(as.Date(start_date), as.Date(end_date), by="1 day")) %>%
    filter(leadid1 != leadid2) -> hold_this

  hold_this %>%
    left_join(., archigos %>% select(ccode, leadid, startdate, enddate), by=c("leadid1"="leadid")) %>%
    rename(ccode1 = ccode,
           startdate1 = startdate,
           enddate1 = enddate) %>%
    left_join(., archigos %>% select(ccode, leadid, startdate, enddate), by=c("leadid2"="leadid")) %>%
    rename(ccode2 = ccode,
           startdate2 = startdate,
           enddate2 = enddate) -> hold_this

  hold_this %>%
    filter((date >= startdate1) & (date <= enddate1) &
             (date >= startdate2) & (date <= enddate2)) %>%
    select(-date) %>% distinct() %>%
    mutate(year = i) %>%
    select(year, everything()) -> hold_this

  dir_leader_dyad_years <- bind_rows(dir_leader_dyad_years, hold_this)
}

saveRDS(dir_leader_dyad_years, "~/Dropbox/svmiller.github.io/R/peacesciencer/dir_leader_dyad_years.rds")
