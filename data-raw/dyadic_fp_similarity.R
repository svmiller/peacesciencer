library(tidyverse)
library(peacesciencer)

dyadic_fp_similarity <- haven::read_dta("~/Dropbox/data/hage2011cc/msim-data12-fpsim-v02.dta") %>%
  # these are in here, and we don't need or want them
  filter(ccode1 != ccode2) %>%
  # also don't want the abbreviations
  select(-cabb1, -cabb2)

# no duplicates *fist-emoji*
dyadic_fp_similarity  %>%
  group_by(ccode1, ccode2, year) %>%
  filter(n() > 1)

# what versions are we looking at
dyadic_fp_similarity %>%
  select(version:versionunvote)

# version 2.0 of the data
# version 2016 of the state system membership data (which, yeah)
# version 4.1 of the CoW alliance data
# version 5.0 of the national material capabilities data
# version 2017 of the UN voting data, by Voeten

dyadic_fp_similarity
  select(-version:-versionunvote) -> dyadic_fp_similarity

dyadic_fp_similarity %>%
  mutate_at(vars(srsvas:pivv), ~round(., 3)) -> dyadic_fp_similarity

dyadic_fp_similarity %>%
  select(-version:-versionunvote) -> dyadic_fp_similarity

# save(dyadic_fp_similarity, file="data/dyadic_fp_similarity.rda")
# ^ waaay too big. 17.7 MB. Even after round to 3 decimal points. Booo.

saveRDS(dyadic_fp_similarity, "~/Dropbox/svmiller.github.io/R/peacesciencer/dyadic_fp_similarity.rds")
