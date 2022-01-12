library(tidyverse)
library(peacesciencer)
library(stevemisc)

create_stateyears(system = 'gw', subset_years = c(1946:2019)) %>%
  add_ucdp_acd(type=c("intrastate"), only_wars = FALSE) %>%
  add_peace_years() %>%
  add_democracy() %>%
  add_creg_fractionalization() %>%
  add_sdp_gdp() %>%
  add_rugged_terrain() -> Data

create_stateyears(system = 'gw', subset_years = c(1946:2019)) %>%
  add_ucdp_acd(type=c("intrastate"), only_wars = TRUE) %>%
  add_peace_years() %>%
  rename_at(vars(ucdpongoing:ucdpspell), ~paste0("war_", .)) %>%
  left_join(Data, .) -> Data




Data %>%
  arrange(gwcode, year) %>%
  group_by(gwcode) %>%
  mutate_at(vars("xm_qudsest", "wbgdppc2011est",
                 "wbpopest"), list(l1 = ~lag(., 1))) %>%
  rename_at(vars(contains("_l1")),
            ~paste("l1", gsub("_l1", "", .), sep = "_") ) -> Data


modCW <- list()
summary(modCW$"All UCDP Conflicts" <- glm(ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    ucdpspell + I(ucdpspell^2) + I(ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))

summary(modCW$"Wars Only"  <- glm(war_ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    war_ucdpspell + I(war_ucdpspell^2) + I(war_ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))




saveRDS(modCW, "data/modCW.rds")
