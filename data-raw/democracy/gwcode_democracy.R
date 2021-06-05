library(tidyverse)
library(peacesciencer)
library(countrycode)

gwcode_democracy <- create_stateyears(system = "gw")


Vdem <- readRDS("~/Dropbox/data/v-dem/10/V-Dem-CY-Core-v10.rds") %>%
  as_tibble() %>%
  select(country_name, year, v2x_polyarchy)

Vdem %>%
  mutate(gwcode = countrycode(country_name, "country.name", "gwn")) %>%
  arrange(gwcode, year) -> Vdem


#ℹ Some values were not matched unambiguously: Baden (X), Bavaria (X), Brunswick (-), Hamburg (-), Hanover,
# Hesse-Darmstadt, Hesse-Kassel, Hong Kong, Mecklenburg Schwerin, Modena, Nassau, Oldenburg,
# Palestine/British Mandate, Palestine/Gaza, Palestine/West Bank, Papal States, Parma,
# Piedmont-Sardinia, Republic of Vietnam, Sao Tome and Principe, Saxe-Weimar-Eisenach,
# Saxony, Seychelles, Somaliland, Tuscany, Two Sicilies, Vanuatu, Würtemberg, Yemen
# ^ thanks boo
# I'm going to "X" these out as I identify them.

# A lot of German states here. I have to remind myself who these are again.

gw_states %>% filter(between(gwcode, 240, 290))

# Baden is 267.  Bavaria is 245. GW has no Brunswick or Hamburg. Hanover is 240.
# Hesse-Darmstadt is Hesse Grand Ducal (275). Hesse-Kassel is the other one (Electoral, 273).
# No Hong Kong. Mecklenburg Schwerin is 280. Modena is 332. No Nassau. No Oldenburg.
# No Palestines. Papal States is 327. Parma is 335. Piedmont-Sardinia is proto-Italy (325).
# Republic of Vietnam is probably 817, but let me check the dates.
# Hmm...
# Here's a wager: all those years probably implies that we're using 815 from 1816 to 1893 and
# 817 from 1954 to 1975. There's an added problem here: i.e. countrycode burned 817 on "Vietnam".
# So, here's what I think should be done: "Republic of Vietnam" is 815 from start date (1802, but that doesn't
# matter here) until 1893. From 1894 to 1953, "Republic of Vietnam" is NA. From 1954 to 1975, it's 817.
# "Vietnam" is 816 from 1954 onward, and NA before that.
# Okay, back on track: GW doesn't have Sao Tome and Principe. Per the ccode version, there is a Saxe-Weimar-Eisenach
# and a Saxony. I think both are the same, per CoW/GW? Either way, I'm going to ignore Saxe-Weimar-Eisenach
# and retain Saxony as 269. No Seychelles, no Somaliland. Tuscany is 337. Two Sicilies is 329. No Vanuatu.
# Würtemberg is 271.
# Yemen requires some further inspection. There is a continuous "Yemen" from 1789 to 1850, then from 1918 to 2019.
# Interestingly, Vdem has no record that I can tell of a YPR. So, we'll just hand 678 to this observation

# Let's apply those corrections and remove anything that has a missing gwcode
Vdem %>%
  mutate(gwcode = case_when(
    country_name == "Baden" ~ 267,
    country_name == "Bavaria" ~ 245,
    country_name == "Hanover" ~ 240,
    country_name == "Hesse-Darmstadt" ~ 275,
    country_name == "Hesse-Kassel" ~ 273,
    country_name == "Mecklenburg Schwerin" ~ 280,
    country_name == "Modena" ~ 332,
    country_name == "Papal States" ~ 327,
    country_name == "Parma" ~ 335,
    country_name == "Piedmont-Sardinia" ~ 325,
    country_name == "Republic of Vietnam" & year <= 1893 ~ 815,
    country_name == "Republic of Vietnam" & between(year, 1894, 1953) ~ NA_real_,
    country_name == "Vietnam" & year <= 1953 ~ NA_real_,
    country_name == "Vietnam" & year >= 1954 ~ 816,
    country_name == "Saxony" ~ 269,
    country_name == "Tuscany" ~ 337,
    country_name == "Two Sicilies" ~ 329,
    country_name == "Würtemberg" ~ 271,
    country_name == "Yemen" ~ 278,
    TRUE ~ gwcode
  )) -> Vdem


# How are we doing?
Vdem %>%
  arrange(gwcode) %>%
  distinct(gwcode, country_name) %>%
  data.frame

# Looks good.
Vdem %>%
  filter(!is.na(gwcode)) -> Vdem

# Let's see where we have duplicates. I'm going to wager dollars to donuts we have a few for things like Russia/USSR and Serbia/Yugoslavia, and other
# complex cases like these.

