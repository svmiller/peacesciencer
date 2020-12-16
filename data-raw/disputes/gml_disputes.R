library(tidyverse)

gml_dirdisp <- read_csv("data-raw/disputes/gml-ddy-disputes-2.1.1.csv")


save(gml_dirdisp, file="data/gml_dirdisp.rda")
