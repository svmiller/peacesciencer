library(bib2df)
library(tidyverse)

ps_bib <- bib2df("~/Dropbox/projects/peacesciencer/data-raw/bib/ps_bib.bib") %>% filter(CATEGORY != "COMMENT")

# I'm going to have to do this iteratively, methinks...

ps_bib %>% mutate_if(is.character,
                     list(enc = ~stringi::stri_enc_isascii(.))) %>%
  select(CATEGORY_enc:ncol(.)) %>%
  summary
# ^ I think I got it...

save(ps_bib, file="data/ps_bib.rda")

#df2bib(ps_bib)
#
#ps_cite <- function(x) {
#
#  ps_bib %>% filter(grepl(x, KEYWORDS)) %>% df2bib()
#
#}
#
#
#ps_cite("alliance") # do a partial match
#ps_cite("add_archigos()") # do an exact match
