library(tidyverse)
library(stevemisc)
library(peacesciencer)
library(lubridate)
library(tictoc)


# archigos %>%
#   rowwise() %>%
#   mutate(date = list(seq(startdate, enddate, by = "1 day"))) %>%
#   unnest(date) -> leader_days
#
# state_days <- create_statedays() %>% select(-statenme) %>% mutate(in_cow = 1)
#
# leader_days %>%
#   left_join(., state_days) %>%
#   mutate(in_cow = ifelse(is.na(in_cow), 0, in_cow)) -> leader_days

leader_days <- create_leaderdays(standardize_cow = FALSE)



nmin4_cores  <- parallel::detectCores()-4
library(foreach)
my.cluster <- parallel::makeCluster(
  nmin4_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = nmin4_cores)
foreach::getDoParRegistered()

tic()
dir_leader_dyad_years <- foreach(
  i = 1870:2015
) %dopar% {
  print(paste0("Starting year: ", i))
  start_date <- paste(i, "01", "01", sep="-")
  end_date <- paste(i, "12", "31", sep="-")

  leader_days %>%
    filter(year(date) == i) %>%
    select(ccode, obsid, startdate, enddate) %>%
    expand(obsid1 = obsid, obsid2 = obsid,
           date=seq(as.Date(start_date), as.Date(end_date), by="1 day")) %>%
    filter(obsid1 != obsid2) -> hold_this

  # scrub cases of intra-state dyads
  # these happen because of a leader change in the year.
  # mercifully, we can make this easy because iso3c-ish codes start every obsid
  hold_this %>% filter(str_sub(obsid1, 1, 3) != str_sub(obsid2, 1, 3)) -> hold_this


  hold_this %>%
    left_join(., archigos %>% select(obsid, startdate, enddate), by=c("obsid1"="obsid")) %>%
    rename(#gwcode1 = gwcode,
      startdate1 = startdate,
      enddate1 = enddate) %>%
    left_join(., archigos %>% select(obsid, startdate, enddate), by=c("obsid2"="obsid")) %>%
    rename(#gwcode2 = gwcode,
      startdate2 = startdate,
      enddate2 = enddate) -> hold_this

  hold_this %>%
    filter((date >= startdate1) & (date <= enddate1) &
             (date >= startdate2) & (date <= enddate2)) %>%
    select(-date) %>%
    # mutate(bothincow = ifelse(in_cow1 == 1 & in_cow2 == 1, 1, 0)) %>%
    # group_by(obsid1, obsid2) %>%
    # mutate(bothincow = max(bothincow)) %>%
    #
    # group_by(obsid1) %>%
    # mutate(in_cow1max = max(in_cow1)) %>%
    # filter()
    #select(-in_cow1, -in_cow2) %>%

    distinct() %>% #ungroup() %>%
    mutate(year = i) %>%
    select(year, everything()) -> hold_this

}
toc()
# 52.803 sec elapsed
parallel::stopCluster(cl = my.cluster)

dir_leader_dyad_years %>%
  bind_rows(.) -> dir_leader_dyad_years



# dir_leader_dyad_years <- as_tibble()
#
# tic()
# for (i in 1870:2015) {
#   print(paste0("Starting year: ", i))
#   start_date <- paste(i, "01", "01", sep="-")
#   end_date <- paste(i, "12", "31", sep="-")
#
#   leader_days %>%
#     filter(year(date) == i) %>%
#     select(gwcode, obsid, startdate, enddate) %>%
#     expand(obsid1 = obsid, obsid2 = obsid,
#            date=seq(as.Date(start_date), as.Date(end_date), by="1 day")) %>%
#     filter(obsid1 != obsid2) -> hold_this
#
#   hold_this %>%
#     left_join(., archigos %>% select(gwcode, obsid, startdate, enddate), by=c("obsid1"="obsid")) %>%
#     rename(gwcode1 = gwcode,
#            startdate1 = startdate,
#            enddate1 = enddate) %>%
#     left_join(., archigos %>% select(gwcode, obsid, startdate, enddate), by=c("obsid2"="obsid")) %>%
#     rename(gwcode2 = gwcode,
#            startdate2 = startdate,
#            enddate2 = enddate) -> hold_this
#
#   hold_this %>%
#     filter((date >= startdate1) & (date <= enddate1) &
#              (date >= startdate2) & (date <= enddate2)) %>%
#     select(-date) %>%
#     # mutate(bothincow = ifelse(in_cow1 == 1 & in_cow2 == 1, 1, 0)) %>%
#     # group_by(obsid1, obsid2) %>%
#     # mutate(bothincow = max(bothincow)) %>%
#     #
#     # group_by(obsid1) %>%
#     # mutate(in_cow1max = max(in_cow1)) %>%
#     # filter()
#     #select(-in_cow1, -in_cow2) %>%
#
#     distinct() %>% #ungroup() %>%
#     mutate(year = i) %>%
#     select(year, everything()) -> hold_this
#
#   dir_leader_dyad_years <- bind_rows(dir_leader_dyad_years, hold_this)
# }
# toc()
# 488.09 sec elapsed

# Add in some gwcodes now

dir_leader_dyad_years %>%
  left_join(., leader_days %>% select(obsid, gwcode) %>% rename(obsid1 = obsid) %>% distinct()) %>%
  rename(gwcode1 = gwcode) %>%
  left_join(., leader_days %>% select(obsid, gwcode) %>% rename(obsid2 = obsid) %>% distinct()) %>%
  rename(gwcode2 = gwcode) -> dir_leader_dyad_years

dir_leader_dyad_years %>%
  arrange(year, gwcode1, startdate1, gwcode2, startdate2) -> dir_leader_dyad_years

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

gw_dir_leader_dyad_years <- dir_leader_dyad_years

saveRDS(gw_dir_leader_dyad_years, "~/Dropbox/svmiller.github.io/R/peacesciencer/gw_dir_leader_dyad_years.rds")