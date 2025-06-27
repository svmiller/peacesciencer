library(tidyverse)
tss_rivalries <- readxl::read_excel("data-raw/tss_rivalries/tss_rivalries.xlsx")

# A few matters. Let's standardize the start dates
# "P1494" we'll just put at 1494
# "P1816" we'll just put at 1816
# "ongoing" we'll put at 2020
# This is not going to matter in, I'm sure, 100% of use cases.
# Everything is being benchmarked to cow system dates anyhow.
tss_rivalries %>%
  mutate(end = ifelse(end == "ongoing", 2020, as.numeric(end)),
         start = str_remove(start, "P"),
         start = as.numeric(start)) -> tss_rivalries

# I left a note in the spreadsheet to look into this vague Vietnam rivalries
# These would be the ones with China (1973-1991) and Cambodia (1970-1983).
# Briefly: the ambiguity about "Vietnam", and the start date, implies
# that it's possible South Vietnam was the rival and the North took it over
# when it took control of the South. Some archival research suggests:
#
# - the China one is very likely just North and not South too. It seems to
#   start when North Vietnam opens up the Paracel island area to foreign
#   oil exploration.
# - the Cambodia one is very likely just the North as well. It starts, it
#   seems with Lon Nol and it continued with Pol Pot and Vietnamese
#   consolidation with Pol Pot's suspicion that Vietnam had greater
#   territorial ambitions.

tss_rivalries %>%
  separate( rivalry, c("tss_sidea", "tss_sideb"), sep="-", remove=FALSE) %>%
  mutate(ccode_a = countrycode::countrycode(tss_sidea, "country.name", "cown"),
         # "Some values were not matched unambiguously: Austria (Hungary), Ottoman E, Prussia, Serbia"
         # ^ thank you daddy,
         ccode_a = case_when(
           tss_sidea == "Austria (Hungary)" ~ 300,
           tss_sidea == "Ottoman E" ~ 640,
           tss_sidea == "Prussia" ~ 255,
           tss_sidea == "Serbia" ~ 345,
           TRUE ~ ccode_a
         ),
         ccode_b = countrycode::countrycode(tss_sideb, "country.name", "cown"),
         # Some values were not matched unambiguously: Ottoman E, Prussia, Serbia, Venice
         ccode_b = case_when(
           tss_sideb == "Ottoman E" ~ 640,
           tss_sideb == "Prussia" ~ 255,
           tss_sideb == "Serbia" ~ 345,
           # In a previous version of this rivalry, I created a ccode for Venice just to create one
           # I'll never use it; you likely won't either. But, FYI
           tss_sideb == "Venice" ~ 324,
           TRUE ~ ccode_b
         )) %>%
  mutate(ccode1 = ifelse(ccode_a > ccode_b, ccode_b, ccode_a),
         ccode2 = ifelse(ccode_a > ccode_b, ccode_a, ccode_b)) %>%
  mutate(tssr_id = 1:n()) %>%
  select(tssr_id, rivalry, ccode1, ccode2, start:aprin) -> tss_rivalries

# This is by way of Thompson et al. (p. 36), but this is assuredly what they meant.
tss_rivalries %>%
  mutate(end = ifelse(tssr_id == 61, 1955, end)) -> tss_rivalries

# Oops. Should've caught this earlier.

tss_rivalries %>%
  mutate(ccode1 = ifelse(tssr_id == 117, 260, ccode1),
         ccode2 = ifelse(tssr_id == 117, 265, ccode2),
         ccode1 = ifelse(tssr_id == 122, 816, ccode1),
         ccode2 = ifelse(tssr_id == 122, 817, ccode2),
         ccode2 = ifelse(tssr_id == 161, 816, ccode2),
         ccode2 = ifelse(tssr_id == 126, 817, ccode2),
         ccode1 = ifelse(tssr_id == 159, 678, ccode1),
         ccode2 = ifelse(tssr_id == 159, 680, ccode2)) -> tss_rivalries #%>% #filter(tssr_id == 117)

save(tss_rivalries, file="data/tss_rivalries.rda")
