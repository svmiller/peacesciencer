library(tidyverse)
library(peacesciencer)
library(lubridate)

archigos %>%
  rowwise() %>%
  mutate(date = list(seq(.data$startdate, .data$enddate, by="1 day"))) %>%
  unnest(.data$date) %>%
  select(ccode, obsid, date, everything()) -> leaderdays

Part <- read_csv("~/Dropbox/projects/mid-project/gml-mid-data/2.2.1/gml-midb-2.2.1.csv") %>%
  mutate(stdate = make_date(styear, stmon, stday),
         enddate = make_date(endyear, endmon, endday)) %>%
  # First, a few error correction that will be fixed in MIC 1.0
  # For MID#1272, the start date for Poland (290) and Lithuania (368) is Nov. 13, 1918
  mutate(stday = ifelse(dispnum == 1272 & ccode %in% c(290, 368), 13, stday),
         stmon = ifelse(dispnum == 1272 & ccode %in% c(290, 368), 11, stmon)) %>%
  # Second, forgot to adjust the start dates for the war declaration on Japan in MID#3514
  mutate(stday = ifelse(dispnum == 3514 & ccode %in% c(740, 93), 8, stday))

# LEADERS AT ONSET AND CONCLUSION ----

# Let's start with start dates, known days ----
Part %>%
  filter(!is.na(stdate)) %>%
  select(dispnum, ccode, stdate) %>%
  mutate(in_part = 1) -> known_stdates


known_stdates %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>% mutate(in_archigos = 1),
            by=c("ccode"="ccode","stdate"="date")) -> known_stdates

# shit duplicated, what duplicated...
known_stdates %>%
  group_by(dispnum, ccode, stdate) %>%
  tally() %>%
  filter(n > 1)
#   dispnum ccode stdate         n
#      <dbl> <dbl> <date>     <int>
# 1     125   645 1958-07-14     2
# 2     258   385 1940-04-09     2
# 3    1530    41 1888-10-16     2
# 4    2079   155 1958-11-03     2
# 5    2331   645 1958-07-14     2
# 6    3133   630 1909-07-16     2
# 7    3179   200 1976-04-05     2
# 8    4293   694 1995-06-27     2

leaderdays %>% filter(ccode == 645 & date == "1958-07-14") %>% data.frame
leaderdays %>% filter(ccode == 385 & date == "1940-04-09") %>% data.frame
leaderdays %>% filter(ccode == 41 & date == "1888-10-16") %>% data.frame

# ^ eye-balling this, seems like we captured places where the participant's entry into the dispute coincided with
# a leader change on the same day... for one reason or the other. Fun! I'm going to have to read some dispute histories
# here. Thank you based GML project.

# MID#0125, Iraq: brought on because of the overthrow of the monarchy. Drop obsid IRQ-1953 here.
# MID#0258, Norway: easy call here. German invasion eventually installs Vidkun Quisling as new prime minister. Drop obsid NOR-1940 here.
# MID#1530, Haiti: Legitime is the Haitian leader here. Drop obsid HAI-1888-1 here.
# MID#2079, Chile: Moraga (1969) says Rodriguez is the leader here. Drop obsid CHL-1952 here.
# MID#2331, Iraq: related to MID#0125, brought on by the regime change. Drop obsid IRQ-1953 here.
# MID#3133, Iran: shah deposed, drop obsid IRN-1907.
# MID#3179, UKG: no way of knowing for sure, but everything about the change seems to imply Wilson here. drop obsid UKG-1976
# ^ rationale: https://twitter.com/MatthewWallack/status/1450148055949455365
# MID#4293, Qatar: brought on by the bloodless coup. Drop obsid QAT-1972 here.

