library(tidyverse)
library(stevemisc)

require(countrycode)

td_rivalries <- strategic_rivalries

td_rivalries %>%
  mutate(ccodea = countrycode(sidea, "country.name", "cown"),
         ccodeb = countrycode(sideb, "country.name", "cown")) -> td_rivalries

# Austria is "Austria" in the rivalry data, but Austria-Hungary before it.
# We'll fix some of this a bit later too.
td_rivalries$ccodea[td_rivalries$sidea == "Austria"] <- 300
# Prussia doesn't appear as a partial matching term for successor state Germany
td_rivalries$ccodea[td_rivalries$sidea == "Prussia"] <- 255
# countrycode instinctively gives Germany's ccode to West Germany
td_rivalries$ccodea[td_rivalries$sidea == "West Germany"] <- 260
# Ottoman Empire doesn't appear as a matching term for successor state Turkey
td_rivalries$ccodea[td_rivalries$sidea == "Ottoman Empire"] <- 640
# Silly error, but countrycode doesn't know between Vietnams
td_rivalries$ccodea[td_rivalries$sidea == "North Vietnam"] <- 816


td_rivalries$ccodeb[td_rivalries$sideb == "Ottoman Empire"] <- 640
# Note: I'm creating this since Venice never appears in the CoW data. I won't ever use it.
# You probably won't either.
td_rivalries$ccodeb[td_rivalries$sideb == "Venice"] <- 324
td_rivalries$ccodeb[td_rivalries$sideb == "Prussia"] <- 255
# countrycode always struggles with Serbia as successor state to Yugoslavia.
td_rivalries$ccodeb[td_rivalries$sideb == "Serbia"] <- 345

td_rivalries %>%
  mutate(ccode1 = ifelse(ccodeb > ccodea, ccodea, ccodeb),
         ccode2 = ifelse(ccodeb > ccodea, ccodeb, ccodea)) %>%
  select(-ccodea, -ccodeb) -> td_rivalries


td_rivalries %>%
  select(rivalryno, rivalryname, ccode1, ccode2, everything(), -sidea, -sideb) -> td_rivalries


save(td_rivalries, file="data/td_rivalries.rda")



td_rivalries %>%
  bind_rows(td_rivalries %>% rename(ccode1 = .data$ccode2, ccode2 = .data$ccode1), .) %>%
  arrange(.data$rivalryno) %>%
  select(.data$rivalryno, .data$rivalryname, .data$ccode1, .data$ccode2,
         .data$styear, .data$endyear, .data$region, .data$type1, .data$type2, .data$type3) %>%
  rowwise() %>%
  mutate(year = list(seq(.data$styear, .data$endyear))) %>%
  # Unnest the list, which will expand the data.
  unnest(c(.data$year)) %>% filter(ccode1 == 2 & year == 2000)

  group_by(ccode1, year, type1) %>% summarize(ntype1 = n_distinct(type1),
                                                                        ntype2 = n_distinct(type2),
                                                                        ntype3 = n_distinct(type3)) %>% filter(ccode1 == 2 & year >= 2000)
  # Minor note: ccode change for Austria, post-1918 for rivalryno 79.
  mutate(ccode1 = ifelse(.data$ccode1 == 300 & .data$year >= 1919, 305, .data$ccode1),
         ccode2 = ifelse(.data$ccode2 == 300 & .data$year >= 1919, 305, .data$ccode2))

td_rivalries
