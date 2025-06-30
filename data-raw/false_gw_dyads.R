library(peacesciencer)
library(isard)
library(lubridate)
library(tidyverse)

# I last did this on Nov. 1, 2021. Doing it again on June 30, 2025 because
# G-W dates in {peacesciencer} now include the microstates and have the user
# decide what to do with them.

gw_system %>%
  rowwise() %>%
  mutate(date = list(seq(start, end, by = '1 day')))  %>%
  unnest(c(date)) %>%
  arrange(gwcode, date) %>%
  select(gwcode, gw_name, date) -> state_days



half_cores  <- parallel::detectCores()/2
library(foreach)
my.cluster <- parallel::makeCluster(
  half_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = half_cores)
foreach::getDoParRegistered()
library(tictoc)


tic()
allofthem <- foreach(
  i = 1816:2020
) %dopar% {

  state_days %>%
    filter(year(date) == i) %>%
    expand(gwcode1 = gwcode, gwcode2 = gwcode,
           date = seq(make_date(i,01,01), make_date(i,12,31),
                      by='1 day')) %>%
    filter(gwcode1 != gwcode2) %>%
    semi_join(., state_days, by=c("gwcode1"="gwcode", "date"="date")) %>%
    semi_join(., state_days, by=c("gwcode2"="gwcode", "date"="date")) %>%
    mutate(year = year(date)) %>%
    distinct(gwcode1, gwcode2, year) -> hold_this

}
toc() # 83.768

parallel::stopCluster(cl = my.cluster)

allofthem %>%
  bind_rows(.) -> actualdata

actualdata %>% mutate(actual = 1) -> actualdata

# gw_states %>%
#   mutate(styear = lubridate::year(.data$startdate),
#          endyear = lubridate::year(.data$enddate))  -> gw_states

gw_system %>%
  mutate(styear = year(start),
         endyear = year(end)) -> gw_system

gw_system %>%
  select(gwcode, styear, endyear, microstate) -> dddd

dddd %>%
  # Select just the stuff we need
  select(.data$gwcode, .data$styear, .data$endyear) %>%
  # Expand the data, create two ccodes as well
  expand(gwcode1=.data$gwcode,
         gwcode2=.data$gwcode,
         year=seq(1816, 2020)) %>%
  # Filter out where ccode1 == ccode2
  filter(.data$gwcode1 != .data$gwcode2) %>%
  left_join(., dddd, by=c("gwcode1"="gwcode")) %>%
  # ...and filter out cases where the years don't align.
  filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
  # Get rid of styear and endyear to do it again.
  select(-.data$styear,-.data$endyear) %>%
  rename(microstate1 = microstate) %>%
  # And do it again, this time for ccode2
  left_join(., dddd, by=c("gwcode2"="gwcode")) %>%
  # Again, filter out cases where years don't align.
  filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
  rename(microstate2 = microstate) %>%
  # And select just what we need.
  select(.data$gwcode1, .data$gwcode2, .data$year,
         microstate1, microstate2) -> DDY


DDY %>%
  filter(year <= 2020) %>%
  mutate(in_ps = 1) %>%
  anti_join(., actualdata) -> false_gw_dyads

# Yeah, we added a couple from the same dyad: RVN and Sao Tome and Principe

save(false_gw_dyads, file="data/false_gw_dyads.rda")
