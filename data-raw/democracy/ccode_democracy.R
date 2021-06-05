library(tidyverse)
library(peacesciencer)
library(countrycode)

gwcode_democracy <- create_stateyears()

Vdem <- readRDS("~/Dropbox/data/v-dem/10/V-Dem-CY-Core-v10.rds") %>%
  as_tibble() %>%
  select(country_name, year, v2x_polyarchy)

Vdem %>%
  mutate(ccode = countrycode(country_name, "country.name", "cown")) %>%
  arrange(ccode, year) -> Vdem

# The countrycode output I get:
# Some values were not matched unambiguously: Brunswick, Hamburg, Hesse-Darmstadt,
# Hesse-Kassel, Hong Kong, Nassau, Oldenburg, Palestine/British Mandate, Palestine/Gaza,
# Palestine/West Bank, Piedmont-Sardinia, Saxe-Weimar-Eisenach, Serbia, Somaliland, Würtemberg

# countrycode, great as it is, is going to struggle with a few cases:
# First, it's not going to know what to do with "Hesse-Darmstadt". This is Hesse Grand Ducal. NOT Hesse-Electoral
# Second: it's not going to know what to do with "Hesse-Kassel". This is Hesse Electorate. NOT Hesse Grand Ducal
# 3rd: it's not going to know what to do with "Saxe-Weimar-Eisenach." This is Saxony---I think---but Saxony is already represented. Let's ignore it.
# Fourth: It's not going to know what to do with "Würtemberg". This is, well, Würtemberg. ccode == 271.
# Finally: Serbia always throws it for a loop. Serbia == 345.
# Fifth, it doesn't treat Piedmont-Sardinia as the predecesor state to Italy, which CoW does (and it seems Vdem does too).
# I had a previous comment here about tripping up between ROV and Vietnam, but I think VAB fixed that in a recent update.


Vdem %>%
  mutate(ccode = ifelse(country_name == "Hesse-Darmstadt", 275, ccode),
         ccode = ifelse(country_name == "Hesse-Kassel", 273, ccode),
         ccode = ifelse(country_name == "Würtemberg", 271, ccode),
         ccode = ifelse(country_name == "Piedmont-Sardinia", 325, ccode),
         ccode = ifelse(country_name == "Serbia", 345, ccode)) %>%
  filter(!is.na(ccode)) -> Vdem

# Just looks like that Italy transition is the only thing with a duplicate
Vdem %>% filter(!is.na(ccode)) %>%
  group_by(ccode, year) %>%
  filter(n() > 1)

# Mercifully, it's not a case where we have to pick one or model both. One is missing, so we'll drop it.

Vdem %>%
  filter(!(country_name == "Italy" & year == 1861)) -> Vdem

ccode_democracy %>%
  left_join(., Vdem %>% select(ccode, year, v2x_polyarchy)) -> ccode_democracy


# Polity...

Polity <- readxl::read_excel("~/Dropbox/data/polity/p4v2017.xls") %>%
  select(ccode, country, year, polity2) %>%
  rename(polityccode = ccode)

# I'm not convinced Polity's ccodes are going to match CoW ccodes.
# In the case of Serbia, I know they won't.

Polity %>%
  mutate(ccode = countrycode::countrycode(country, "country.name", "cown")) -> Polity

# Some values were not matched unambiguously: Orange Free State, Prussia,
# Sardinia, Serbia, Serbia and Montenegro, United Province CA

# From the above: Sardinia is the predecessor state to Italy (325).
# Serbia (and Montenegro) = 345
# Prussia = 255, which Polity does get.

Polity %>%
  mutate(ccode = case_when(
    country == "Serbia"  ~ 345,
    country == "Serbia and Montenegro" ~ 345,
    country == "Sardinia" ~ 325,
    country == "Prussia" ~ 255,
    # got burned by this, not gonna lie
    polityccode == 305 & year <= 1918 ~ 300,
    # got burned by this too. Polity had this right
    polityccode == 260 ~ 260,
    # got burned by this too.
    polityccode == 730 & year <= 1905 ~ 730,
    TRUE ~ ccode
  )) -> Polity

# Check for duplicates, and this is going to likely turn up a lot.

Polity %>%
  group_by(ccode, year) %>%
  filter(n() > 1) -> polity_dups

polity_dups

