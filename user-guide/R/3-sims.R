# Libraries first
library(stevemisc)
# library(tidyverse)
library(modelr)

# Load stuff
Mods <- readRDS("user-guide/data/Mods.rds")
Data <- readRDS("user-guide/data/Data.rds")

# in {tidyverse}
# Data %>%
#   data_grid(lrscale = unique(lrscale), .model = Mods[[1]],
#             immigsent = 0) %>% na.omit -> newdat


Sims <- list()

na.omit(data_grid(Data, lrscale = unique(lrscale), .model = Mods[[1]], immigsent = 0)) -> newdat

Sims$"SQI (Ideology)" <- get_sims(Mods[[1]], newdat = newdat, 1000, 8675309)

Sims[[1]]$lrscale <- rep(seq(0:10), 1000)



# in {tidyverse}
# newdat %>%
#   # repeat this data frame how many times we did simulations
#   dplyr::slice(rep(row_number(), 1000)) %>%
#   bind_cols(get_sims(Mods[[1]], newdata = newdat, 1000, 8675309), .) -> Sims$"SQI (Ideology)"

saveRDS(Sims, "user-guide/data/Sims.rds")
