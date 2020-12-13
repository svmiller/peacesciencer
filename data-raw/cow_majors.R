library(tidyverse)
cow_majors <- read_csv("~/Dropbox/data/cow/states/majors2016.csv")

cow_majors %>% select(-stateabb) -> cow_majors

save(cow_majors, file="data/cow_majors.rda")
