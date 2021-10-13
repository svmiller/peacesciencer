library(tidyverse)
library(peacesciencer)

archigos

Archigos29 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_2.9-Public.dta")

Thetas <- read_csv("~/Dropbox/data/cartersmith2020fmlw/Measures/CarterSmithThetas.csv")


Archigos29 %>%
  select(obsid:leader, -idacr) %>%
  left_join(., Thetas %>% select(leadid29, theta1_mean, theta1_sd, theta2_mean, theta2_sd,
                                 theta3_mean, theta3_sd, theta4_mean, theta4_sd) %>% rename(leadid = leadid29)) -> lwuf

# ^ something duplicated... what duplicated...

lwuf %>% group_by(leadid) %>% tally() %>% arrange(-n)

# A2.9-1114

Thetas %>% filter(leadid29 == "A2.9-1114")

# Carter and Smith have two entries for Francisco Aguilar Barquero, one in 1919 and another in 1920.
# If I had to guess, I think it was a mistake to have the 1920 observation here. I think this came from the LEAD data.

haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
  filter(leadid29 == "A2.9-1114") %>% data.frame

# Observe how everything is the same, except for the age, and the age might be why the estimates differ a bit.
# That likely just got picked up by Carter and Smith (2020)
# I'm going to drop it and do it again.

Archigos29 %>%
  select(obsid:leader, -idacr) %>%
  left_join(., Thetas %>% filter(!(leadid29 == "A2.9-1114" & year == 1920)) %>% select(leadid29, theta1_mean, theta1_sd, theta2_mean, theta2_sd,
                                 theta3_mean, theta3_sd, theta4_mean, theta4_sd) %>% rename(leadid = leadid29)) -> lwuf

identical(nrow(lwuf), nrow(Archigos29))
# cool beans

lwuf %>%
  select(-ccode, -leader) %>%
  rename(leadid29 = leadid) -> lwuf


save(lwuf, file="data/lwuf.rda")
