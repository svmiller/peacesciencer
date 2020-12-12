library(tidyverse)
# For clarity: downloaded this file on 12-12-2020.
# Did a simple find and replace of ":" for "-"
# added column names in what amounts to a tsv.
gw_states <- read_tsv("/home/steve/Dropbox/data/gleditsch/system/iisystem-2017.dat")

gw_states %>%
  mutate(startdate = lubridate::dmy(startdate),
         enddate = lubridate::dmy(enddate)) -> gw_states

save(gw_states, file="data/gw_states.rda")
