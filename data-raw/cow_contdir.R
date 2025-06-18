library(tidyverse)

haven::read_dta("~/Koofr/data/cow/contiguity/3.2/contdir.dta") %>%
  select(statelno, statehno, conttype, begin, end) %>%
  rename(ccode1 = statelno,
         ccode2 = statehno) -> cow_contdir

cow_contdir %>%
  rename(ccode1 = ccode2,
         ccode2 = ccode1) %>%
  bind_rows(cow_contdir, .) -> cow_contdir

cow_contdir %>%
  mutate(stdate = as.Date(paste0(str_sub(.data$begin, 1, 4),"-", str_sub(.data$begin, 5, 6), "-01")),
         enddate = as.Date(paste0(str_sub(.data$end, 1, 4),"-", str_sub(.data$end, 5, 6), "-01"))) %>%
  select(-begin, -end) -> cow_contdir

# Okay, I need to get creative here. The problem here is that there are pertinent
# dyads that have a contiguity relationship of some kind at some point (and thus
# are int hese data) but also potentially have no contiguity relationship prior
# to their entry into these data. There are ample states that have no contiguity
# relationship whatsoever (e.g. Sweden-Botswana) that I can ignore. There are
# some entries here that I assuredly can't and shouldn't ignore.

cow_contdir %>%
  distinct(ccode1, ccode2) -> dyads_to_consider

dyads_to_consider

isard::cw_system %>%
  rowwise() %>%
  mutate(date = list(seq(start, end, by = '1 day'))) %>%
  select(ccode, date) %>%
  unnest(date) %>%
  group_by(ccode) %>%
  summarize(date = list(date), .groups = "drop") %>%
  rename(ccode1 = ccode,
         date1 = date) %>%
  left_join(dyads_to_consider, .) -> first_one


isard::cw_system %>%
  rowwise() %>%
  mutate(date = list(seq(start, end, by = '1 day'))) %>%
  select(ccode, date) %>%
  unnest(date) %>%
  group_by(ccode) %>%
  summarize(date = list(date), .groups = "drop") %>%
  rename(ccode2 = ccode,
         date2 = date) %>%
  left_join(first_one, .)  %>%
  # hate having to do it this way, but who doesn't love the UNIX epoch...
  mutate(date = map2(date1, date2, ~ as.Date(intersect(.x, .y),
                                              origin = "1970-01-01"))) %>%
  select(ccode1, ccode2, date) -> okiedoke

okiedoke %>%
  unnest(date) %>%
  mutate(year = year(date),
         month = month(date)) %>%
  distinct(ccode1, ccode2, year, month) -> okiedokey

okiedokey %>%
  mutate(date = as.Date(paste0(year,"-", month, "-01"))) -> okiedokey

cow_contdir %>%
  rowwise() %>%
  mutate(date = list(seq(stdate, enddate, by = '1 month'))) %>%
  unnest(date) %>%
  select(ccode1, ccode2, conttype, date) %>%
  left_join(okiedokey, .) -> okay_one_more

okay_one_more %>%
  mutate(conttype = ifelse(is.na(conttype), 0, conttype)) %>%
  arrange(ccode1, ccode2, date) %>%
  mutate(stdate = first(date),
         enddate = last(date),
         .by =c(ccode1, ccode2, conttype)) %>%
  #ungroup() %>%
  slice(1, .by=c(ccode1, ccode2, conttype, stdate, enddate)) %>%
  #select(ccode1, ccode2, conttype, stdate, enddate) -> cow_contdir
  # test cases of interest...
  #filter(ccode1 %in% c(210, 220) & ccode2 %in% c(210, 220)) %>%
  #filter(ccode1 %in% c(710, 740) & ccode2 %in% c(710, 740)) %>%
  # ^ I am so intensely suspicious of this, but it's in the data...
  #   I'm not in trouble at all... https://www.youtube.com/watch?v=K0OSfbPJFa4
  #filter(ccode1 %in% c(820, 840) & ccode2 %in% c(840, 820)) # yep...
  filter(conttype == 0) %>%
  select(ccode1, ccode2, conttype, stdate, enddate) %>%
  # this is ultimately what I want and I'm treating the other stuff as gospel
  bind_rows(cow_contdir, .) %>%
  arrange(ccode1, ccode2, stdate) -> hold_this

# do some more test cases... seems legit..
hold_this %>%
  filter(conttype == 0)

cow_contdir <- hold_this


  # arrange(ccode1, ccode2, year, month) %>%
  # mutate(lag_end = lag(enddate), .by=c(ccode1, ccode2)) %>%
  # filter(ccode1 == 210 & ccode2 == 220)
  # filter(stdate == lag_end)
  # filter(ccode1 == 710 & ccode2 == 740)
  # full_join(cow_contdir, .) %>%
  # filter(ccode2 > ccode1) %>%
  # group_split(ccode1, ccode2)


# Okay, this reveals an interesting quirk about the contiguity data. There are
# relationships recorded in the contiguity data (e.g. Palau, FSM) for when they
# weren't states. For example, the contiguity relationship between those two
# starts in Nov. 1994, but there was no Palau in the system data until Dec. 15,
# 1994. However, this does seem to be capturing what I wanted. For example, the
# Malaysia-Philippines (820-840) dyads had been around since 1957. Yet, no
# contiguity record exists in the data until Sept. 1963. If I had not done this,
# I would've missed that CoW says that dyad starts 1963 without a contiguity
# relationship.



save(cow_contdir, file="data/cow_contdir.rda")


# cow_contdir %>%
#   mutate(styear = as.numeric(str_sub(begin, 1, 4)),
#          endyear = as.numeric(str_sub(end, 1, 4))) %>%
#   rowwise() %>%
#   mutate(year = list(seq(styear, endyear))) %>%
#   unnest(year)