known_stdates %>%
  filter(!(dispnum == 125 & obsid == "IRQ-1953")) %>%
  filter(!(dispnum == 258 & obsid == "NOR-1940")) %>%
  filter(!(dispnum == 1530 & obsid == "HAI-1888-1")) %>%
  filter(!(dispnum == 2079 & obsid == "CHL-1952")) %>%
  filter(!(dispnum == 2331 & obsid == "IRQ-1953")) %>%
  filter(!(dispnum == 3133 & obsid == "IRN-1907")) %>%
  filter(!(dispnum == 3179 & obsid == "UKG-1976")) %>%
  filter(!(dispnum == 4293 & obsid == "QAT-1972")) -> known_stdates

known_stdates %>%
  group_by(dispnum, ccode, stdate) %>%
  tally() %>%
  filter(n > 1)
# ^ dope...



# Next up: end dates, known days -----
Part %>%
  filter(!is.na(enddate)) %>%
  select(dispnum, ccode, enddate) %>%
  mutate(in_part = 1) -> known_enddates


known_enddates %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>%
              mutate(in_archigos = 1), by=c("ccode"="ccode","enddate"="date")) -> known_enddates

# Shit, even more stuff duplicated...
known_enddates %>%
  group_by(dispnum, ccode, enddate) %>%
  tally() %>%
  filter(n > 1) -> dups

dups
#   dispnum ccode enddate        n
#      <dbl> <dbl> <date>     <int>
# 1     257   211 1918-11-11     2
# 2     258   360 1944-08-23     2
# 3    1350   812 1960-01-07     2
# 4    1435   811 1979-01-07     2
# 5    1750   640 1876-05-30     2
# 6    2341   100 1898-08-07     2
# 7    2649   710 1917-08-14     2
# 8    3020     2 1981-01-20     2
# 9    3179   200 1976-04-05     2
# 10    3564   640 1993-05-16     2
# 11    3568     2 1993-01-20     2
# 12    3705   385 1940-04-09     2
# 13    4162   570 1994-09-14     2
# 14    4246   484 1997-10-15     2
dups %>%
  left_join(., leaderdays, by =c("ccode"="ccode", "enddate"="date")) %>%
  select(dispnum:enddate, obsid, leader, entry:exitcode) %>%
  data.frame

# MID#0257, Belgium: date of Belgian liberation. Von Falkenhausen was German governor, so he's the leader. Drop obsid BEL-1918-1.
# MID#0258, Romania: yeah no kidding Antonescu is leader here. Drop obsid RUM-1944
# MID#1350, Laos: Laos was a mess in 1960, but nominally Nosavan is leader here for dispute end. Drop LAO-1960-1.
# MID#1435, Cambodia: Pol Pot is leader here until Vietnam said he wasn't, naturally. Drop CAM-1979.
# MID#1750, Turkey: my reading of our incident coding suggests Abdul Aziz was leader for last incident. Drop TUR-1876-1.
# MID#2341, Colombia: Cerruti Affair! I coded this in grad school. Caro negotiated this agreement. Drop COL-1898
# MID#2649, China: this is a war-joiner MID, so it's going to be an odd one. I interpret it as Feng Kuo-chang. Drop CHN-1916.
# MID#3020, USA: looool, definitely Reagan ending this. Drop USA-1977.
# MID#3179, UKG: no way of knowing for sure, but everything about the change seems to imply Wilson here. drop obsid UKG-1976
# MID#3564, Turkey: not super clear based on wire reports, but likely Demirel. Drop TUR-1993-1.
# MID#3568, USA: Hussein retreated as a goodwill gesture to Clinton, so Clinton ends this dispute. Drop obsid USA-1989 here.
# MID#3705, Norway: related to MID#0258 entry. Because this "joins" WW2, Nygaardsvold should be head of state here. Drop obsid NOR-1940.
# ^ sidebar here: I think Archigos is wrong about Quisling's entry date This is the date of the coup attempt, and less his assuming
#                 power. I don't interpret the German occupation as complete until June 1940, not April.
# MID#4162, Lesotho: Letsie III signed the agreement in which he abdicated the throne. Drop obsid LES-1994-2 here.
# MID#4246, Congo: I interpret this as ending with Nguesso restored in power. So, drop Lissouba (obsid CON-1992) here.

