# https://diegopuga.org/data/rugged/
library(tidyverse)



read_csv("~/Dropbox/data/ruggedness/rugged_data.csv") %>%
  select(isocode, country, rugged) -> rugged


rugged %>%
  mutate(ccode = countrycode::countrycode(isocode, "iso3c", "cown")) -> rugged
#ℹ Some values were not matched unambiguously: ABW, AIA, ANT, ASM, BMU, CCK, COK,
# CXR, CYM, ESH, FLK, FRO, GIB, GLP, GRL, GUF, GUM, HKG, IOT, MAC, MNP, MSR, MTQ,
#MYT, NCL, NFK, NIU, PCN, PRI, PSE, PYF, REU, SCG, SHN, SJM, SPM, TCA, TKL, UMI, VGB, VIR, WLF


rugged %>% filter(is.na(ccode)) %>% data.frame
# ^ Ugh, Serbia... always.

rugged %>% filter(ccode = ifelse(isocode == "SCG", 345, ccode)) -> rugged

rugged %>% filter(!is.na(ccode)) %>% arrange(ccode) %>% data.frame

rugged %>%
  mutate(gwcode = countrycode::countrycode(isocode, "iso3c", "gwn")) -> rugged

# Fix a few things
rugged %>%
  mutate(gwcode = ifelse(ccode == 816, 816, gwcode),
         gwcode = ifelse(ccode == 679, 678, gwcode),
         gwcode = ifelse(ccode == 345, 340, gwcode)) -> rugged




mountainous <- haven::read_dta("~/Dropbox/data/mountainous/mountainous.dta")

mountainous %>%
  select(ccode, newlmtnest) %>%
  left_join(rugged, .) %>%
  mutate(removeme = ifelse(is.na(gwcode) & is.na(ccode), 1, 0)) %>%
  filter(removeme == 0) %>%
  select(-removeme) -> rugged


rugged %>%
  select(ccode, gwcode, rugged, newlmtnest) -> rugged


save(rugged, file="data/rugged.rda")
