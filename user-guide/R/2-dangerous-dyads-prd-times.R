library(tidyverse)
library(peacesciencer)
library(stevemisc)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
library(tictoc)
tic.clearlog()

for (x in 1:100) {
  # passing x to tic() makes it a label at time of the matching toc() call.
  tic(x)
  create_dyadyears(directed = FALSE, mry=FALSE) %>%
    # start whittling to PRDs first.
    # It means we start with contiguity
    add_contiguity() %>%
    mutate(landcontig = ifelse(conttype == 1, 1, 0)) %>%
    # Add information about major power status
    add_cow_majors() %>%
    mutate(cowmajdyad = ifelse(cowmaj1 == 1 | cowmaj2 == 1, 1, 0)) %>%
    # filter to PRDs
    filter_prd() %>%
    # Add GML-MID data (bare essentials)
    add_gml_mids(keep=NULL) %>%
    # Add peace years
    add_peace_years() %>%
    # Add NMC data
    add_nmc() %>%
    mutate(milperpop1 = milper1/tpop1,
           milperpop2 = milper2/tpop2,
           minmilperpop = ifelse(milperpop1 > milperpop2, milperpop2, milperpop1)) %>%
    # create CINC proportion
    mutate(cincprop = ifelse(cinc1 > cinc2, cinc2/cinc1, cinc1/cinc2)) %>%
    # Add democracy data
    add_democracy() %>%
    # create weak-link specification
    mutate(mindemest = ifelse(xm_qudsest1 > xm_qudsest2, xm_qudsest2, xm_qudsest1)) %>%
    # Add alliance data
    add_cow_alliance() %>%
    # add SDP/GDP
    add_sdp_gdp(system = "cow") %>%
    mutate(wbgdppc2011est1 = exp(wbgdp2011est1)/exp(wbpopest1),
           wbgdppc2011est2 = exp(wbgdp2011est2)/exp(wbpopest2),
           minwbgdppc2011est = ifelse(wbgdppc2011est1 > wbgdppc2011est2, wbgdppc2011est2, wbgdppc2011est1)) -> Data

  Data %>%
    mutate_at(vars("cincprop", "mindemest", "minwbgdppc2011est", "minmilperpop"),
              ~r2sd(.)) -> Data

  modDD <- glm(gmlmidonset ~ landcontig + cincprop + cowmajdyad + cow_defense +
                 mindemest + minwbgdppc2011est + minmilperpop +
                 gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3), data= Data,
               family=binomial(link="logit"))

  rm(M1, Data)
  gc()
  toc(log = TRUE, quiet = TRUE)
}


Times <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))

saveRDS(Times, "data/Times.rds")
