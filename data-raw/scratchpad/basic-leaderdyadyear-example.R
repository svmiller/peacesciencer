library(tidyverse)
library(peacesciencer)

readRDS(url("http://svmiller.com/R/peacesciencer/cow_dir_leader_dyad_years.rds")) %>%
  declare_attributes(data_type = "leader_dyad_year", system = "cow") -> Data

Data %>%
  filter_prd() %>%
  filter(year %in% c(1816:2010)) %>%
  add_gml_mids() %>%
  add_spells() %>%
  add_nmc() %>%
  add_democracy() %>%
  add_cow_alliance() -> Data

# p. 264: "for all models, we use robust standard errors clustered by disputes."
# That can't be right. I'm guessing they're clustering on leader-dyad? leader1?
# Anyway, we need to do some last odds and ends here.

Data %>%
  mutate(leaderdyad = paste0(obsid1,"/",obsid2),
         female2 = ifelse(gender2 == "F", 1, 0),
         landcontig = ifelse(conttype == 1, 1, 0),
         demweaklink = ifelse(xm_qudsest1 <= xm_qudsest2, xm_qudsest1, xm_qudsest2),
         relpow = cinc1/(cinc1 + cinc2)) -> Data


library(fixest)

broom::tidy(M1 <- feglm(gmlmidonset_init ~ leaderage1 + leaderage2 +
                    log(yrinoffice1) + log(yrinoffice2) +
                  demweaklink + female2 + relpow + landcontig +
                    cow_defense + splines::bs(gmlmidinitspell, 4),
                  data = Data,
                  cluster = "leaderdyad"))
