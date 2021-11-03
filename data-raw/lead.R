library(tidyverse)
library(peacesciencer)

leader_codes

rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
  filter(!(leadid29 == "A2.9-1114" & year == 1920)) %>%
  filter(!(leaderid %in% c("LEAD.v1-10038", "LEAD.v1-10072", "LEAD.v1-10073")))


# LEAD's ID system is primarly the leaderid variable, so let's merge on that.
rawLEAD %>%
  select(leaderid, leveledu, milservice, combat, rebel, warwin,
         warloss, rebelwin, rebelloss, yrsexper, physhealth, mentalhealth) %>%
  left_join(leader_codes, .) %>%
  select(obsid, leveledu:mentalhealth) -> LEAD


save(LEAD, file="data/LEAD.rda")

# Everything below here is old stuff. I'm just going to comment it out rather than delete it.
# Not like anyone reads this anyway. I don't even know why I'm doing any of this.
# No one cares and no one's offering me any ticket out of here anytime soon.
# But I can rearrange deck chairs on the Titanic with the best of them and just be gloomy and sad about it.
# library(tidyverse)
# library(peacesciencer)
#
# # LEAD has the following duplicates:
# # A2.9-1114 in 1920 (Francisco Aguilar Barquer). He came into office in 1919 and his tenure wasn't interrupted.
# # LEAD duplicates LUX-1918 (Reuter). Let's drop LEAD.v1-10038 here.
# # LEAD triplicates (sic) ICE-1980. Drop LEAD.v1-10072 and LEAD.v1-10073
# rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
#   filter(!(leadid29 == "A2.9-1114" & year == 1920)) %>%
#   filter(!(leaderid %in% c("LEAD.v1-10038", "LEAD.v1-10072", "LEAD.v1-10073")))
#
# Archigos29 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_2.9-Public.dta")
#
#
#
#
#
#
# lwuf %>%
#   select(obsid, leadid29) -> LEAD
#
# # Remember: LEAD has two entries for Francisco Aguilar Barquero, one in 1919 and another in 1920.
# # If I had to guess, I think it was a mistake to have the 1920 observation here.
# rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
#   filter(!(leadid29 == "A2.9-1114" & year == 1920))
#
#
#
# rawLEAD %>% filter(leadid29 != "") %>%
#   select(leadid29, leveledu, milservice, combat, rebel, warwin,
#          warloss, rebelwin, rebelloss, yrsexper, physhealth, mentalhealth) %>%
#   left_join(LEAD, .) -> LEAD
#
#
# save(LEAD, file="data/LEAD.rda")
