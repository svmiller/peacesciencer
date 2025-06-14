library(tidyverse)

# 5.1 ----

haven::read_dta("/home/steve/Koofr/data/atop/5.1/atop5_1ddyr.dta") %>%
  rename_all(tolower) -> atop_alliance

atop_alliance %>%
  select(statea, stateb, year, defense:consul) %>%
  rename(ccode1 = statea,
         ccode2 = stateb,
         atop_defense = defense,
         atop_offense = offense,
         atop_neutral = neutral,
         atop_nonagg = nonagg,
         atop_consul = consul) -> atop_alliance

nrow(atop_alliance) # 273296
nrow(atop_alliance %>% slice(1, .by =c(ccode1, ccode2, year))) # 273296

# atop_alliance %>%
#   mutate(ccodel = ifelse(ccode1 > ccode2, ccode2, ccode1),
#          ccodeh = ifelse(ccode1 > ccode2, ccode1, ccode2)) %>%
#   filter(ccodel == 2 & ccodeh == 20 & year == 1942)

save(atop_alliance, file="data/atop_alliance.rda")

# 5.0 ----
# atop_alliance <- haven::read_dta("/home/steve/Dropbox/data/atop/ATOP 5_0 (dta)/atop5_0ddyr.dta") %>%
#   rename_all(tolower)
#
# atop_alliance %>%
#   select(statea, stateb, year, defense:consul) %>%
#   rename(ccode1 = statea,
#          ccode2 = stateb,
#          atop_defense = defense,
#          atop_offense = offense,
#          atop_neutral = neutral,
#          atop_nonagg = nonagg,
#          atop_consul = consul) -> atop_alliance
#
# # scan for duplicates?
# atop_alliance %>% group_by(ccode1, ccode2, year) %>% summarize(n = n()) %>% arrange(-n)

# Nope, we're good.

#save(atop_alliance, file="data/atop_alliance.rda")
