library(tidyverse)
library(peacesciencer)

leader_codes

Thetas <- read_csv("~/Dropbox/data/cartersmith2020fmlw/Measures/CarterSmithThetas.csv")

# Carter and Smith (2020) are primarily using LEAD here as their reference point.
# In theory, that makes the leaderid variable the master variable. Let's poke around and see what's happening here.
# I already know Francisco Aguilar Barquer duplicates here.

Thetas %>%
  group_by(leaderid) %>% filter(n() > 1)

# ^ there he is.

# Do Carter and Smith have the same issue with the Luxembourg dude and Iceland dude?

Thetas %>%
  filter(leaderid  %in% c("LEAD.v1-10037", "LEAD.v1-10038"))

# Seems so. The dimensions of the data frame aren't the same here either.
# Is there anything else I should know about?

Thetas %>%
  group_by(leadername, startdate) %>% # this should do it...
  filter(n() > 1)

# Doesn't appear so. Looks like it's just those familiar problems from the LEAD data.
# Be gone with you three, and with the Barquero duplicate.

Thetas %>%
  filter(!(leaderid %in% c("LEAD.v1-10038", "LEAD.v1-10072", "LEAD.v1-10073"))) %>%
  filter(!(leaderid == "LEAD.v1-1114" & year == 1920)) -> Thetas

# Grab what we want now.

Thetas %>%
  select(leaderid, theta1_mean, theta1_sd, theta2_mean, theta2_sd,
         theta3_mean, theta3_sd, theta4_mean, theta4_sd) %>%
  left_join(leader_codes, .) %>%
  select(obsid, theta1_mean:ncol(.)) -> lwuf

save(lwuf, file="data/lwuf.rda")


# Everything below here is old stuff. I'm just going to comment it out rather than delete it.
# Not like anyone reads this anyway. I mean, who would? It assumes people are interested.
# No one cares what you're doing and you delude yourself into thinking what you do adds value or is important.
# library(tidyverse)
# library(peacesciencer)
#
# archigos
#
# Archigos29 <- haven::read_dta("~/Dropbox/data/archigos/Archigos_2.9-Public.dta")
#
# Thetas <- read_csv("~/Dropbox/data/cartersmith2020fmlw/Measures/CarterSmithThetas.csv")
#
#
# Archigos29 %>%
#   select(obsid:leader, -idacr) %>%
#   left_join(., Thetas %>% select(leadid29, theta1_mean, theta1_sd, theta2_mean, theta2_sd,
#                                  theta3_mean, theta3_sd, theta4_mean, theta4_sd) %>% rename(leadid = leadid29)) -> lwuf
#
# # ^ something duplicated... what duplicated...
#
# lwuf %>% group_by(leadid) %>% tally() %>% arrange(-n)
#
# # A2.9-1114
#
# Thetas %>% filter(leadid29 == "A2.9-1114")
#
# # Carter and Smith have two entries for Francisco Aguilar Barquero, one in 1919 and another in 1920.
# # If I had to guess, I think it was a mistake to have the 1920 observation here. I think this came from the LEAD data.
#
# haven::read_dta("~/Dropbox/data/LEAD/leaders_datapaper_replication_final_9_10_15.dta") %>%
#   filter(leadid29 == "A2.9-1114") %>% data.frame
#
# # Observe how everything is the same, except for the age, and the age might be why the estimates differ a bit.
# # That likely just got picked up by Carter and Smith (2020)
# # I'm going to drop it and do it again.
#
# Archigos29 %>%
#   select(obsid:leader, -idacr) %>%
#   left_join(., Thetas %>% filter(!(leadid29 == "A2.9-1114" & year == 1920)) %>% select(leadid29, theta1_mean, theta1_sd, theta2_mean, theta2_sd,
#                                  theta3_mean, theta3_sd, theta4_mean, theta4_sd) %>% rename(leadid = leadid29)) -> lwuf
#
# identical(nrow(lwuf), nrow(Archigos29))
# # cool beans
#
# lwuf %>%
#   select(-ccode, -leader) %>%
#   rename(leadid29 = leadid) -> lwuf
#
#
# save(lwuf, file="data/lwuf.rda")
