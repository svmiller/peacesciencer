library(tidyverse)
library(peacesciencer)


archigos
Archigos29 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_2.9-Public.dta")
Archigos41 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_4.1_stata14.dta")

# Remember: LEAD has two entries for Francisco Aguilar Barquero, one in 1919 and another in 1920.
# If I had to guess, I think it was a mistake to have the 1920 observation here.
rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
  filter(!(leadid29 == "A2.9-1114" & year == 1920))


rawLEAD %>%
  # not a fan of imputing NAs like this...
  filter(leadid29 == "") %>%
  select(year, ccode, leaderid, leadername, birthyear, startdate, enddate) -> missing_archigos


missing_archigos %>%
  group_by(ccode) %>%
  tally() %>% data.frame
#^ most of these, it seems, are going to come with the LEAD people squaring Archigos to CoW states.
# Let's see..

ccodes_in_missing <- unique(missing_archigos$ccode)

gw_states %>% filter(gwcode %in% ccodes_in_missing)

# Hmm, not quite. Let's see what's happening here and, importantly, if Archigos 4 picks up some of these.
# Where I can, I'm going to input some of these here and save the finished product as an xlsx...
write_csv(missing_archigos, "data-raw/scratchpad/missing_archigos.csv", na='')

# Some of these don't have dates.... and I'd really love impute some of these. However, I don't think that's
# really my place here. Still, it's tempting. I know the Grenada case well. Really want to fill in some of these.
# Overall, though, I think it's probably a means to just see if we can't augment Archigos with LEAD and have a CoW-specific
# leader data set and a G-W-specific leader data set.

# A few comments here, as I go through this:
# One: make sure to scrub out the dates, if they're more current, and anything ongoing at the end of 2004 can be changed
# to what's in Archigos. Also, LEAD may have missed a leader? I think? For example, Archigos has a SUR-1990-1, but LEAD has
# just the SUR-1990-2. I don't know the specifics here.
# LEAD duplicates LUX-1918.
# This is having me think I should outright ignore the year column in these data.
# On Iceland now. *Definitely* don't use these dates. So many enddates are missing in LEAD, but Archigos has them.
# LEAD triplicates (sic?) ICE-1980

missing_filled_in <- readxl::read_excel("~/Dropbox/projects/peacesciencer/data-raw/scratchpad/missing_archigos-filled-in.xlsx")


missing_filled_in

# I'm going to have to work backward a little bit. IIRC, I started with the `lwuf` stuff, then added in LEAD to that.
# Even though lwuf comes after LEAD, this is at least how I did it
# I should probably just say 'nuts to it' and reconstruct everything, starting with LEAD (since LEAD precedes lwuf)
# Fuck it, I need to create a leader code data frame.
