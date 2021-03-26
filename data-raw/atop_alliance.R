library(tidyverse)

atop_alliance <- haven::read_dta("/home/steve/Dropbox/data/atop/ATOP 5_0 (dta)/atop5_0ddyr.dta") %>%
  rename_all(tolower)

atop_alliance %>%
  select(statea, stateb, year, defense:consul) %>%
  rename(ccode1 = statea,
         ccode2 = stateb,
         atop_defense = defense,
         atop_offense = offense,
         atop_neutral = neutral,
         atop_nonagg = nonagg,
         atop_consul = consul) -> atop_alliance

# scan for duplicates?
atop_alliance %>% group_by(ccode1, ccode2, year) %>% summarize(n = n()) %>% arrange(-n)

# Nope, we're good.

save(atop_alliance, file="data/atop_alliance.rda")