# oof...
# So, we'll have to go through this manually:
# Colombia/Gran Colombia in 1832: drop Gran Colombia. It was over in 1831, IIRC.
# Germany/West Germany in 1945: both are NA (no shit...) but West Germany didn't exist until the mid-1950s.
# Germany/West Germany in 1990: both are the same, but pick W Germany because it was there on Jan. 1.
# Sardinia/Italy in 1861: judgment call, but drop Italy in 1861 since unification happened that year.
# Serbia and S&M (sic) in 2006: drop Serbia, the rump state that emerged later that year.
# Yugoslavia gets duplicated in 1991. Both are -5. Just slice it at the end.
# USSR and Russia in 1922. Another judgment call and the distance is rather large. No matter, USSR emerged in Dec. 1922. Pick Russia.
# Ethiopia in 1993 gets duplicated likely because Polity codes a new state after the civil war. Pick where politycode == 530.
# Sudan and Sudan-North get duplicated in 2011, again because of a civil war. Pick where politycode == 625
# Vietnam and Vietnam North get duplicated because of unification in 1976. Both are the same. Just pick one.


Polity %>%
  filter(!(polityccode == 99 & year == 1832)) %>%
  filter(!(country == "Germany West" & year == 1945)) %>%
  filter(!(country == "Germany" & year == 1990)) %>%
  filter(!(country == "Italy" & year == 1861)) %>%
  filter(!(country == "Serbia" & year == 2006)) %>%
  filter(!(polityccode == 347 & year == 1991)) %>%
  filter(!(country == "USSR" & year == 1922)) %>%
  filter(!(polityccode == 529 & year == 1993)) %>%
  filter(!(polityccode == 626 & year == 2011)) %>%
  filter(!(polityccode == 818 & year == 1976)) -> Polity


Polity %>%
  group_by(ccode, year) %>%
  filter(n() > 1)

# huzzah

Polity %>%
  select(ccode, year, polity2) %>%
  left_join(ccode_democracy, .) -> ccode_democracy

# QuickUDS -----
# devtools::install_github("xmarquez/QuickUDS")

library(QuickUDS)

measures <- c("pmm_arat", "blm",
              "bmr_democracy_femalesuffrage",
              "bnr_extended", "pmm_bollen", "csvmdi",
              "doorenspleet", "eiu",
              "wgi_democracy","fh_total_reversed",
              "fh_electoral", "gwf_democracy_extended",
              "pmm_hadenius", "kailitz_tri",
              "lexical_index", "mainwaring",
              "magaloni_democracy_extended",
              "pmm_munck", "pacl", "PEPS1v",
              "pitf", "polity2", "reign_democracy",
              "polyarchy_original_contestation",
              "prc", "svolik_democracy",
              "ulfelder_democracy_extended",
              "utip_dichotomous_strict", "v2x_polyarchy",
              "vanhanen_democratization", "wth_democ1")

# Generate Extended UDS

extended_model <- democracy_model(measures,
                                  verbose = FALSE,
                                  technical = list(NCYCLES = 2500))

Scores <- democracy_scores(model = extended_model)

democracy %>%
  select(extended_country_name, year, polity2) %>%
  left_join(Scores, .) -> Scores


# The usual suspects here...
Scores %>% rename(ccode = cown) %>% select(ccode, year, z1) %>%
  filter(!is.na(ccode)) %>%
  group_by(ccode, year) %>% filter(n() > 1)

# ^ it's also Serbia from 1913 to 1920, and 2006
# Extended country names will be Serbia or Yugoslavia
# I think I'm just going to drop the Yugoslavia observations in those years
# Rationale: Yugoslavia didn't exist (technically) from 1913 to 1918
# Thereafter, let's just be consistent.

Scores %>%
  filter(!(extended_country_name == "Yugoslavia" & between(year, 1913, 1920))) %>%
  filter(!(extended_country_name == "Yugoslavia" & year == 2006)) -> Scores

# Then, for some Germany weirdness, let's just take the first one.
Scores %>% group_by(cown, year) %>%
  slice(1) -> Scores

Scores %>% group_by(cown, year) %>% filter(n() > 1)
# huzzah

Scores %>%
  select(cown, year, z1) %>%
  rename(ccode = cown,
         xm_qudsest = z1) %>%
  left_join(ccode_democracy, .) %>%
  # I don't like identifiers that could only get in the way
  # Plus, characters can really soak up disk space in an R package
  select(-statenme) -> ccode_democracy

save(ccode_democracy, file="data/ccode_democracy.rda")
