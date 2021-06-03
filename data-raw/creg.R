library(tidyverse)

# Country identifiers (COW codes): The values used were based on those in Gleditsch and
# Ward’s list of independent states with two exceptions, post-USSR Russia and Post-
#   Yugoslavia Serbia. The changes in population data between the pre-breakup period and the
# post-breakup period were large enough that a separate country had to be created to make
# post-breakup estimations. The following COW codes were used:
#   Country Cowcode
# Years
# Serbia
# 340
# 1992-2013
# Russia
# 393
# 1991-2013
# USSR
# 365
# 1945-1991
# Yugoslavia
# 345
# 1945-1992
# The Gleditsch and Ward coding scheme for post-unification Germany and post-unification
# Yemen were used:
#   Country
# Federal Republic of Germany
# Yemen (Arab Republic of Yemen)
# Cowcode
# 265
# 678
# Years
# 1945-2013
# 1945-2013

tibble(group = c("A", "B","C", "D"),
       perc1 = .25,
       perc2 = c(.97, .01, .01, .01)) %>%
  summarize(frac = 1 - sum(perc1^2),
            pol = 1 - sum((((.5-perc2)/(.5))^2)*perc2))

eth <- read_csv("~/Dropbox/data/creg/EthnicGroupsLong_v1.02.csv") %>% rename_all(tolower) %>%
  rename(group_estimate = `group estimate`) %>%
  mutate(group_estimate = group_estimate/100)

rel <- read_csv("~/Dropbox/data/creg/ReligiousGroupsLong_v1.02.csv") %>% rename_all(tolower) %>%
  rename(group_estimate = `group estimate`) %>%
  mutate(group_estimate = group_estimate/100)


# Garcia-Montalvo and Reynal-Querol (2002) for pol
# Herfindahl-Hirschman concentration index for frac
# https://www.econstor.eu/bitstream/10419/92997/1/720108012.pdf
eth %>%
  group_by(country, cowcode, year) %>%
  summarize(ethfrac = 1 - (sum(group_estimate^2)),
            ethpol = 1 - sum((((.5-group_estimate)/(.5))^2)*group_estimate)) %>%
  ungroup() -> ethsum

rel %>%
  group_by(country, cowcode, year) %>%
  summarize(relfrac = 1 - (sum(group_estimate^2)),
            relpol = 1 - sum((((.5-group_estimate)/(.5))^2)*group_estimate)) %>%
  ungroup() -> relsum

full_join(ethsum, relsum) %>%
  rename(creg_ccode = cowcode) -> creg

creg %>%
  mutate(ccode = case_when(
    creg_ccode == 340 ~ 345,
    creg_ccode == 393 ~ 365,
    # pick a year, any year.
    # I'll go 1991 because Germany started the year as GFR
    # Same for Yemen
    creg_ccode == 260 & year >= 1991 ~ 255,
    creg_ccode == 678 & year >= 1991 ~ 679,
    TRUE ~ creg_ccode
  )) %>%
  # Okay, this is going to be an adjustment for Serbia/Russia and friends
  # In G-W: Yugoslavia goes to 2006, then it becomes Serbia.
  # In CREG: Yugoslavia goes until 1992, then it becomes Serbia
  mutate(gwcode = case_when(
    creg_ccode == 340 & year %in% c(1991, 2006) ~ 345,
    creg_ccode == 393 ~ 365,
    TRUE ~ creg_ccode
  )) %>%
  select(country, ccode, gwcode, everything()) -> creg


save(creg, file="data/creg.rda")
