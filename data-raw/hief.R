library(tidyverse)

read_csv("~/Dropbox/data/hief/HIEF_data.csv") %>%
  rename_all(tolower) %>%
  mutate(ccode = countrycode::countrycode(country, "country.name", "cown")) %>%
  mutate(ccode = ifelse(country == "Democratic Republic of Vietnam", 816, ccode),
         ccode = ifelse(country == "Serbia", 345, ccode)) -> hief


hief %>%
  mutate(gwcode = countrycode::countrycode(country, "country.name", "gwn")) %>%
  mutate(gwcode = ifelse(country == "Republic of Vietnam", 817, gwcode)) %>%
  arrange(ccode) %>%
  select(ccode, gwcode, country, year, efindex) -> hief


save(hief, file="data/hief.rda")
