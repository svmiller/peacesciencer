library(tidyverse)
library(peacesciencer)
library(microbenchmark)

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# Create some data ----


create_bench <- microbenchmark::microbenchmark(
  `create_statedays()` = create_statedays(),
  `create_stateyears()` = create_stateyears(),
  `create_dyadyears()` = create_dyadyears(),
  unit = "s",
  times = 100)

saveRDS(create_bench, "~/Dropbox/projects/peacesciencer/data-raw/times/create_bench.rds")

# https://stackoverflow.com/questions/10893611/storing-tic-toc-values-in-r
# library(tictoc)
# tic.clearlog()
#
# # Create Times list ----
# create_times <- list()
#
#
#
# # * create_statedays() -----
# for (x in 1:100) {
#   # passing x to tic() makes it a label at time of the matching toc() call.
#   tic(x)
#   create_statedays()
#   gc()
#   toc(log = TRUE, quiet = TRUE)
# }
#
# create_times$"create_statedays()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
# tic.clearlog()
#
# # * create_stateyears() -----
#
# for (x in 1:100) {
#   tic(x)
#   create_stateyears()
#   gc()
#   toc(log = TRUE, quiet = TRUE)
# }
#
# create_times$"create_stateyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
# tic.clearlog()
#
# # * create_dyadyears() -----
#
# for (x in 1:100) {
#   tic(x)
#   create_dyadyears()
#   gc()
#   toc(log = TRUE, quiet = TRUE)
# }
#
# create_times$"create_dyadyears()" <- tibble(x = unlist(lapply(tic.log(format = FALSE), function(x) x$toc - x$tic)))
# tic.clearlog()
#
# saveRDS(create_times, "~/Dropbox/projects/peacesciencer/data-raw/times/create_times.rds")
