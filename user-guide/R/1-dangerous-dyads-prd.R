library(tidyverse)
library(peacesciencer)
library(stevemisc)


create_dyadyears(directed = FALSE, mry = FALSE) %>%
  filter_prd() %>%
  add_gml_mids(keep = NULL) %>%
  add_peace_years() %>%
  add_nmc() %>%
  add_democracy() %>%
  add_cow_alliance() %>%
  add_sdp_gdp() -> Data


Data %>%
  mutate(landcontig = ifelse(conttype == 1, 1, 0)) %>%
  mutate(cowmajdyad = ifelse(cowmaj1 == 1 | cowmaj2 == 1, 1, 0)) %>%
  # Create estimate of militarization as milper/tpop
  # Then make a weak-link
  mutate(milit1 = milper1/tpop1,
         milit2 = milper2/tpop2,
         minmilit = ifelse(milit1 > milit2,
                           milit2, milit1)) %>%
  # create CINC proportion (lower over higher)
  mutate(cincprop = ifelse(cinc1 > cinc2,
                           cinc2/cinc1, cinc1/cinc2)) %>%
  # create weak-link specification using Quick UDS data
  mutate(mindemest = ifelse(xm_qudsest1 > xm_qudsest2,
                            xm_qudsest2, xm_qudsest1)) %>%
  # Create "weak-link" measure of jointly advanced economies
  mutate(minwbgdppc = ifelse(wbgdppc2011est1 > wbgdppc2011est2,
                             wbgdppc2011est2, wbgdppc2011est1)) -> Data

Data %>%
  mutate_at(vars("cincprop", "mindemest", "minwbgdppc", "minmilit"),
            ~r2sd(.)) -> Data

modDD <- glm(gmlmidonset ~ landcontig + cincprop + cowmajdyad + cow_defense +
               mindemest + minwbgdppc + minmilit +
               gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3), data= Data,
             family=binomial(link="logit"))
#
# create_dyadyears(directed = FALSE, mry=FALSE) %>%
#   # start whittling to PRDs first.
#   # It means we start with contiguity
#   add_contiguity() %>%
#   # cra
#   mutate(contig = ifelse(conttype %in% c(1:5), 1, 0)) %>%
#   # Add information about major power status
#   add_cow_majors() %>%
#   mutate(cowmajdyad = ifelse(cowmaj1 == 1 | cowmaj2 == 1, 1, 0)) %>%
#   # filter to PRDs
#   filter_prd() %>%
#   # Add GML-MID data (bare essentials)
#   # Returns just whether there was a unique onset or ongoing dispute
#   add_gml_mids(keep=NULL) %>%
#   # Create peace years since last ongoing dispute
#   add_peace_years() %>%
#   # Add CoW's NMC data
#   add_nmc() %>%
#   # Create estimate of militarization as milper/tpop
#   # Then make a weak-link
#   mutate(milit1 = milper1/tpop1,
#          milit2 = milper2/tpop2,
#          minmilit = ifelse(milit1 > milit2,
#                            milit2, milit1)) %>%
#   # create CINC proportion (lower over higher)
#   mutate(cincprop = ifelse(cinc1 > cinc2,
#                            cinc2/cinc1, cinc1/cinc2)) %>%
#   # Add democracy data
#   add_democracy() %>%
#   # create weak-link specification using Quick UDS data
#   mutate(mindemest = ifelse(xm_qudsest1 > xm_qudsest2,
#                             xm_qudsest2, xm_qudsest1)) %>%
#   # Add alliance data, includes whether there was a defense pact
#   add_cow_alliance() %>%
#   # add SDP/GDP
#   add_sdp_gdp(system = "cow") %>%
#   # create GDP per capita estimate,
#   # Create "weak-link" measure of jointly advanced economies
#   mutate(wbgdppc1 = exp(wbgdp2011est1)/exp(wbpopest1),
#          wbgdppc2 = exp(wbgdp2011est2)/exp(wbpopest2),
#          minwbgdppc = ifelse(wbgdppc1 > wbgdppc2,
#                              wbgdppc2, wbgdppc1)) -> Data
# Data %>%
#   mutate_at(vars("cincprop", "mindemest", "minwbgdppc", "minmilit"),
#                  ~r2sd(.)) -> Data
#
# modDD <- glm(gmlmidonset ~ contig + cincprop + cowmajdyad + cow_defense +
#             mindemest + minwbgdppc + minmilit +
#             gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3), data= Data,
#           family=binomial(link="logit"))

saveRDS(modDD, "data/modDD.rds")