Vdem %>%
  group_by(gwcode, year) %>%
  filter(n() > 1)

# Ooh, neat. Just the one for Italy. Same problem in the ccode version. Let's apply that correction

Vdem %>%
  filter(!(country_name == "Italy" & year == 1861)) -> Vdem

gwcode_democracy %>%
  left_join(., Vdem %>% select(gwcode, year, v2x_polyarchy)) -> gwcode_democracy


# Polity now...

Polity <- readxl::read_excel("~/Dropbox/data/polity/p4v2017.xls") %>%
  select(ccode, country, year, polity2) %>%
  rename(polityccode = ccode)


# I know Polity's ccodes aren't going to match CoW ccodes, let along GW codes.
# In the case of Serbia, I know they won't.
# So, let's do it the hard way.

Polity %>%
  mutate(gwcode = countrycode::countrycode(country, "country.name", "gwn")) -> Polity

# ℹ Some values were not matched unambiguously: Baden, Bavaria, Modena, Orange Free State,
# Papal States, Parma, Prussia, Sardinia, Saxony, Serbia and Montenegro, Tuscany,
# Two Sicilies, United Province CA, Vietnam South, Wuerttemburg, Yemen
# ^ thanks boo

# Okay, we know the drill...
# Vietnam, Yemen, and Serbia and Montenegro will require some closer inspection.
# In other words: Polity has three Vietnams ("Vietnam", "Vietnam North", "Vietnam South")
# I can already tell countrycode gave 817 to "Vietnam" and "817" to "Vietnam North" and balked on "Vietnam South".
# All are unfortunately wrong.
# There are three Yemens: "Yemen" got NA, "Yemen North" got 678 and "Yemen South" got 680. Functionally correct,
# but "Yemen" needs the 678 too.
# There is also "Serbia" (340, correct), "Serbia and Montenegro" (NA, but can be fixed), and "Yugoslavia" (345, correct).

# I'll start with the Vietnams
Polity %>% filter(country %in% c("Vietnam", "Vietnam North", "Vietnam South")) %>%
  arrange(year)
# Cool thing is there are no 19th century observations, so we don't have to worry about 815. Everything here is 1954 to 2019.
# The operative year stretch here is 1974, 1975, 1976, and 1977. In 1974, there is "Vietnam North" and "Vietnam South".
# In 1975, those two are still there. In 1976, there is "Vietnam North" and "Vietnam". IN 1977, there is just Vietnam.
# Okay, so: 1954 to 1975, DRV is 816 and RVN is 817, which, duh. In 1976, just drop "Vietnam North". It doesn't matter.
# Both are -7. Thereafter, 1977 forward should be 816.

# This should be an odd one:
Polity %>% filter(country %in% c("Serbia", "Serbia and Montenegro", "Yugoslavia")) %>%
  arrange(year) %>%
  group_by(country, gwcode) %>%
  summarize(years = paste0(year, collapse = ", ")) %>%
  data.frame

# So, Polity has "Serbia" from 1830 to 1920, then 2006 to 2017.
# "Serbia and Montenegro" is just 2003-2006"
# "Yugoslavia" is 1921 to 2002.
# This will stand at odds with G-W. Here's how they have it:
# Serbia is Serbia from 1878 to 1915. Yugoslavia is Yugoslavia from 1918 to 2006 (which would swallow all those S&M years)
# Thereafter: Serbia from 2006 forward.
# This is going to be messy, so I think I'm going to start by scrubbing those gwcodes and doing them from scratch

Polity %>%
  mutate(gwcode = case_when(
    country == "Baden" ~ 267,
    country == "Bavaria" ~ 245,
    country == "Modena" ~ 332,
    country == "Orange Free State" ~ 564, # first appearance in the wild for me
    country == "Papal States" ~ 327,
    country == "Parma" ~ 335,
    country == "Prussia" ~ 255,
    country == "Sardinia" ~ 325,
    country == "Saxony" ~ 269,
    country == "Tuscany" ~ 337,
    country == "Two Sicilies" ~ 329,
    country == "United Province CA" ~ 89,
    country == "Vietnam South" ~ 817,
    country == "Wuerttemburg" ~ 271,
    country == "Yemen" ~ 678,
    country == "Vietnam North" & between(year, 1954, 1975) ~ 816,
    country == "Vietnam North" & year == 1976 ~ NA_real_,
    country == "Vietnam" ~ 816,
    country == "Vietnam South" ~ 817,
    # country %in% c("Serbia", "Serbia and Montenegro", "Yugoslavia") ~ NA_real_,
    country == "Serbia" & year %in% c(1878:1915, 2006:2017) ~ 340,
    country == "Serbia" & year %in% c(1918:1920) ~ 345,
    country == "Yugoslavia" & year %in% c(1921:2002) ~ 345,
    country == "Serbia and Montenegro" ~ 345,
    country == "Serbia" & year %in% c(1830:1877, 1916, 1917) ~ NA_real_,
    # Follow up inspection identifies the following problems:
    country == "Gran Colombia" ~ 99,
    country == "Korea" ~ 730,
    TRUE ~ gwcode
  )) -> Polity

