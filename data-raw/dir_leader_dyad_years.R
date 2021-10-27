library(tidyverse)
library(stevemisc)
library(peacesciencer)
library(lubridate)
library(tictoc)


archigos %>%
  rowwise() %>%
  mutate(date = list(seq(startdate, enddate, by = "1 day"))) %>%
  unnest(date) -> leader_days

state_days <- create_statedays() %>% select(-statenme) %>% mutate(in_cow = 1)

leader_days %>%
  left_join(., state_days) %>%
  mutate(in_cow = ifelse(is.na(in_cow), 0, in_cow)) -> leader_days


dir_leader_dyad_years <- as_tibble()

tic()
for (i in 1870:2015) {
  print(paste0("Starting year: ", i))
  start_date <- paste(i, "01", "01", sep="-")
  end_date <- paste(i, "12", "31", sep="-")

  leader_days %>%
    filter(year(date) == i) %>%
    select(ccode, obsid, startdate, enddate) %>%
    expand(obsid1 = obsid, obsid2 = obsid,
           date=seq(as.Date(start_date), as.Date(end_date), by="1 day")) %>%
    filter(obsid1 != obsid2) -> hold_this

  hold_this %>%
    left_join(., leader_days %>% select(obsid, date, in_cow) %>% rename(obsid1 = obsid)) %>%
    rename(in_cow1 = in_cow) %>%
    left_join(., leader_days %>% select(obsid, date, in_cow) %>% rename(obsid2 = obsid)) %>%
    rename(in_cow2 = in_cow) -> hold_this

  hold_this %>%
    left_join(., archigos %>% select(ccode, obsid, startdate, enddate), by=c("obsid1"="obsid")) %>%
    rename(ccode1 = ccode,
           startdate1 = startdate,
           enddate1 = enddate) %>%
    left_join(., archigos %>% select(ccode, obsid, startdate, enddate), by=c("obsid2"="obsid")) %>%
    rename(ccode2 = ccode,
           startdate2 = startdate,
           enddate2 = enddate) -> hold_this

  hold_this %>%
    filter((date >= startdate1) & (date <= enddate1) &
             (date >= startdate2) & (date <= enddate2)) %>%
    select(-date) %>%
    mutate(bothincow = ifelse(in_cow1 == 1 & in_cow2 == 1, 1, 0)) %>%
    group_by(obsid1, obsid2) %>%
    mutate(bothincow = max(bothincow)) %>%
    #
    # group_by(obsid1) %>%
    # mutate(in_cow1max = max(in_cow1)) %>%
    # filter()
    select(-in_cow1, -in_cow2) %>%

    distinct() %>% ungroup() %>%
    mutate(year = i) %>%
    select(year, everything()) -> hold_this

  dir_leader_dyad_years <- bind_rows(dir_leader_dyad_years, hold_this)
}
toc()
# 556.816 sec elapsed
# Now: 1369.204 sec elapsed. Woof.

dir_leader_dyad_years %>%
  arrange(year, ccode1, startdate1, ccode2, startdate2) -> dir_leader_dyad_years

dir_leader_dyad_years %>%
  left_join(., archigos %>% select(obsid, yrborn, gender) %>% rename(obsid1 = obsid)) %>%
  rename(gender1 = gender, yrborn1 = yrborn) %>%
  left_join(., archigos %>% select(obsid, yrborn, gender) %>% rename(obsid2 = obsid)) %>%
  rename(gender2 = gender, yrborn2 = yrborn) -> dir_leader_dyad_years

dir_leader_dyad_years %>%
  mutate(leaderage1 = year - yrborn1,
         leaderage2 = year - yrborn2) %>%
  select(-yrborn1, -yrborn2) -> dir_leader_dyad_years

leaderyears <- create_leaderyears(standardize_cow = FALSE)

dir_leader_dyad_years %>%
  left_join(., leaderyears %>% select(obsid, year, yrinoffice) %>% rename(obsid1 = obsid)) %>%
  rename(yrinoffice1 = yrinoffice) %>%
  left_join(., leaderyears %>% select(obsid, year, yrinoffice) %>% rename(obsid2 = obsid)) %>%
  rename(yrinoffice2 = yrinoffice) %>%
  select(-startdate1:-enddate1, -startdate2, -enddate2) -> dir_leader_dyad_years

saveRDS(dir_leader_dyad_years, "~/Dropbox/svmiller.github.io/R/peacesciencer/dir_leader_dyad_years.rds")