known_enddates %>%
  filter(!(dispnum == 257 & obsid == "BEL-1918-1")) %>%
  filter(!(dispnum == 258 & obsid == "RUM-1944")) %>%
  filter(!(dispnum == 1350 & obsid == "LAO-1960-1")) %>%
  filter(!(dispnum == 1435 & obsid == "CAM-1979")) %>%
  filter(!(dispnum == 1750 & obsid == "TUR-1876-1")) %>%
  filter(!(dispnum == 2341 & obsid == "COL-1898")) %>%
  filter(!(dispnum == 2649 & obsid == "CHN-1916")) %>%
  filter(!(dispnum == 3020 & obsid == "USA-1977")) %>%
  filter(!(dispnum == 3179 & obsid == "UKG-1976")) %>%
  filter(!(dispnum == 3564 & obsid == "TUR-1993-1")) %>%
  filter(!(dispnum == 3568 & obsid == "USA-1989")) %>%
  filter(!(dispnum == 3705 & obsid == "NOR-1940")) %>%
  filter(!(dispnum == 4162 & obsid == "LES-1994-2")) %>%
  filter(!(dispnum == 4246 & obsid == "CON-1992")) -> known_enddates

known_enddates %>%
  group_by(dispnum, ccode, enddate) %>%
  tally() %>%
  filter(n > 1)
# ^ dope...



# Now: start dates, unknown days. ----
## * A Comment on Unknown Dates: -----
# These are going to seem like a huge data problem, but they're likely not. Most cases are going to have the same leader
#   on the first of the month as they would on the 31st of the month (or 28th, 29th, or 30th). The trick is finding which ones
#   need further evaluation.

# Here's a free function, if you want an idea of what I have to do with our corrections to the CoW-MID data.
# This will identify the end of the month in case of missing days.

eom <- function(date) {
  # date character string containing POSIXct date
  date.lt <- as.POSIXlt(date) # add a month, then subtract a day:
  mon <- date.lt$mon + 2
  year <- date.lt$year
  year <- year + as.integer(mon==13) # if month was December add a year
  mon[mon==13] <- 1
  iso = ISOdate(1900+year, mon, 1, hour=0, tz=attr(date,"tz"))
  result = as.POSIXct(iso) - 86400 # subtract one day
  result + (as.POSIXlt(iso)$isdst - as.POSIXlt(result)$isdst)*3600
}

# Now watch this....

Part %>%
  mutate(stday2 = 1,
         stdate2 = make_date(styear, stmon, stday2)) %>%
  filter(stday == -9) %>%
  mutate(stdate3 = as.Date(eom(make_datetime(styear, stmon)))) %>%
  select(dispnum, ccode, styear, stmon, stdate2, stdate3) -> unknown_stdates

unknown_stdates %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>%
              mutate(in_archigos = 1), by=c("ccode"="ccode","stdate2"="date")) -> unknown_stdates

# Shit, something duplicated again... what on earth could've duplicated...
unknown_stdates %>%
  group_by(dispnum, ccode, stdate2) %>%
  tally() %>%
  filter(n > 1)

archigos %>% filter(obsid %in% c("HON-1919", "HON-1920"))
Part %>% filter(dispnum == 2040)
# damn, a possible leader turnover. Let's see what this dispute is.
# ...okay, regime dispute pitting rebels forming operations in Nicaragua against Honduras.
# Despite the fact Honduras was a mess in 1920, our review materials suggest these incidents
# would've happened on Lopez' watch. Drop obsid HON-1919 here.

unknown_stdates %>%
  filter(!(dispnum == 2040 & ccode == 91 & obsid == "HON-1919")) -> unknown_stdates

# Now, let's see who the leader was on the end of the month...