# How are we doing?

Polity %>%
  arrange(gwcode) %>%
  distinct(gwcode, polityccode, country) %>% data.frame

# I think we got everything.

Polity %>%
  filter(!is.na(gwcode)) -> Polity

# Check for duplicates, and this is going to likely turn up a lot.

Polity %>%
  group_by(gwcode, year) %>%
  filter(n() > 1) -> polity_dups

polity_dups %>% arrange(gwcode, year) %>% select(gwcode, country, year, polity2, polityccode)

# Not as much as I recall from the CoW stuff. I'm glad I did this because it also alerted me to "Gran Colombia" being in here.
# Germany/West Germany in 1945: both are NA (no shit...) but West Germany didn't exist until 1949 in these data.
# Germany/West Germany in 1990: both are the same, but pick W Germany because it was there on Jan. 1.
# Sardinia/Italy in 1861: judgment call, but drop Italy in 1861 since unification happened that year.
# Yugoslavia gets duplicated in 1991. Both are -5. Just slice it at the end.
# USSR and Russia in 1922. Another judgment call and the distance is rather large. No matter, USSR emerged in Dec. 1922. Pick Russia.
# Ethiopia in 1993 gets duplicated likely because Polity codes a new state after the civil war. Pick where politycode == 530.
# Sudan and Sudan-North get duplicated in 2011, again because of a civil war. Pick where politycode == 625
# Yemen and Yemen North get duplicated in 1990. Both are the same. Just pick one.

Polity %>%
  filter(!(country == "Germany West" & year == 1945)) %>%
  filter(!(country == "Germany" & year == 1990)) %>%
  filter(!(country == "Italy" & year == 1861)) %>%
  filter(!(polityccode == 347 & year == 1991)) %>%
  filter(!(country == "USSR" & year == 1922)) %>%
  filter(!(polityccode == 529 & year == 1993)) %>%
  filter(!(polityccode == 626 & year == 2011)) %>%
  filter(!(country == "Yemen" & year == 1990)) -> Polity

# huzzah

Polity %>%
  select(gwcode, year, polity2) %>%
  left_join(gwcode_democracy, .) -> gwcode_democracy


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
  left_join(Scores, .) %>%
  select(extended_country_name, GWn, year, polity2, z1) -> Scores


Scores %>%
  mutate(gwcode = countrycode::countrycode(extended_country_name, "country.name", "gwn")) -> Scores

# Some values were not matched unambiguously: Abkhazia, American Samoa, Andorra, Anguilla, Antigua & Barbuda,
# Aruba, Austria-Hungary, Baden, Bavaria, Bermuda, British Mandate of Palestine, Cayman Islands, Cook Islands,
# Dominica, Federated States of Micronesia, French Guiana, Greenland, Grenada, Guam, Hanover,
# Hesse-Darmstadt (Ducal), Hesse-Kassel (Electoral), Hong Kong, Jersey, Kiribati, Korea,
# People's Republic of, Liechtenstein, Macao, Marshall Islands, Martinique,
# Mecklenburg-Schwerin, Modena, Monaco, Nauru, Netherlands Antilles, Niue,
# Orange Free State, Palau, Palestine, State of, Papal States, Parma, Puerto Rico,
# Reunion, Saint Kitts and Nevis, Saint Lucia, Saint Vincent and the Grenadines,
# Samoa/Western Samoa, San Marino, Sao Tome and Principe, Saxony, Seychelles, Sicily (Two Sicilies),
# Somaliland, South Ossetia, Tibet, Tonga, Transvaal, Tuscany, Tuvalu, United Provinces o [... truncated]
# ℹ Some strings were matched more than once, and therefore set to <NA> in the result: Vietnam (Annam/Cochin China/Tonkin),710,817
# ^ oh god...

# Sigh... okay. Let's do this.

Scores %>%
  mutate(gwcode = case_when(
    extended_country_name == "Austria-Hungary" ~ 300,
    extended_country_name == "Baden" ~ 267,
    extended_country_name == "Bavaria" ~ 245,
    extended_country_name == "Hanover" ~ 240,
    extended_country_name == "Hesse-Darmstadt (Ducal)" ~ 275,
    extended_country_name == "Hesse-Kassel (Electoral)" ~ 273,
    extended_country_name == "Mecklenburg-Schwerin" ~ 280,
    extended_country_name == "Modena" ~ 332,
    extended_country_name == "Orange Free State" ~ 564,
    extended_country_name == "Papal States" ~ 327,
    extended_country_name == "Parma" ~ 335,
    extended_country_name == "Saxony" ~ 269,
    extended_country_name == "Sicily (Two Sicilies)" ~ 329,
    extended_country_name == "Tibet" ~ 711,
    extended_country_name == "Transvaal" ~ 563,
    extended_country_name == "Tuscany" ~ 337,
    TRUE ~ gwcode
  )) -> Scores

