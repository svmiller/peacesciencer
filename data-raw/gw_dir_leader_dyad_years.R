library(tidyverse)
library(stevemisc)
library(peacesciencer)
library(lubridate)
library(tictoc)

# Create Gleditsch-Ward-standardized leader-days ----
leader_days <- create_leaderdays(standardize = "gw")

## * Add in some other information ----
archigos %>%
  select(obsid, startdate, enddate) %>%
  left_join(leader_days, .) -> leader_days

# Prepare parallel stuff ----
my_cores  <- parallel::detectCores()/2
library(foreach)
my_cluster <- parallel::makeCluster(
  my_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = my_cores)
foreach::getDoParRegistered()

tic()

# Do the parallel stuff -----
dir_leader_dyad_years_list <- foreach(
  # for each year from 1870 to 2015
  i = 1870:2015
) %dopar% {
  # Grab year-specific start and end dates
  start_date <- paste(i, "01", "01", sep="-")
  end_date <- paste(i, "12", "31", sep="-")

  # Take leader-days and...
  leader_days %>%
    # Grab leaders active in the particular year we want
    filter(year(date) == i) %>%
    # Select just what we need for expansion
    select(obsid, startdate, enddate) %>%
    # Expand for every possible value of obsid1 and obsid2 for every day of the particular year
    expand(obsid1 = obsid, obsid2 = obsid,
           date=seq(as.Date(start_date), as.Date(end_date), by="1 day")) %>%
    # Filter out leader-dyads where leaders are identical
    filter(obsid1 != obsid2) %>%
    # Filter out where leaders are in the same state
    filter(str_sub(obsid1, 1, 3) != str_sub(obsid2, 1, 3)) -> hold_this

  # Now, merge in information we want
  leader_days %>%
    # Take the leader-day information on hand, make applicable to obsid1
    rename_at(vars(-date), ~paste0(.,"1")) %>%
    # Merge in
    left_join(hold_this, .) %>%
    # Do it again for leader-day information and make it applicable to obsid2
    left_join(., leader_days %>% rename_at(vars(-date), ~paste0(.,"2"))) -> hold_this

  # Finally, for this object we created.
  hold_this %>%
    # filter out missing gwcodes, which will coincide with leaders who took office some point *in* the year
    # For example, leader_days has Canal take over in Haiti on April 23, 1876.
    # The expansion a few clicks above created Jan. 1-April 22 days for him, but he'll have no corresponding
    # information in the leader_days data. This is a quick way of getting those out of here.
    filter(!is.na(gwcode1) & !is.na(gwcode2)) %>%
    # filter out dates that don't coincide with the leader tenure
    # Btw, the above *should* have done this as well and this step is unnecessary
    # However, I'd rather be safe than sorry.
    filter((date >= startdate1) & (date <= enddate1) &
             (date >= startdate2) & (date <= enddate2)) %>%
    # Select out the date variable, I know, I know... but...
    select(-date) %>%
    # The distinct variable is away of whittling these daily information to just one, indicating a year.
    distinct() %>%
    # Make a year variable, given i.
    mutate(year = i) %>%
    # order things nicely
    select(year, everything()) -> hold_this

}
toc()
parallel::stopCluster(cl = my_cluster)

dir_leader_dyad_years_list %>%
  bind_rows(.) -> dir_leader_dyad_years


# Stuff I want to add here:
# leader age, gender

archigos %>%
  select(obsid, yrborn, gender) %>%
  rename_all(~paste0(.,"1")) %>%
  left_join(dir_leader_dyad_years, .) -> dir_leader_dyad_years

archigos %>%
  select(obsid, yrborn, gender) %>%
  rename_all(~paste0(.,"2")) %>%
  left_join(dir_leader_dyad_years, .) -> dir_leader_dyad_years

dir_leader_dyad_years %>%
  mutate(leaderage1 = year - yrborn1,
         leaderage2 = year - yrborn2) -> dir_leader_dyad_years

dir_leader_dyad_years %>%
  select(year, obsid1, obsid2, gwcode1, gwcode2, gender1, gender2, leaderage1, leaderage2, yrinoffice1, yrinoffice2) -> dir_leader_dyad_years


gw_dir_leader_dyad_years <- dir_leader_dyad_years

saveRDS(gw_dir_leader_dyad_years, "~/Dropbox/svmiller.github.io/R/peacesciencer/gw_dir_leader_dyad_years.rds")