unknown_stdates %>% rename(obsid_stmon = obsid, leadid_stmon = leadid) %>% select(-in_archigos) %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>%
              mutate(in_archigos = 1), by=c("ccode"="ccode","stdate3"="date")) -> unknown_stdates
# ^ nothing duplicated. huzzah.

# Now, was there a leadership transition at any point...
unknown_stdates %>%
  filter(obsid_stmon != obsid)
# ^ 8 cases...

unknown_stdates %>%
  filter(obsid_stmon != obsid) %>%
  select(-in_archigos, -leadid, -leadid_stmon) %>%
  data.frame

#   dispnum ccode    stdate2    stdate3 obsid_start      obsid
# 1      91   220 1887-05-01 1887-05-31  FRN-1886-2 FRN-1887-1
# 2     247   220 1905-01-01 1905-01-31    FRN-1902   FRN-1905
# 3    1363     2 1961-01-01 1961-01-31    USA-1953   USA-1961
# 4    1418   461 1963-01-01 1963-01-31    TOG-1960   TOG-1963
# 5    1677    40 1933-08-01 1933-08-31    CUB-1925 CUB-1933-1
# 6    2030   812 1960-08-01 1960-08-31  LAO-1960-2 LAO-1960-4
# 7    2622   500 1971-01-01 1971-01-31    UGA-1962   UGA-1971
# 8    4190   640 1996-06-01 1996-06-30  TUR-1996-1 TUR-1996-2

# Off to the GML archives we go....
# MID#0091, France: the dispute ends on May 22 of the same year, and our review says it's Goblet with that in mind. Drop obsid FRN-1887-1
# MID#0247, France: our review suggests Combes should get this dispute. Drop obsid FRN-1905
# MID#1363, USA:. Oooh, a U.S. case. Eisenhower was president for the foggy start of this one. Drop obsid USA-1961.
# MID#1418, Togo: double unknowns, so I can expect this one in the end date search. Earliest report we have is Jan. 6.
#           That's Olympio. Drop obsid TOG-1963. Gunitzky will be the guy at the end, tho.
# MID#1677, Cuba: this one is messy, but our first report dates to August 7. So, drop CUB-1933-1 here.
# MID#2030, Laos: there are three here! Our reports date these incidents to the 19th. That would be after Somsan and Kong Le. So,
#                 that would be LAO-1960-4 and not LAO-1960-2.
# MID#2622, Uganda: our review suggests this is Amin. Drop obsid UGA-1962.
# MID#4190, Turkey: double unknowns, so expect this in the next search. Clear start here for Yilmaz.
#                   The nature of this dispute suggests Erbakan is likely the head of state for its end, though. Certainly, Syria's
#                   defense minister said so.


unknown_stdates %>%
  rename(obsid_endmon = obsid) %>%
  select(dispnum, ccode, styear, stmon, obsid_stmon, obsid_endmon) %>%
  mutate(obsid = case_when(
    dispnum == 91 & ccode == 220 ~ "FRN-1886-2",
    dispnum == 247 & ccode == 220 ~ "FRN-1902",
    dispnum == 1363 & ccode == 2 ~ "USA-1953",
    dispnum == 1418 & ccode == 461 ~ "TOG-1960",
    dispnum == 1677 & ccode == 40 ~ "CUB-1925",
    dispnum == 2030 & ccode == 812 ~ "LAO-1960-4",
    dispnum == 2622 & ccode == 500 ~ "UGA-1971",
    dispnum == 4190 & ccode == 640 ~ "TUR-1996-1",
    # and after that, they're the same thing, so just pick one...
    TRUE ~ obsid_stmon
  )) -> unknown_stdates


# Finally: end dates, unknown days. ----

Part %>%
  mutate(endday2 = 1,
         enddate2 = make_date(endyear, endmon, endday2)) %>%
  filter(endday == -9) %>%
  mutate(enddate3 = as.Date(eom(make_datetime(endyear, endmon)))) %>%
  select(dispnum, endyear, endmon, ccode, enddate2, enddate3) -> unknown_enddates

