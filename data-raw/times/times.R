library(tidyverse)
library(peacesciencer)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
library(tictoc)
tic.clearlog()

# Create Times list ----
Times <- list()

# * create_statedays() -----
for (x in 1:100) {
  # passing x to tic() makes it a label at time of the matching toc() call.
  tic(x)
  create_statedays()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_statedays()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * create_stateyears() -----

for (x in 1:100) {
  tic(x)
  create_stateyears()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_stateyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * create_dyadyears() -----

for (x in 1:100) {
  tic(x)
  create_dyadyears()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_dyadyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * add_gml_mids(keep=NULL) -----

for (x in 1:100) {
  tic(x)
  cow_ddy %>% add_gml_mids(keep = NULL)
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"add_gml_mids(keep=NULL)" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * add_peace_years() (dyadic, GML) -----

cow_ddy %>% add_gml_mids(keep = NULL) -> Data

for (x in 1:100) {
  tic(x)
  Data %>% add_peace_years()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"add_peace_years() (dyadic, GML)" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * add_peace_years() (state, GW) -----

rm(Data)

create_stateyears(system='gw') %>% add_ucdp_acd() -> Data

for (x in 1:100) {
  tic(x)
  Data %>% add_peace_years()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"add_peace_years() (state, GW)" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

# * add_peace_years() (state, CoW [intra]) -----

rm(Data)

create_stateyears(system='cow') %>% add_cow_wars(type='intra') -> Data

for (x in 1:100) {
  tic(x)
  Data %>% add_peace_years()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"add_peace_years() (state, CoW [intra])" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
tic.clearlog()

saveRDS(Times, "~/Dropbox/projects/peacesciencer/data-raw/times/Times.rds")
