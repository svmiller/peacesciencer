library(tidyverse)


ps_data_version <- readxl::read_excel(("~/Dropbox/projects/peacesciencer/data-raw/ps_data_version/ps_data_version.xlsx"))


save(ps_data_version, file="data/ps_data_version.rda")
