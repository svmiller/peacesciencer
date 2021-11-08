library(tidyverse)
# For clarity: downloaded this file on 12-12-2020.
# Did a simple find and replace of ":" for "-"
# added column names in what amounts to a tsv.
gw_states <- read_tsv("/home/steve/Dropbox/data/gleditsch/system/iisystem-2017.dat")

gw_states %>%
  mutate(startdate = lubridate::dmy(startdate),
         enddate = lubridate::dmy(enddate)) -> gw_states

# Okay, what's not ASCII...

gw_states %>% mutate_if(is.character,
                     list(enc = ~stringi::stri_enc_isascii(.))) %>%
  filter(stateabb_enc == FALSE | statename_enc == FALSE)

# ^ ugh, you two...
# Okay, fine, I'll fix this.

gw_states %>%
  mutate(statename = case_when(
    gwcode == 271 ~ "Wuerttemberg",
    gwcode == 437 ~ "Cote D'Ivoire",
    TRUE ~ statename
  )) -> gw_states

save(gw_states, file="data/gw_states.rda")
