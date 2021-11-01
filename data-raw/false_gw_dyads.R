library(peacesciencer)
library(lubridate)
library(tidyverse)

state_days <- create_statedays(system = 'gw')


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
  i = 1816:2017
) %dopar% {

  state_days %>%
    filter(year(date) == i) %>%
    expand(gwcode1 = gwcode, gwcode2 = gwcode, date = seq(make_date(i,01,01), make_date(i,12,31), by='1 day')) %>%
    filter(gwcode1 != gwcode2) %>%
    semi_join(., state_days, by=c("gwcode1"="gwcode", "date"="date")) %>%
    semi_join(., state_days, by=c("gwcode2"="gwcode", "date"="date")) %>%
    mutate(year = year(date)) %>%
    distinct(gwcode1, gwcode2, year) -> hold_this

}
toc()

parallel::stopCluster(cl = my.cluster)

allofthem %>%
  bind_rows(.) -> actualdata

actualdata %>% mutate(actual = 1) -> actualdata

gw_states %>%
  mutate(styear = lubridate::year(.data$startdate),
         endyear = lubridate::year(.data$enddate))  -> gw_states

gw_states %>%
  # Select just the stuff we need
  select(.data$gwcode, .data$styear, .data$endyear) %>%
  # Expand the data, create two ccodes as well
  expand(gwcode1=.data$gwcode, gwcode2=.data$gwcode, year=seq(1816,2017)) %>%
  # Filter out where ccode1 == ccode2
  filter(.data$gwcode1 != .data$gwcode2) %>%
  left_join(., gw_states, by=c("gwcode1"="gwcode")) %>%
  # ...and filter out cases where the years don't align.
  filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
  # Get rid of styear and endyear to do it again.
  select(-.data$styear,-.data$endyear) %>%
  # And do it again, this time for ccode2
  left_join(., gw_states, by=c("gwcode2"="gwcode")) %>%
  # Again, filter out cases where years don't align.
  filter(.data$year >= .data$styear & .data$year <= .data$endyear) %>%
  # And select just what we need.
  select(.data$gwcode1, .data$gwcode2, .data$year) -> DDY


DDY %>% filter(year <= 2017) %>%
  mutate(in_ps = 1) %>%
  anti_join(., actualdata) -> false_gw_dyads


save(false_gw_dyads, file="data/false_gw_dyads.rda")
