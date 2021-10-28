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
  mutate(enddate = if_else(enddate == as_date("2017-12-31"), as_date("2020-12-31"), enddate)) %>%
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
  mutate(enddate = if_else(enddate == as_date("2016-12-31"), as_date("2020-12-31"), enddate)) %>%
  rowwise() %>%
  mutate(day = list(seq(stdate, enddate, by = '1 day'))) %>%
  unnest(day) %>%
  select(-stdate, -enddate) %>%
  mutate(cowday = 1) -> cowdays

gwdays %>% full_join(., cowdays) -> cow_gw_days

cow_gw_days %>% mutate(year = year(day)) %>%
  distinct(stateabb, year, gwcode, ccode, gw_statename, cow_statename) %>%
  group_by(gwcode, year) %>%
  mutate(ccode = ifelse(is.na(ccode) & n() > 1, max(ccode, na.rm=T), ccode)) %>%
  slice(1) %>% ungroup() -> gw_cow_years

# Let's take inventory of what is affected.
gw_cow_years %>% filter(is.na(ccode)) %>%
  group_by(gwcode) %>%
  summarize(min_year = min(year),
            max_year = max(year),
            n = n()) %>%
  data.frame

check_both <- function(x) {

  gw_states %>%
    mutate(data = "G-W") %>%
    filter(gwcode == x) -> gwrows

  cow_states %>%
    mutate(startdate = ymd(paste0(styear,"/",stmonth, "/", stday)),
           enddate = ymd(paste0(endyear,"/",endmonth,"/",endday))) %>%
    select(stateabb:statenme, startdate, enddate) %>%
    mutate(data = "CoW") %>%
    rename(statename = statenme) %>%
    filter(ccode == x) -> cowrows

  dat <- bind_rows(gwrows, cowrows) %>%
    select(gwcode, ccode, stateabb, everything())

  return(dat)
}

check_both(260)

# GW have Canada on the scene since 1867 and CoW do not. This makes sense.
# GW have a continuous Cuba since 1902. CoW had them drop out in 1907 and 1908. That checks out.
# GW have a Haiti from 1816 to 1915, and from 1934 to 2017. CoW have Haiti from 1859 to 1915 (1934 onward). This checks out.
# GW have Mexico since 1821. CoW has it from 1831. Checks out.
# CoW has no 89. That checks out.
# GW  has 27 years more of Guatemala. This checks out.
# GW has 59 years more of Honduras. This checks out.
# GW has those 35 years more of El Salvador. Checks out.
# GW has 60 years more of Nicaragua. Checks out.
# GW has 80(!) years more of Costa Rica. Checks out.
# GW has a Gran Colombia (99). I note in my comment above that the nature of the dates/actors involved mean we can let this stand alone.
# There is that one Colombia year, which we won't have to fix because CoW has Colombia emerging in 1831 and not 1830.
# Venezuela checks out. I think this is the benefit of doing them as days and not years.
# GW has those 24 more years of Ecuador. Checks out.
# GW has those 15 years of Peru. Checks out.
# GW has those extra years of Bolivia. Checks out.
# There is some weirdness in Paraguay (150) that we'll want to manually checks. GW has Paraguay since 1816 (CoW since 1846).
#   Beyond that: CoW has Paraguay in post-Lopez War timeout from 1870 to 1876. A quick math probably has this accurately reflected.
#   Let's check.
# gw_cow_years %>% filter(year <= 1877 & gwcode == 145) %>% data.frame
# ^ Yep. We don't care about the CoW state name, just the ccode. We got it.
# Argentina checks out.
# Ireland checks out
# The BENELUX occupations during World War II check out.
# Hanover (240) requires a careful inspection. GW has Hanover from 1816 to 1871 (uninterrupted). CoW: 1837 to 1866.
# gw_cow_years %>% filter(year <= 1872 & gwcode == 240) %>% data.frame
# ^ checks out
# Here is one we'll have to manually fix. CoW has a unified Germany going back to 255 again. GW interprets this differently.
# I happen to share the GW interpretation here. There is one other wrinkle here that GW start W Germany in 1949 whereas CoW
# start them in 1955. Here is what I'll do. Starting in 1991, where gwcode == 260, ccode == 255. Why not 1990 too? Justification:
# unification happened in October and W. Germany started the calendar year as just a W. Germany. Users can manually adjust this.
# E Germany checks out. GW start them in 1949 and CoW in 1954.
# Saxony (269) checks out. CoW ends it four years earlier.
# Same basically with Hesse Electoral and Grand Ducal
# Mecklenburg-Schwerin (280) needs a more thorough inspection, but probably checks out. (It does)
# CoW has that WW2 occupation where GW does not. Checks out.
# The two interestingly disagree on Austria. Both end Austria-Hungary at basically the same time, but CoW waits almost a year before
#   entering a new Austria (305) and doesn't re-enter Austria after WW2 until 1955. This will probably check out in the data, but let's verify
#   that it does.
# gw_cow_years %>% filter(gwcode == 305 & between(year, 1917, 1956)) %>% data.frame
# ^ checks out.
# Serbia is going to require some care. To reiterate: GW have Serbia as 340 before and Yugoslavia and Yugoslavia, for when it was
#  in the GW data, is 345. CoW's interpretation is one I tend to favor: Serbia was the center of Yugoslavia and is 345 in the data.
#  Compounding matters: Yugoslavia does not exist in the CoW data at all for 1942 and 1943 (exiting in 1941 and reappearing in 1944).
#  Further: Serbia disappears in the GW data from Oct. 1 1915 to Dec. 1, 1918 (when it reappears as Yugoslavia).
#  We're treating GW as the master system in this context. Let me eyeball how this is working here.
#  gw_cow_years %>% filter(gwcode %in% c(340, 345)) %>% data.frame %>% arrange(year)
#  ^ Honestly, I think this is fine. I hate how it looks, but that's because we're trying to integrate two different systems.

