library(tidyverse)

gml_dirdisp <- read_csv("~/Dropbox/projects/mid-project/gml-mid-data/2.2.1/gml-ddy-disputes-2.2.1.csv")

attr(gml_dirdisp, "ps_data_type") = "dyad_year"
attr(gml_dirdisp, "ps_system") = "cow"
attr(gml_dirdisp, "ps_conflict_type") = "gml"

save(gml_dirdisp, file="data/gml_dirdisp.rda")