unknown_enddates %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>%
              mutate(in_archigos = 1), by=c("ccode"="ccode","enddate2"="date")) -> unknown_enddates

# ^ nothing duplicated. That's good.

unknown_enddates %>% rename(obsid_stmon = obsid, leadid_stmon = leadid) %>% select(-in_archigos) %>%
  left_join(., leaderdays %>% select(ccode, obsid, leadid, date) %>%
              mutate(in_archigos = 1), by=c("ccode"="ccode","enddate3"="date")) -> unknown_enddates

# ^ nothing duplicated. That's a relief.
# All right. What do we have...

unknown_enddates %>%
  filter(obsid_stmon != obsid) %>%
  select(-in_archigos, -leadid, -leadid_stmon) %>%
  data.frame

# Nine cases. Some should be familiar.
# dispnum ccode   enddate2   enddate3 obsid_start      obsid
# 1    1098   160 1955-09-01 1955-09-30    ARG-1946 ARG-1955-1
# 2    1418   461 1963-01-01 1963-01-31    TOG-1960   TOG-1963
# 3    1535     2 1885-03-01 1885-03-31  USA-1881-2   USA-1885
# 4    1639   101 1887-08-01 1887-08-31  VEN-1886-2   VEN-1887
# 5    1670   220 1926-07-01 1926-07-31  FRN-1925-2 FRN-1926-2
# 6    2973   380 1982-10-01 1982-10-31    SWD-1979   SWD-1982
# 7    4190   640 1996-06-01 1996-06-30  TUR-1996-1 TUR-1996-2
# 8    4197     2 2001-01-01 2001-01-31    USA-1993   USA-2001
# 9    4244   490 1997-05-01 1997-05-31    DRC-1965   DRC-1997


# Off to the GML archives we go....
# MID#1098, Argentina: a messy case, but the *end* here would be with Lonardi. Drop ARG-1946.
# MID#1418, Togo: prepared for this one. Its Gunitzky. Drop TOG-1960.
# MID#1535, USA: news report dates to March 20, 1885. Cleveland was president then. Drop USA-1881-2.
# MID#1639, Venezuela: FML, a six-month count, though I remember coding this in grad school. Cleveland (1913, 49)
#                      suggests the occupation of territory happened sometime before Oct. 26. Ireland (1938, 235) is
#                      the absolute only source for this incident and he's vague on specifics. A New York Times report
#                      from Sept. 26, 1887 notes Guzman Blanco left the presidency early with the idea of negotiating the
#                      end of this dispute. However, that's kind of immaterial since what matters here is the date of the
#                      occupation, not necessarily when Guzman Blanco tried to end it. No matter, and absent any other information
#                      I'm left to give this to Guzman Blanco for ending it. Drop VEN-1887 here.
# MID#1670, France: A CSM report on July 7 suggests an early end to this dispute in the month. This would be Briand (FRN-1925-2). France
#                   actually has three leaders this month.
# MID#2973, Sweden: last news report we have is via Globe and Mail wire from Oct. 27. Palme was new leader then. Drop obsid SWD-1979.
# MID#4190, Turkey: double unknowns, but I came prepared. TUR-1996-2 is the leader at the end here.
# MID#4197, USA: Russia does show of force, US and Canada go on alert. Our review suggests this only nominally bleeds into 2001, but
#                Clinton would still have been president. Drop USA-2001 here.
# MID#4244, DRC: Only once incident, starting on the 8th. It's kind of foggy here, but the implication is Mobutu (removed on the 16th)
#                should be understood as head of state for the end date as well, notwithstanding the -9 there. Drop obsid DRC-1997.


