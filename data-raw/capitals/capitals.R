library(tidyverse)
library(tidygeocoder)


capitals <- read_csv("data-raw/capitals/capitals.csv")

capitals %>%
  # your standard geocoder wouldn't know a state like Baden or Two Sicilies from a hole in its head
  # It also won't know Czechoslovakia and won't care about the Yemen distinctions.
  mutate(alt_name = case_when(
    between(ccode, 240, 280) ~ "Germany",
    ccode %in% c(325, 327, 329, 332, 335, 337) ~ "Italy",
    ccode == 315 ~ "Czechia",
    ccode %in% c(678, 680) ~ "Yemen",
    TRUE ~ statenme
  )) %>%
  mutate(cap_state = paste0(capital, ", ", alt_name)) %>%
  # This will take a while. Geocoding is, as far as I know, time-consuming
  geocode(cap_state, method='osm', lat = lat, long = lng) %>%
  select(-alt_name, -cap_state) -> capitals

save(capitals, file="data/capitals.rda")





