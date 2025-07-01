library(tidyverse)

TTI <- readRDS("/home/steve/Koofr/projects/terr-threat-index-paper/data-raw/TTI.rds")
TTIm <- readRDS("/home/steve/Koofr/projects/terr-threat-index-paper/data-raw/TTIm.rds")


TTIm %>% rename(lterrthreat = value) %>%
  rename_at(vars("lterrthreat", "sd", "lwr", "upr"),
            ~paste0("m_", .)) %>%
  left_join(TTI, .) -> terrthreat

terrthreat %>%
  rename(lterrthreat = value)

save(terrthreat, file="data/terrthreat.rda")