unknown_enddates %>%
  rename(obsid_endmon = obsid) %>%
  select(dispnum, ccode, endyear, endmon, obsid_stmon, obsid_endmon) %>%
  mutate(obsid = case_when(
    dispnum == 1098 & ccode == 160 ~ "ARG-1955-1",
    dispnum == 1418 & ccode == 461 ~ "TOG-1963",
    dispnum == 1535 & ccode == 2 ~ "USA-1885",
    dispnum == 1639 & ccode == 101 ~ "VEN-1886-2",
    dispnum == 1670 & ccode == 220 ~ "FRN-1925-2",
    dispnum == 2973 & ccode == 380 ~ "SWD-1982",
    dispnum == 4190 & ccode == 640 ~ "TUR-1996-2",
    dispnum == 4197 & ccode == 2 ~ "USA-1993",
    dispnum == 4244 & ccode == 490 ~ "DRC-1965",
    # and after that, they're the same thing, so just pick one...
    TRUE ~ obsid_stmon
  )) -> unknown_enddates


# Merge time now -----
## * known start dates ----

Part %>%
  select(dispnum, ccode, styear, stmon, stday, stdate, enddate, endyear, endmon, endday) %>%
  left_join(., known_stdates %>% select(dispnum, ccode, stdate, obsid)) %>%
  rename(obsid_knownstdate = obsid) -> hold_this

## * unknown start dates ----

hold_this %>%
  left_join(., unknown_stdates %>% select(dispnum:stmon, obsid)) %>%
  rename(obsid_unknownstdate = obsid) -> hold_this

## * known end dates ----
hold_this %>%
  left_join(., known_enddates %>% select(dispnum, ccode, enddate, obsid)) %>%
  rename(obsid_knownenddate = obsid) -> hold_this

## * unknown end dates ----

hold_this %>%
  left_join(., unknown_enddates %>% select(dispnum:endmon, obsid)) %>%
  rename(obsid_unknownenddate = obsid) -> hold_this


hold_this %>%
  mutate(obsid_start = ifelse(is.na(stdate), obsid_unknownstdate, obsid_knownstdate),
         obsid_end = ifelse(is.na(enddate), obsid_unknownenddate, obsid_knownenddate)) %>%
  select(dispnum:stday, endyear:endday, obsid_start, obsid_end) -> gml_part

# * dummy start/end dates, in cases of unknowns and dates coinciding with leader turnover ----
# This is going to be a parlor trick for doing leader-year analyses.
# IT SHOULD NOT BE USED FOR CALCULATING DURATIONS
# Basically, because coercing these information to leader-year is going to go through a leader-day
# conversion, which will primarily lean on matching with ccodes and dates, we're going to need to make
# sure no wrong leader is identified.

gml_part %>%
  mutate(dummy_stday = case_when(
    # We're going to start with cases where we need to adjust the day to make sure they don't coincide with leaders to whom disputes don't apply
    # MID#0125 is illustrative here. This started with the overthrow of the monarchy, on the 14th. However, the overthrow
    # is what started the MID, so Faisal II shouldn't get any overlap here. So, we're going to impute the 15th here because,
    # that way, a merge down the road won't credit Faisal II as being part of this dispute. Really: he wasn't even alive.
    dispnum == 125 & ccode == 645 & styear == 1958 ~ 15, # post-date
    dispnum == 258 & ccode == 385 & styear == 1940 ~ 8, # pre-dating it, so Quisling isn't involved.
    dispnum == 1530 & ccode == 41 & styear == 1888 ~ 17, # post-date
    dispnum == 2079 & ccode == 155 & styear == 1958 ~ 4, # post-date
    dispnum == 2331 & ccode == 645 & styear == 1958 ~ 15, # post-date, as above
    dispnum == 3133 & ccode == 630 & styear == 1909 ~ 17, # post-date
    dispnum == 3179 & ccode == 200 & styear == 1976 ~ 4, # pre-date,
    dispnum == 4293 & ccode == 694 & styear == 1995 ~ 28, # post-date, because it happened after a coup.
    # NOW: the unknown dates...
    # Some of these, you may need to get creative. If you can, just impute a 1.
    dispnum == 91 & ccode == 220 & styear == 1887 ~ 1,
    dispnum == 247 & ccode == 220 & styear == 1905 ~ 1,
    dispnum == 1363 & ccode == 2 & styear == 1961 ~ 1,
    dispnum == 1418 & ccode == 461 & styear == 1963 ~ 1,
    dispnum == 1677 & ccode == 40 & styear == 1933 ~ 7, # we suggest a start date around the 7th, so why not...
    dispnum == 2030 & ccode == 812 & styear == 1960 ~ 19, # we suggest a start date around the 19th
    dispnum == 2622 & ccode == 500 & styear == 1971 ~ 25, # This is Amin's dispute, and he starts the 25th.
    dispnum == 4190 & ccode == 640 & styear == 1996 ~ 1, # Yilmaz, so just impute a 1.
    # One other case: the unknown date for Honduras in MID#2040.
    # This happened on Lopez' watch. We'll add this to Nicaragua too.
    dispnum == 2040 & ccode == 91 & styear == 1920 ~ 2,
    dispnum == 2040 & ccode == 93 & styear == 1920 ~ 2,
    # for most applications, certainly with known days, just use what you got.
    stday != -9 ~ stday,
    # The lion's share of these cases are ones with no leader transition, so just impute 1.
    TRUE ~ 1,
  )) -> gml_part

