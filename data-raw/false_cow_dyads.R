library(peacesciencer)
library(lubridate)
library(tidyverse)

state_days <- create_statedays()


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
  i = 1816:2016
) %dopar% {

  state_days %>%
    filter(year(date) == i) %>%
    expand(ccode1 = ccode, ccode2 = ccode, date = seq(make_date(i,01,01), make_date(i,12,31), by='1 day')) %>%
    filter(ccode1 != ccode2) %>%
    semi_join(., state_days, by=c("ccode1"="ccode", "date"="date")) %>%
    semi_join(., state_days, by=c("ccode2"="ccode", "date"="date")) %>%
    mutate(year = year(date)) %>%
    distinct(ccode1, ccode2, year) -> hold_this

}
toc()
parallel::stopCluster(cl = my.cluster)

allofthem %>%
  bind_rows(.) -> actualdata

actualdata %>% mutate(actual = 1) -> actualdata

cow_states %>%
  # Select just the stuff we need
  select(ccode, styear, endyear) %>%
  # Expand the data, create two ccodes as well
  expand(ccode1=ccode, ccode2=ccode, year=seq(1816,2016)) %>%
  # Filter out where ccode1 == ccode2
  filter(ccode1!=ccode2) %>%
  # When you're merging into dyad-year data, prepare to do it twice.
  # Basically: merge in data for ccode1
  left_join(., cow_states, by=c("ccode1"="ccode")) %>%
  # ...and filter out cases where the years don't align.
  filter(year >= styear & year <= endyear) %>%
  # Get rid of styear and endyear to do it again.
  select(-styear,-endyear) %>%
  # And do it again, this time for ccode2
  left_join(., cow_states, by=c("ccode2"="ccode")) %>%
  # Again, filter out cases where years don't align.
  filter(year >= styear & year <= endyear) %>%
  # And select just what we need.
  select(ccode1, ccode2, year) -> DDY

DDY %>% filter(year <= 2016) %>%
  mutate(in_ps = 1) %>%
  anti_join(., actualdata) -> false_cow_dyads

save(false_cow_dyads, file="data/false_cow_dyads.rda")
