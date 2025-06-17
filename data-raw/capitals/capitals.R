library(tidyverse)
library(tidygeocoder)


# capitals <- read_csv("data-raw/capitals/capitals.csv")
#
# # This might require a periodic update...
# capitals %>%
#   mutate(endyear = ifelse(endyear == 2020, 2024, endyear)) -> capitals

readxl::read_excel("data-raw/capitals/capitals.xlsx", sheet = 1) %>%
#  select(styear, stmon, stday) %>%
  mutate(stdate = ymd(paste0(styear,"-",stmon,"-",stday)),
         enddate = ymd(paste0(endyear,"-",endmon,"-",endday))) %>%
  select(ccode:capital, stdate, enddate) -> capitals


# Up first: CoW
capitals %>%
  filter(!is.na(ccode)) %>%
  select(-gwcode) %>%
  # your standard geocoder wouldn't know a state like Baden or Two Sicilies from a hole in its head
  # It also won't know Czechoslovakia and won't care about the Yemen distinctions.
  mutate(alt_name = case_when(
    between(ccode, 240, 280) ~ "Germany",
    ccode == 300 ~ "Austria", # boo...
    ccode == 235 & capital == "Rio de Janeiro" ~ "Brazil", # wow...
    ccode %in% c(325, 327, 329, 332, 335, 337) ~ "Italy",
    ccode == 315 ~ "Czechia",
    ccode %in% c(678, 680) ~ "Yemen",
    ccode == 781 ~ "Maldives",
    ccode == 817 ~ "Vietnam",
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
    gwcode == 300 ~ "Austria", # boo...
    gwcode == 235 & capital == "Rio de Janeiro" ~ "Brazil", # wow...
    gwcode %in% c(325, 327, 329, 332, 335, 337) ~ "Italy",
    gwcode == 315 ~ "Czechia",
    gwcode %in% c(678, 680) ~ "Yemen",
    gwcode %in% c(563, 564) ~ "South Africa",
    gwcode == 89 & year(stdate) == 1823 ~ "Guatemala",
    gwcode == 89 & year(stdate) == 1833 ~ "El Salvador",
    gwcode == 89 & year(stdate) == 1834 ~ "El Salvador",
    gwcode == 99 ~ "Colombia",
    gwcode %in% c(563, 564) ~ "South Africa",
    gwcode == 711 ~ "China",
    gwcode %in% c(815, 817) ~ "Vietnam",
    gwcode == 781 ~ "Maldives",
    TRUE ~ statenme
  )) %>%
  mutate(cap_state = paste0(capital, ", ", alt_name)) %>%
  # This will take a while. Geocoding is, as far as I know, time-consuming
  geocode(cap_state, method='osm', lat = lat, long = lng) %>%
  select(-alt_name, -cap_state) -> gw_capitals

save(gw_capitals, file="data/gw_capitals.rda")
