library(tidyverse)
library(tidygeocoder)


capitals <- read_csv("data-raw/capitals/capitals.csv")

# Up first: CoW
capitals %>%
  filter(!is.na(ccode)) %>%
  select(-gwcode) %>%
  # your standard geocoder wouldn't know a state like Baden or Two Sicilies from a hole in its head
  # It also won't know Czechoslovakia and won't care about the Yemen distinctions.
  mutate(alt_name = case_when(
    between(ccode, 240, 280) ~ "Germany",
    ccode %in% c(325, 327, 329, 332, 335, 337) ~ "Italy",
    ccode == 315 ~ "Czechia",
    ccode %in% c(678, 680) ~ "Yemen",
    ccode == 781 ~ "Maldives",
    TRUE ~ statenme
  )) %>%
  mutate(cap_state = paste0(capital, ", ", alt_name)) %>%
  # This will take a while. Geocoding is, as far as I know, time-consuming
  geocode(cap_state, method='osm', lat = lat, long = lng) %>%
  select(-alt_name, -cap_state) -> cow_capitals

save(cow_capitals, file="data/cow_capitals.rda")

# G-W next...

capitals %>%
  filter(!is.na(gwcode)) %>%
  select(-ccode) %>%
  # your standard geocoder wouldn't know a state like Baden or Two Sicilies from a hole in its head
  # It also won't know Czechoslovakia and won't care about the Yemen distinctions.
  mutate(alt_name = case_when(
    between(gwcode, 240, 280) ~ "Germany",
    gwcode %in% c(325, 327, 329, 332, 335, 337) ~ "Italy",
    gwcode == 315 ~ "Czechia",
    gwcode %in% c(678, 680) ~ "Yemen",
    gwcode %in% c(563, 564) ~ "South Africa",
    gwcode == 89 & styear == 1816 ~ "Guatemala",
    gwcode == 89 & styear == 1834 ~ "El Salvador",
    gwcode == 99 ~ "Colombia",
    gwcode %in% c(563, 564) ~ "South Africa",
    gwcode == 711 ~ "China",
    gwcode == 815 ~ "Vietnam",
    gwcode == 781 ~ "Maldives",
    TRUE ~ statenme
  )) %>%
  mutate(cap_state = paste0(capital, ", ", alt_name)) %>%
  # This will take a while. Geocoding is, as far as I know, time-consuming
  geocode(cap_state, method='osm', lat = lat, long = lng) %>%
  select(-alt_name, -cap_state) -> gw_capitals

save(gw_capitals, file="data/gw_capitals.rda")