gw_cow_years %>%
  mutate(ccode = case_when(
    gwcode == 260 & year >= 1991 ~ 255,
    gwcode == 678 & between(year, 1926, 1989) ~ 678,
    TRUE ~ ccode
  )) -> gw_cow_years

# Riffing after the fact, forgetting what exactly I did here, but remembering now... ignore this all. It's already fixed.
# This is all the product of the full join.
# # Discovered this after the fact. We're going to have to do some ad hoc corrections for gwcode as well
#
# gw_cow_years %>%
#   filter(is.na(gwcode)) %>%
#   group_by(stateabb) %>%
#   summarize(ccode = max(ccode, na.rm=T),
#             n = n(), min = min(year), max = max(year))
#
# # ^ In this list:
# # Have to fix Bavaria and add that year. The NA happened because both disagree on the exact day.
# # Ignore Dominica. It's not in G-W
# # Ignore Egypt. Both CoW and G-W have conflict accounts for Egyptian statehood. CoW: 1855-1882, 1937-2016. G-W: 1827-1855, 1922-2017.
# # Fix Estonia to add 1940. The NA happened because both disagree by two weeks of June 1940.
# # Fix Greece to add 1828. The NA happened because both disagree by three months.
# # Ignore Grenada. It's not in G-W
# # Fix Haiti in 1915. The NA happened because both disagree by two weeks.
# # Fix Jordan in 1946. The NA happened because both disagree by a little over two months.
# # Fix Mali in 1960. Same basic reasons as above.
# # Fix Morocco, but just for 1904. That's when G-W has Morocco drop out.
# # Fix Norway in 1905.
# # Fix Poland in 1918.
# # Fix Saudi Arabia, but just for 1932.
# #
#
# gw_cow_years %>%
#   mutate(gwcode = case_when(
#     stateabb == "BAV" & year == 1871 ~ 245,
#
#     TRUE ~ gwcode
#   ))

save(gw_cow_years, file="data/gw_cow_years.rda")
