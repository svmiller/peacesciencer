# https://github.com/cran/cshapes/tree/master/R
# ^ look here in order to steal code.

library(tidyverse)
library(stevemisc)
library(peacesciencer)
library(foreach)
library(tictoc)

## Get polygons, stealing some code from {cshapes}

cshp.full <- geojsonio::topojson_read("~/Dropbox/data/cshapes/cshapes_2_gw.topojson")
cs.cols <- c("gwcode", "cowcode", "country_name", "start", "end", "status",
             "owner", "capname", "caplong", "caplat", "b_def", "fid", "geometry")
cshp.full <- cshp.full[,names(cshp.full) %in% cs.cols]
cshp.part <- cshp.full[cshp.full$status == "independent",]

# Identify change dates
change_dates <- cshp.part %>% distinct(start) %>% arrange(start) %>% pull(start)

# Set up cores...
half_cores  <- parallel::detectCores()/2

my.cluster <- parallel::makeCluster(
  half_cores,
  type = "PSOCK"
)

doParallel::registerDoParallel(cl = half_cores)
foreach::getDoParRegistered()

# Let's create a list of data frames, for each change date
tic()
Data <- foreach(
  i = change_dates
) %dopar% {

  # Code basically stolen from {cshapes}
  cshp.part %>%
    filter(as.Date(start) <= as.Date(i) & as.Date(end) >= as.Date(i))

}
toc()

tic()
lapply(Data, function(x) rmapshaper::ms_simplify(x, keep_shapes = T, keep=0.1, method = "dp", snap = T) ) -> Data2
toc()

# Here's where the fun stuff happens.
tic()
gw_mindist_list <- foreach(
  i = Data2
) %dopar% {
  # Stole this part from {cshapes}
  #ms_simplify(i, keep_shapes = T, keep=0.1, method = "dp", snap = T) -> cshp.simple

  # Let's do it my way now. First, expand grid
  i %>% expand(gwcode1 = gwcode, gwcode2 = gwcode) -> hold_this

  # Create a tibble with the geometries
  hold_this %>%
    left_join(., i %>% select(gwcode, geometry), by=c("gwcode1"="gwcode")) %>%
    rename(geometry1 = geometry) %>%
    left_join(., i %>% select(gwcode, geometry), by=c("gwcode2"="gwcode")) %>%
    rename(geometry2 = geometry) -> hold_this

  # For ease/speed, let's make it non-directed, and eliminate same-state dyads.
  hold_this %>% filter(gwcode2 > gwcode1) -> hold_this

  # pmap here is a godsend. It will take code partially stolen from {cshapes} and apply it to all dyadic geometries.
  the_distances <- pmap_dfr(hold_this, ~data.frame(mindist = suppressMessages(min(sp::spDists(suppressMessages(sf::st_coordinates(..3)[,c("X", "Y")]),
                                                                                        suppressMessages(sf::st_coordinates(..4)[,c("X", "Y")]), longlat=TRUE))))  )


  # Let's just grab what we want and go.
  hold_this <- bind_cols(hold_this %>% select(gwcode1, gwcode2), the_distances) %>% as_tibble()


}
toc()

# Get our change dates back, as list/data frame names
names(gw_mindist_list) <- change_dates


parallel::stopCluster(cl = my.cluster) # close our clusters

# {purrr} again to the rescue...
purrr::imap(gw_mindist_list, ~mutate(.x, change_date = .y)) %>%
  bind_rows() %>%
  mutate(change_date = as.Date(change_date),
         date = change_date) %>%
  mutate(year = as.integer(lubridate::year(change_date))) -> gw_mindist_alt

# What years didn't have a change date? Let's find out.
# gw_mindist_alt %>% distinct(year) %>% arrange(year) %>% pull(year) -> years_covered
#c(1886:2019) -> must_have_years

# must_have_years[must_have_years %nin% years_covered] -> missing_years

tibble(x = change_dates) %>%
  filter(lubridate::month(x) == 1 & lubridate::day(x) == 1) %>% pull(x) -> jan1_days

# No Dec. 31 days...
tibble(x = change_dates) %>%
  filter(lubridate::month(x) == 12 & lubridate::day(x) == 31) %>% pull(x)


# Exactly one June 30 day...
tibble(x = change_dates) %>%
  filter(lubridate::month(x) == 6 & lubridate::day(x) == 30) %>% pull(x) -> june30_days


replicate(3, gw_ddy %>% filter(between(year, 1886, 2019)), simplify=FALSE) -> lst_gw_ddy


lst_gw_ddy[[1]] %>%
  filter(gwcode2 > gwcode1) %>%
  mutate(date = as.Date(paste0(year, "/01/01"))) %>%
  filter(date %nin% jan1_days) -> lst_gw_ddy[[1]]

lst_gw_ddy[[2]] %>%
  filter(gwcode2 > gwcode1) %>%
  mutate(date = as.Date(paste0(year, "/06/30"))) %>%
  filter(date %nin% june30_days) -> lst_gw_ddy[[2]]


lst_gw_ddy[[3]] %>%
  filter(gwcode2 > gwcode1) %>%
  mutate(date = as.Date(paste0(year, "/12/31"))) -> lst_gw_ddy[[3]]


bind_rows(lst_gw_ddy) %>%
  bind_rows(gw_mindist_alt, .) %>%
  arrange(gwcode1, gwcode2, date) -> hold_this


create_statedays(system = "gw") %>%
  mutate(in_system1 = 1) %>%
  rename(gwcode1 = gwcode) %>%
  select(gwcode1, date, in_system1) %>%
  left_join(hold_this, .) -> hold_this


create_statedays(system = "gw") %>%
  mutate(in_system2 = 1) %>%
  rename(gwcode2 = gwcode) %>%
  select(gwcode2, date, in_system2) %>%
  left_join(hold_this, .) -> hold_this


hold_this %>% mutate(remove_me = case_when(
  is.na(in_system1) ~ 1,
  is.na(in_system2) ~ 1,
  TRUE ~ 0
)) %>% filter(remove_me == 0) -> hold_this


hold_this %>%
  arrange(gwcode1, gwcode2, date) %>%
  group_by(gwcode1, gwcode2) %>%
  fill(mindist) %>%
  ungroup() %>%
  select(gwcode1, gwcode2, year, date, change_date, mindist) -> gw_mindist_plus


saveRDS(gw_mindist_plus, "~/Dropbox/svmiller.github.io/R/peacesciencer/gw_mindist_plus.rds")
