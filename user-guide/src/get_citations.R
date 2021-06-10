
if_not_install <- function(packages) {
  new_pack <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_pack)) install.packages(new_pack)
}

if_not_install(c("stringr", "dplyr", "magrittr",
                 "rmarkdown", "bib2df"))


library(stringr)
library(dplyr)
library(magrittr)
library(rmarkdown)
library(bib2df)

doc <- readLines("ms.Rmd")
the_entry <- yaml_front_matter("ms.Rmd")$bibliography

read_bib <- function(x) {
  if(str_starts(x, "`r ") == TRUE) {
    ht <- str_remove_all(the_entry, "`")
    ht <- str_remove(ht, "r ")

    ht <- bib2df(eval(parse(text=ht)))
    return(ht)
  } else {
    ht <- bib2df(the_entry)
    return(ht)
  }
}

the_bib <- read_bib(the_entry)


cites <- c()

for(i in 1:length(doc)) {
  hold_this <- as.data.frame(str_match_all(doc[i], "@([[:alnum:]:&!~=_+-]+)")[[1]])
  cites <- bind_rows(cites, hold_this)
}

cites %>% select(-V1) -> cites

cites %>%
  rename(BIBTEXKEY = V2) %>%
  left_join(., the_bib) %>%
  distinct(BIBTEXKEY, .keep_all = TRUE) %>%
  # For now, this will tease out those wrong matches from the YAML or truly anything else
  # It assumes, hopefully, you don't have a "gmail" entry in your .bib file or something to that effect
  # In this application, that's where that's happening.
  filter(!is.na(CATEGORY)) %>%
  bib2df::df2bib(., file = "inst/refs.bib")