gml_part %>%
  mutate(last_day_endmon = day(as.Date(eom(make_datetime(endyear, endmon))))) %>%
  mutate(last_day_endmon = as.double(last_day_endmon)) %>%
  mutate(dummy_endday = case_when(
    # Cases where the end date collides with a leader transition and we want to cheat around that.
    dispnum == 257 & ccode == 211 & endyear == 1918 ~ 10, # pre-date
    dispnum == 258 & ccode == 360 & endyear == 1944 ~ 22, # pre-date
    dispnum == 1350 & ccode == 812 & endyear == 1960 ~ 6, # pre-date
    dispnum == 1435 & ccode == 811 & endyear == 1979 ~ 6, # pre-date
    dispnum == 1750 & ccode == 640 & endyear == 1876 ~ 29, # pre-date
    dispnum == 2341 & ccode == 100 & endyear == 1898 ~ 6, # pre-date
    dispnum == 2649 & ccode == 710 & endyear == 1917 ~ 15, # post-date
    dispnum == 3020 & ccode == 2 & endyear == 1981 ~ 21, # post-date
    dispnum == 3179 & ccode == 200 & endyear == 1976 ~ 4, # pre-date
    dispnum == 3564 & ccode == 640 & endyear == 1993 ~ 15, # pre-date
    dispnum == 3568 & ccode == 2 & endyear == 1993 ~ 21, # post-date
    dispnum == 3705 & ccode == 385 & endyear == 1940 ~ 8, # pre-date
    dispnum == 4162 & ccode == 570 & endyear == 1994 ~ 13, # pre-date
    dispnum == 4246 & ccode == 484 & endyear == 1997 ~ 16, # post-date
    # NOW: the unknown end days
    # If it's the new leader from the month, grab the last day. If not, get creative.
    dispnum == 1098 & ccode == 160 & endyear == 1955 ~ last_day_endmon,
    dispnum == 1418 & ccode == 461 & endyear == 1963 ~ last_day_endmon,
    dispnum == 1535 & ccode == 2 & endyear == 1885 ~ last_day_endmon,
    dispnum == 1639 & ccode == 101 & endyear == 1887 ~ 7, # a tough one, but I'm giving it to Guzman Blanco.
    dispnum == 1670 & ccode == 220 & endyear == 1926 ~ 7, # date of CSM report
    dispnum == 2973 & ccode == 380 & endyear == 1982 ~ last_day_endmon,
    dispnum == 4190 & ccode == 640 & endyear == 1996 ~ last_day_endmon,
    dispnum == 4197 & ccode == 2 & endyear == 2001 ~ 1, # this didn't bleed long into 2001
    dispnum == 4244 & ccode == 490 & endyear == 1997 ~ 15, # I'm saying Mobutu, and he's removed on the 16th. Let's make it the 15th so there's no spillover.
    # for most applications, certainly with known days, just use what you got.
    endday != -9 ~ endday,
    # The lion's share of these cases are ones with no leader transition, so just impute the last day of the month
    TRUE ~ last_day_endmon
  )) -> gml_part

