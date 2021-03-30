# this looks like a simple data set. I'll probably just poke around a little bit, for funsies.

library(tidyverse)

ucdp_onsets <- read_csv("~/Dropbox/data/ucdpprio/onset/onsets_computed-19.1.csv") %>%
  select(-abc, -name) %>%
  select(gwno_a, year, everything()) %>%
  rename(gwcode = gwno_a) %>%
  print()

# Let me check for duplicates...

ucdp_onsets %>%
  group_by(gwcode, year) %>%
  mutate(n = n()) %>%
  filter(n > 1) %>% tail

# Hmm. What is even going on here?
# If I understand the codebook correctly, this should not happen. The data are offered as monadic, country-year data.
# However, the litany of duplicates here suggest the data are extra-counting the country-years with onset episodes.
# France in 1946 seems illustrative here. There are four France-1946 observations, which would square with onset episodes
# with Cambodia, Laos, Thailand, and Vietnam. Likewise, Panama in 1989 has two observations, one for the United States
# and another for the failed coup attempt led by Moisés Giroldi.

# So, under those conditions, I am going to create a new sum variable that gets the total of new onsets.
# I think, then, in the spirit of simplicity, I'm going to group_by(gwcode, year) and *add* those duplicates
# together. What this will do is communicate the sum of new onsets with those specified windows from the codebook.

# This might create some other weirdness with the year_prev variable. In a lot of these applications, its 1815, but
# that's almost beside the point. The problem is, in the case of having to truncate duplicate observations, the year_prev
# variable can't be informative. I suppose one way around this is to collapse it into a string. I'm tempted to just drop it.

ucdp_onsets %>%
  group_by(gwcode, year) %>%
  summarize(sumnewconf = sum(newconf),
            sumonset1 = sum(onset1),
            sumonset2 = sum(onset2),
            sumonset3 = sum(onset3),
            sumonset5 = sum(onset5),
            sumonset10 = sum(onset10)) %>%
  ungroup() -> ucdp_onsets


ucdp_onsets %>%
  group_by(gwcode, year) %>% filter(n() > 1)

# we're good

save(ucdp_onsets, file="data/ucdp_onsets.rda")


# throwing rocks at things now.

create_stateyears(system = "gw") %>%
  left_join(., ucdp_onsets) %>%
  mutate_at(vars("sumnewconf", "sumonset1", "sumonset2", "sumonset3", "sumonset5", "sumonset10"), ~ifelse(is.na(.), 0, .))
