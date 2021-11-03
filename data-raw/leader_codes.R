library(tidyverse)
library(peacesciencer)

# Let's first load stuff in ----

# LEAD has the following duplicates:
# A2.9-1114 in 1920 (Francisco Aguilar Barquer). He came into office in 1919 and his tenure wasn't interrupted.
# LEAD duplicates LUX-1918 (Reuter). Let's drop LEAD.v1-10038 here.
# LEAD triplicates (sic) ICE-1980. Drop LEAD.v1-10072 and LEAD.v1-10073
rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
  filter(!(leadid29 == "A2.9-1114" & year == 1920)) %>%
  filter(!(leaderid %in% c("LEAD.v1-10038", "LEAD.v1-10072", "LEAD.v1-10073")))

# daddy Archigos now
Archigos29 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_2.9-Public.dta")
Archigos41 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_4.1_stata14.dta")


# I filled in a few of these as well as I could.
# These had missing Archigos codes, which builds in the assumption the LEAD project added these people.
missing_filled_in <- readxl::read_excel("~/Dropbox/projects/peacesciencer/data-raw/scratchpad/missing_archigos-filled-in.xlsx")


missing_filled_in

# Grab codes -----
# Archigos41 is most current, but I think we have to work front to back, so to say.
# IGNORE THE DATES HERE. Assume Archigos41 is most current on that front.

Archigos41 %>%
  select(obsid, leadid) -> archigos41_codes


archigos41_codes


Archigos29 %>%
  select(obsid, leadid) -> archigos29_codes

archigos29_codes

# Don't use the years here for anything...
# Do nothing else other than grab codes.
rawLEAD %>%
  select(leaderid, leadid29) -> lead_codes

lead_codes


missing_filled_in %>%
  select(obsid, leaderid) -> imputed_codes

imputed_codes


# Merge codes... -----

archigos41_codes %>%
  left_join(., archigos29_codes %>% rename(leadid29 = leadid)) -> leader_codes

# Use the "" to your advantage here...
leader_codes %>% left_join(., lead_codes %>% filter(leadid29 != "")) -> leader_codes


imputed_codes %>%
  filter(!(leaderid %in% c("LEAD.v1-10038", "LEAD.v1-10072", "LEAD.v1-10073"))) %>%
  filter(!is.na(obsid)) %>%
  rename(temp_leaderid = leaderid) %>%
  left_join(leader_codes, .) %>%
  mutate(leaderid = ifelse(is.na(leaderid), temp_leaderid, leaderid)) %>%
  select(-temp_leaderid) %>%
  select(obsid, leadid, leadid29, leaderid) -> leader_codes


save(leader_codes, file="data/leader_codes.rda")
