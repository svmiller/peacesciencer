library(tidyverse)
library(countrycode)
library(lubridate)
library(peacesciencer)

# I'll have to do this manually. The dates are going to be weird, but I can fix that. I'll scan mostly for code discrepancies.
# GW don't have Dominica (54), Grenada (55), St. Lucia (56), SVG (57), A&B (58), and St. Kitts and Nevis (60)
# GW have the United Provinces of Central America as gwcode == 89. This was the union of Guatemala (90), Honduras (91),
#   El Salvador (92), Costa Rica (94), and Nicaragua (93). GW have this from July 1, 1823 to Dec. 31, 1839.
#   What's at stake: all those successor states have Jan. 1, 1840 starts in GW. Start dates in CoW are a little more scattered.
#   CoW has Guatemala at Jan. 1, 1868, Honduras at Jan. 1, 1899, El Salvador at Jan. 1, 1875, Nicaragua at Jan. 1, 1900,
#   Costa Rica at Jan. 1, 1920, and Nicaragua at Jan. 1, 1920. That's pretty remarkable to have such a wild discrepancy.

# Here's a biggie: GW have Gran Colombia (gwcode == 99) from Aug. 30, 1821 to Sept. 22, 1830. That encompassed Colombia (duh),
# Ecuador, Panama, Venezuela, and even parts of northern Peru and northwestern Brazil. For those successor states, GW have
# Venezuela as emerging on Jan. 1, 1829 (while still in GCL, which is weird), Ecuador on May 13, 1830, Peru (which was only
# partly in GCL) on Dec. 9, 1824, and, lest we forget, Colombia emerging on Sept. 23, 1830. The country codes are identical
# to CoW.

# GW don't have Monaco (221), Liechtenstein (223), Andorra (232), and San Marino (331).

# Of note: Germany dies 1945 in the GW data. GW interpret (reasonably, but unfortunately from a CoW data perspective) that
# unification amounts to a consolidation of East Germany (265) into West Germany (260).

# The big enchilada: Serbia. GW have Serbia as 340 before and after Yugoslavia. Yugoslavia, for when it existed, is 345.
# This stands at odds with the CoW interpretation (which I tend to favor): Yugoslavia had a Serbian center. Serbia preceded
# Yugoslavia and should be understood as both predecessor state, successor state, and the center of gravity (if you will) of
# Yugoslavia for when Yugoslavia was a thing.

# GW don't have Sao Tome and Principe (403) and Seychelles (591)
# CoW doesn't have Transvaal (563), Orange Free State (564)

# Another headache: GW treat YPR (680) as merging into YAR (678), the interpretation I also share. CoW treats the successor
# state as a new entity (ccode == 679).

# GW have Tibet (711). CoW does not.

# Another of the familiar headaches: GW has three Vietnams (815, during and preceding the French consolidation of the region),
# Vietnam proper (816), and RVN (1954-1975)


# Hmm... how about this. Let's, in particular, focus on the stateabbs. That's the closest to a perfect overlap between mutual
# observations. There are a few discrepancies though. Let's do this with a full_join(), but starting with the GW data (which
# seem to have the broadest scope, at least in terms of days). Where applicable, let's standardize to CoW.

gw_states %>%
  mutate(stateabb = case_when(
    stateabb == "HSD" ~ "HSG",
    # Justification for Serbia: the dates don't at all overlap, nor should they.
    stateabb == "SER" ~ "YUG",
    stateabb == "RUM" ~ "ROM",
    stateabb == "FJI" ~ "FIJ",
    TRUE ~ stateabb
  )) %>%
  rename(gw_statename = statename) %>%
  rowwise() %>%
  mutate(day = list(seq(startdate, enddate, by = '1 day'))) %>%
  unnest(day) %>%
  mutate(gwday = 1) %>%
  select(gwcode, stateabb, gw_statename, day, gwday) -> gwdays


cow_states %>%
  mutate(stdate = ymd(paste0(styear,"/",stmonth, "/", stday)),
         enddate = ymd(paste0(endyear,"/",endmonth,"/",endday))) %>%
  select(stateabb:statenme, stdate, enddate) %>%
  rename(cow_statename = statenme) %>%
  rowwise() %>%
  mutate(day = list(seq(stdate, enddate, by = '1 day'))) %>%
  unnest(day) %>%
  select(-stdate, -enddate) %>%
  mutate(cowday = 1) -> cowdays

gwdays %>% full_join(., cowdays) -> cow_gw_days

cow_gw_days %>% mutate(year = year(day)) %>% distinct(stateabb, year, gwcode, ccode, gw_statename, cow_statename) -> cow_gw_years

cow_gw_years %>% select(stateabb, year, gwcode, ccode, gw_statename, cow_statename) -> cow_gw_years

cow_gw_years %>% filter(!is.na(ccode)) %>% group_by(ccode,year) %>% filter(n() > 1) %>% arrange(ccode) %>% data.frame

# ^ There are still about 24 duplicate ccode-years. These are cases where the ccode appears twice but the gwcode just once.

# So, I think this is going to have to do. YOu can't group-by and slice/filter(max) because you'll omit cases where there's a gwcode
# but no ccode. I'm just going to leave this as is. I think there's workable stuff in here, no matter.

save(cow_gw_years, file="data/cow_gw_years.rda")