gml_part %>% select(-last_day_endmon) -> gml_part

Part %>% select(dispnum:styear, sidea, hiact, orig) %>%
  left_join(gml_part, .) -> gml_part

# For later usage: what disputes have missing leaders?
gml_part %>%
  group_by(dispnum) %>%
  mutate(anymiss_leader_start = ifelse(any(is.na(obsid_start)), 1, 0),
         anymiss_leader_end = ifelse(any(is.na(obsid_end)), 1, 0),
         allmiss_leader_start = ifelse(all(is.na(obsid_start)), 1, 0),
         allmiss_leader_end = ifelse(all(is.na(obsid_end)), 1, 0),) %>%
  ungroup() -> gml_part

save(gml_part, file="data/gml_part.rda")

# LEADERS WHO INITIATED OR WERE TARGETED -----



## * A discussion here about action weirdness in dispute data -----

# If the state is a joiner, you'll have to look no matter what.
# If hiact %in% c(17, 20, 21) for either/both sides, who knows and you'll have to look.
#
# gml_part_leaders %>%
#   group_by(dispnum) %>%
#   mutate(n_ccodes = n_distinct(ccode),
#          bilat = ifelse(n_ccodes == 2, 1, 0)) %>%
#   ungroup() -> gml_part_leaders
#
#
# gml_part_leaders %>%
#   mutate(init = case_when(
#     # If hiact %in% c(0:16) AND it's bilateral AND sidea == 0, it has to be targeted.
#     hiact %in% c(0:16) & bilat == 1 & sidea == 0 ~ 0,
#     # If hiact %in% c(0:16) AND it's bilateral AND sidea == 1, it was initiator.
#     hiact %in% c(0:16) & bilat == 1 & sidea == 1 ~ 1,
#     # If hiact %in% c(0:16) and it's multilateral BUT it's an originator and sidea == 0, still targeted
#     hiact %in% c(0:16) & bilat == 0 & sidea == 0 & orig == 1 ~ 0,
#     # Likewise: hiact %in% c(0:16), multilateral, sidea == 1 & orig == 1, initiator
#     hiact %in% c(0:16) & bilat == 0 & sidea == 1 & orig == 1 ~ 1,
#     # Related to the above stuff, if hiact == 0, not an initiator
#     hiact == 0 ~ 0,
#   )) -> gml_part_leaders
#
# gml_part_leaders %>% summary
# # FML, 1699 cases...
# # Mind you, leader data start at 1870. Can we make this a little easier?
# gml_part_leaders %>% filter(!is.na(obsid_start) & !is.na(obsid_end)) %>% summary
# # FML, 1552 cases.
# # Goddammit, okay...
#
#
# gml_part_leaders %>%
#   filter(is.na(init)) %>% distinct(dispnum)
# # 688 disputes, though...
# # Okay, I'm going to take this off-script and do it in a working directory. It'll be easier than doing an endless case_when command.
#
# gml_part_leaders %>%
#   group_by(dispnum) %>%
#   filter(any(is.na(init))) %>%
#   write_csv(., "data-raw/scratchpad/missing-participant-initiators.csv", na='')
#
# # ^ This will involve some archive searching. I'll add a comment column that explains my work.
# # Will also save to .xlsx, just in case...
# # My data set, my rules: I'm going to borrow from Hutchison and Gibler (2007) and Miller (2013, 2017), who interpret
# # a simultaneous clash to be a case of initiator. Borrowing baseball terminology, "tie goes to the offense."
#
#
# save(gml_part_leaders, file="data/gml_part_leaders.rda")
