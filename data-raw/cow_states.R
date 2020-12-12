library(tidyverse)
cow_states <- read_csv("~/Dropbox/data/cow/states/states2016.csv")

save(cow_states, file="data/cow_states.rda")
