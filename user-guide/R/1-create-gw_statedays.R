library(tidyverse)
library(peacesciencer)

create_statedays(system = 'gw') -> gw_statedays

saveRDS(gw_statedays, "data/gw_statedays.rds")
