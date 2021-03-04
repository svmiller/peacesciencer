library(tidyverse)

cow_trade_ndy <- read_csv("~/Dropbox/data/cow/trade/Dyadic_COW_4.0.csv") %>%
  # select just stuff that we want
  select(ccode1:year, flow1:smoothflow2) %>%
  # ^ for space considerations, I'm going to omit providing the smoothtotrade variable.
  # If you want that, add smoothflow1 + smoothflow2 together.
  # JUSTIFICATION: I have a lot of data I need to provide and only 5 MBs to do it.
  # remember the negative -9s.
  mutate_at(vars("flow1", "flow2", "smoothflow1", "smoothflow2"), ~ifelse(. == -9, NA, .))

#^ re: the above, recall: "flow1" is the value of imports in current million USD in ccode1 from ccode2
# For example, in 1920, CoW is saying the value of American imports that came from Canada is about 612 million USD.

# Okay, there's only so much slicing and hacking of these data I can do to compress the file size and I'm still getting
# about 3 MBs (after max compression). That's not really acceptable to me for the sake of keeping this under 5 MBs total.
# So, I think I'm going to save the file to an RDS and load it off my website.

saveRDS(cow_trade_ndy, file="data/cow_trade_ndy.rds")
# ^ I'm going to move this.
# http://svmiller.com/R/peacesciencer/cow_trade_ndy.rds

# save(cow_trade_ndy, file="data/cow_trade_ndy.rda")
# ^ I tried...

# I'mma try the DDY version now...

cow_trade_ndy %>%
  rename(ccode1 = ccode2,
         ccode2 = ccode1,
         flow1 = flow2,
         flow2 = flow1,
         smoothflow1 = smoothflow2,
         smoothflow2 = smoothflow1) %>%
  bind_rows(., cow_trade_ndy) ->cow_trade_ddy

saveRDS(cow_trade_ddy, file="~/Dropbox/svmiller.github.io/R/peacesciencer/cow_trade_ddy.rds")



cow_trade_sy <- read_csv("~/Dropbox/data/cow/trade/National_COW_4.0.csv") %>%
  # select just what we want
  select(ccode, year, imports, exports)

save(cow_trade_sy, file="data/cow_trade_sy.rda")
