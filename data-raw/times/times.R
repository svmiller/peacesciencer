library(tidyverse)
library(peacesciencer)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
library(tictoc)
tic.clearlog()

Times <- list()

for (x in 1:100) {
  # passing x to tic() makes it a label at time of the matching toc() call.
  tic(x)
  create_statedays()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_statedays()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))


tic.clearlog()

for (x in 1:100) {
  tic(x)
  create_stateyears()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_stateyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))


tic.clearlog()

for (x in 1:100) {
  tic(x)
  create_dyadyears()
  gc()
  toc(log = TRUE, quiet = TRUE)
}

Times$"create_dyadyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))

saveRDS(Times, "~/Dropbox/projects/peacesciencer/data-raw/times/Times.rds")
