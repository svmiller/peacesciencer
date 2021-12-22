# Load libraries we want -----

library(tidyverse)
library(peacesciencer)
library(tictoc)
library(foreach)

# Load data we want -----

Alliances <-  read_csv("~/Dropbox/data/cow/alliance/4.1/alliance_v4.1_by_dyad_yearly.csv") %>%
  # Some post-processing of the alliance data
  # First, select just what we want
  select(ccode1, ccode2, year, defense:entente) %>%
  # Create a "commitment" variable
  mutate(commitment = case_when(
  defense == 1 ~ 3,
  defense == 0 & (neutrality == 1 | nonaggression == 1) ~ 2,
  defense == 0 & neutrality == 0 & nonaggression == 0 & entente == 1 ~ 1)) %>%
  # Post-process for some duplicate alliance years
  group_by(ccode1, ccode2, year) %>%
  # Select on highest commitment observed
  filter(commitment == max(commitment)) %>%
  # Where duplicates remain, just grab one.
  slice(1) %>%
  # practice safe group-by
  ungroup()

# "Direct" the alliance data....

Alliances %>%
  rename(ccode1 = ccode2,
         ccode2 = ccode1) %>%
  bind_rows(Alliances, .) -> Alliances

DDY <- create_dyadyears()

# Prepare our cores for work ----

nmin4_cores  <- parallel::detectCores()-4
library(foreach)
my.cluster <- parallel::makeCluster(
  nmin4_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = nmin4_cores)
foreach::getDoParRegistered()


# Draw the f*cking owl ----

tic()
tau_b <- foreach(
  i = 1816:2012
) %dopar% {
  Alliances %>% filter(year == i) -> ally_year

  DDY %>% filter(year == i) -> ddy_year

  ddy_year %>%
    expand(ccode1=ccode1, ccode2=ccode2, year = i) %>%
    filter(ccode1 == ccode2) %>%
    bind_rows(ddy_year, .) %>%
    arrange(ccode1, ccode2) -> ddy_year

  ddy_year %>%
    left_join(., ally_year %>% select(ccode1, ccode2, year, commitment)) %>%
    mutate(commitment = case_when(
      is.na(commitment) & ccode1 == ccode2 ~ 3,
      is.na(commitment) & ccode1 != ccode2 ~ 0,
      TRUE ~ commitment
    )) -> hold_this

  hold_this %>%
    select(-year) %>%
    spread(ccode2, commitment) -> hold_this

  hold_this %>% as.matrix() %>% cor(method="kendall") %>%
    as_tibble() %>% select(-ccode1) %>% slice(-1) %>%
    bind_cols(ddy_year %>% distinct(ccode1), .) %>%
    gather(ccode2, taub, -ccode1) %>%
    mutate(year = i) -> hold_this

}
parallel::stopCluster(cl = my.cluster)
toc()

tau_b %>%
  bind_rows(.) %>%
  select(ccode1, ccode2, year, taub) %>%
  filter(ccode1 != ccode2) -> Data


# read_csv("~/Dropbox/data/cow/alliance/4.1/alliance_v4.1_by_dyad_yearly.csv") %>%
#   filter(year == 1816) %>%
#   select(ccode1, ccode2, year, defense:entente) -> ally1816
#
#
# ally1816 %>%
#   rename(ccode1 = ccode2,
#          ccode2 = ccode1) %>%
#   bind_rows(ally1816, .) -> ally1816
#
#
# create_dyadyears() %>%
#   filter(year == 1816) -> ddy1816
#
# ddy1816
#
# ddy1816 %>%
#   expand(ccode1=ccode1, ccode2=ccode2, year = year) %>%
#   filter(ccode1 == ccode2) %>%
#   bind_rows(ddy1816, .) %>%
#   arrange(ccode1, ccode2) -> ddy1816
#
# ddy1816
#
# ally1816 %>%
#   mutate(commitment = case_when(
#     defense == 1 ~ 3,
#     defense == 0 & (neutrality == 1 | nonaggression == 1) ~ 2,
#     defense == 0 & neutrality == 0 & nonaggression == 0 & entente == 1 ~ 1,
#   )) %>%
#   group_by(ccode1, ccode2) %>%
#   filter(commitment == max(commitment)) %>%
#   slice(1) -> ally1816
#
# ddy1816 %>%
#   left_join(., ally1816 %>% select(ccode1, ccode2, year, commitment)) %>%
#   mutate(commitment = case_when(
#     is.na(commitment) & ccode1 == ccode2 ~ 3,
#     is.na(commitment) & ccode1 != ccode2 ~ 0,
#     TRUE ~ commitment
#   )) -> example
#
#
# example %>%
#   select(-year) %>%
#   spread(ccode2, commitment) -> example
#
#
# example %>% as.matrix() %>% cor(method="kendall") %>%
#   as_tibble() %>% select(-ccode1) %>% slice(-1) %>%
#   bind_cols(ddy1816 %>% distinct(ccode1), .) %>%
#   gather(ccode2, taub, -ccode1)
