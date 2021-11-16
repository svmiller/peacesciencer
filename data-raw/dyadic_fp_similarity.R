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

# While we're here, let's add some tau-b

library(foreach)

cow_alliance %>%
  # Create a "commitment" variable
  mutate(commitment = case_when(
    cow_defense == 1 ~ 3,
    cow_defense == 0 & (cow_neutral == 1 | cow_nonagg == 1) ~ 2,
    cow_defense == 0 & cow_neutral == 0 & cow_nonagg == 0 & cow_entente == 1 ~ 1)) %>%
  select(ccode1, ccode2, year, commitment) -> Alliances


DDY <- create_dyadyears(subset_years = c(1816:2012))

# Prepare our cores for work ----

half_cores  <- parallel::detectCores()/2
library(foreach)
my.cluster <- parallel::makeCluster(
  half_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = half_cores)
foreach::getDoParRegistered()

Data <- foreach(
  # for each year from 1816 to 2012
  i = 1816:2012
) %dopar% { # disperse across all our available cores, and...
  # subset the alliance data to the given year
  Alliances %>% filter(year == i) -> ally_year
  # subset the dyad-year data to just the given year
  DDY %>% filter(year == i) -> ddy_year

  # Tau-b depends on an assumption states make maximal commitments to defend themselves.
  # So, we need state-v-same-state dyads (e.g. USA-USA-1816) here.
  # That's what this is doing
  ddy_year %>%
    expand(ccode1=ccode1, ccode2=ccode2, year = i) %>%
    # Grab the same-state dyads
    filter(ccode1 == ccode2) %>%
    # Bind 'em
    bind_rows(ddy_year, .) %>%
    # Arrange 'em in order
    arrange(ccode1, ccode2) -> ddy_year

  # Take dyad-year slice of a given year and
  ddy_year %>%
    # merge in what we want
    left_join(., ally_year %>% select(ccode1, ccode2, year, commitment)) %>%
    # Where missing...
    mutate(commitment = case_when(
      # A state makes a maximal commitment to defend itself
      is.na(commitment) & ccode1 == ccode2 ~ 3,
      # A dyad that is not the same state has no alliance
      is.na(commitment) & ccode1 != ccode2 ~ 0,
      TRUE ~ commitment
    )) -> hold_this

  hold_this %>%
    # remove year, we'll get it back later
    select(-year) %>%
    # spread out the data to be more matrix-like
    spread(ccode2, commitment) %>%
    # make it a matrix for easier calculation
    as.matrix() %>%
    # get a correlation matrix of Kendall Tau-b
    cor(method="kendall") %>%
    # Convert back to tibble
    as_tibble() %>%
    # Remove the Tau-bs of ccodes (because you don't want those)
    select(-ccode1) %>% slice(-1) %>%
    # Get new column of unique ccode1s that year
    bind_cols(ddy_year %>% distinct(ccode1), .) %>%
    # take from wide to long
    gather(ccode2, taub, -ccode1) %>%
    # add year identifier
    mutate(year = i) -> hold_this

}

parallel::stopCluster(cl = my.cluster)

Data %>%
  bind_rows(.) %>%
  select(ccode1, ccode2, year, taub) %>%
  filter(ccode1 != ccode2) %>%
  arrange(ccode1, year, ccode2) %>%
  mutate(ccode2 = as.numeric(ccode2)) -> Data

Data %>% right_join(., dyadic_fp_similarity) -> dyadic_fp_similarity

# Any duplicates?
dyadic_fp_similarity %>% group_by(ccode1, ccode2, year) %>% filter(n() > 1)
# We're good.

saveRDS(dyadic_fp_similarity, "~/Dropbox/svmiller.github.io/R/peacesciencer/dyadic_fp_similarity.rds")