# We're not done. Let's see what's left.

Scores %>% filter(is.na(gwcode)) %>% distinct(extended_country_name) %>% pull()

Scores %>%
  mutate(gwcode = case_when(
    extended_country_name == "United Provinces of Central America" ~ 89,
    extended_country_name == "Vietnam (Annam/Cochin China/Tonkin)" ~ 815,
    extended_country_name == "Wurttemberg" ~ 271,
    TRUE ~ gwcode
  )) -> Scores

# Any more clean up?
Scores %>%
  distinct(extended_country_name, GWn, gwcode) %>%
  arrange(gwcode) %>%
  data.frame

# Yep...
Scores %>%
  mutate(gwcode = case_when(
    extended_country_name == "Great Colombia" ~ 99,
    extended_country_name == "Germany (Prussia)" ~ 255,
    extended_country_name == "Israel, occupied territories only" ~ NA_real_,
    extended_country_name == "Korea" ~ 730,
    extended_country_name == "Korea, People's Republic of" ~ 731,
    TRUE ~ gwcode
  )) -> Scores

# Let's manually inspect a few problematic cases
Scores %>%
  filter(gwcode %in% c(815, 816, 817, 818)) %>%
  arrange(year) %>%
  group_by(extended_country_name, gwcode) %>%
  summarize(years = paste0(year, collapse = ", "))


# Okie doke.

Scores %>%
  mutate(gwcode = case_when(
    gwcode == 815 & year >= 1894 ~ NA_real_,
    extended_country_name == "Vietnam, Democratic Republic of" & year %in% c(1954:2020) ~ 816,
    extended_country_name == "Vietnam, Democratic Republic of" & year <= 1953 ~ NA_real_,
    extended_country_name == "Vietnam, Republic of" & year %in% c(1954:1975) ~ 817,
    extended_country_name == "Vietnam, Republic of" & year %in% c(1902:1953, 1976:2020) ~ NA_real_,
    TRUE ~ gwcode
  )) -> Scores

Scores %>%
  filter(gwcode %in% c(678, 679, 680)) %>%
  arrange(year) %>%
  group_by(extended_country_name, gwcode) %>%
  summarize(years = paste0(year, collapse = ", "))

# Not too bad. Gwcodes are right, I'm just going to be mindful of some dates.

Scores %>%
  mutate(gwcode = case_when(
    gwcode == 678 & year <= 1917 ~ NA_real_,
    gwcode == 680 & year %in% c(1967:1990) ~ 680,
    gwcode == 680 & year %in% c(1901:1966, 1991:2020) ~ NA_real_,
    TRUE ~ gwcode
  )) -> Scores

# please don't be difficult please don't be difficult please don't be difficult

Scores %>%
  filter(gwcode %in% c(340, 345)) %>%
  arrange(year) %>%
  group_by(extended_country_name, gwcode) %>%
  summarize(years = paste0(year, collapse = ", "))

# Not too bad.


Scores %>%
  mutate(gwcode = case_when(
    gwcode == 340 & year <= 1877 ~ NA_real_,
    gwcode == 340 & year %in% c(1878:1915, 2006:2020) ~ 340,
    gwcode == 340 & year %in% c(1918:1920) ~ 345,
    gwcode == 345 & year %in% c(1921:2006) ~ 345,
    TRUE ~ gwcode
  )) -> Scores


# Let's look for dups

quickuds_dups <- Scores %>%
  filter(!is.na(gwcode)) %>%
  group_by(gwcode, year) %>% filter(n() > 1) %>%
  arrange(gwcode, year) %>% print()

# The usual suspects here, and some with quite a lot of duplicates.
# The difficulty here is that, in most these cases, we won't know what to treat
# as a true value. We can be creative with the Serbia/Yugoslavia observations,
# but that's about it. A group_by slice will have to do

Scores %>%
  filter(!(extended_country_name == "Serbia" & year %in% c(1918, 1919, 1920))) %>%
  group_by(gwcode, year) %>%
  slice(1) -> Scores


Scores %>% ungroup() %>%
  select(gwcode, year, z1) %>%
  rename(xm_qudsest = z1) %>%
  left_join(gwcode_democracy, .)  %>% select(-statename) -> gwcode_democracy

save(gwcode_democracy, file="data/gwcode_democracy.rda")
