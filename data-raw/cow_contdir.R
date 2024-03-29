library(tidyverse)

haven::read_dta("~/Dropbox/data/cow/contiguity/3.2/contdir.dta") %>%
  select(statelno, statehno, conttype, begin, end) %>%
  rename(ccode1 = statelno,
         ccode2 = statehno) -> cow_contdir

cow_contdir %>%
  rename(ccode1 = ccode2,
         ccode2 = ccode1) %>%
  bind_rows(cow_contdir, .) -> cow_contdir

save(cow_contdir, file="data/cow_contdir.rda")


# cow_contdir %>%
#   mutate(styear = as.numeric(str_sub(begin, 1, 4)),
#          endyear = as.numeric(str_sub(end, 1, 4))) %>%
#   rowwise() %>%
#   mutate(year = list(seq(styear, endyear))) %>%
#   unnest(year)
