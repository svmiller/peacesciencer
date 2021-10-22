library(tidyverse)
library(peacesciencer)


lwuf %>%
  select(obsid, leadid29) -> LEAD

# Remember: LEAD has two entries for Francisco Aguilar Barquero, one in 1919 and another in 1920.
# If I had to guess, I think it was a mistake to have the 1920 observation here.
rawLEAD <- haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
  filter(!(leadid29 == "A2.9-1114" & year == 1920))



rawLEAD %>% filter(leadid29 != "") %>%
  select(leadid29, leveledu, milservice, combat, rebel, warwin,
         warloss, rebelwin, rebelloss, yrsexper, physhealth, mentalhealth) %>%
  left_join(LEAD, .) -> LEAD


save(LEAD, file="data/LEAD.rda")
