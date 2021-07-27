# Note: I wrote the bulk of this as a script for an earlier analysis (for my CMPS, I believe) on Apr. 3, 2016.
# This is kind of ugly code by Steve standards, but it works so I'm going to keep it as is.

# I'll break it up to two parts. First, we'll do CoW. Then: GW.
# Note: I'm generally a fan of doing things as they were at the start of the year. However, capitals and distance
# are kind of time-invariant and I want to get maximum coverage here. Thus, I'll have end-of-year dates here.
library(tidyverse)

# library(cshapes)
# library(sqldf)
#
# # Correlates of War first. ----
#
# # Options
# gw <- FALSE
# disttype <- "mindist"
#
# # First run
# result <- distlist(as.Date("1946-12-31"), type=disttype, useGW=gw)
# result <- result[result$ccode1 != result$ccode2,] # drop duplicate dyads
# result$year <- 1946
#
# # Do something else for like an hour...
# for (year in 1947:2015) {
#   date.current <- paste(year, "12", "31", sep="-")
#   result.current <- distlist(as.Date(date.current), type=disttype, useGW=gw)
#   result.current <- result.current[result.current$ccode1 != result.current$ccode2,]
#   result.current$year <- year
#   result <- rbind(result, result.current)
# }
#
#
#
# Mindist <- result[order(result$ccode1, result$ccode2),]
#
# # The stragglers are: Syria (652, 1958), Zanzibar (511, 1964), Comoros (581, 1975), South Vietnam (817, 1975),
# # West Germany (260, 1990), East Germany (265, 1990), YAR (678, 1990), YPR (680, 1990)
#
# # Get Syria, 1958
# result <- distlist(as.Date("1958-01-01"), type=disttype, useGW=gw)
# syria58 <- sqldf("select * from result where (ccode1 == 652 OR ccode2 == 652) AND (ccode1 != ccode2)")
# syria58$year <- 1958
#
# Mindist <- rbind(Mindist, syria58)
#
# # Get Zanzibar, 1964
# result <- distlist(as.Date("1964-01-01"), type=disttype, useGW=gw)
# zan64 <- sqldf("select * from result where (ccode1 == 511 OR ccode2 == 511) AND (ccode1 != ccode2)")
# zan64$year <- 1964
#
# Mindist <- rbind(Mindist, zan64)
#
# # Get Comoros and South Vietnam, 1975
# # result <- distlist(as.Date("1975-12-31"), type=disttype, useGW=gw)
# # com75 <- sqldf("select * from result where (ccode1 == 581 OR ccode2 == 581) AND (ccode1 != ccode2)")
# # com75$year <- 1975
#
# result <- distlist(as.Date("1975-01-01"), type=disttype, useGW=gw)
# rov75 <- sqldf("select * from result where (ccode1 == 817 OR ccode2 == 817) AND (ccode1 != ccode2)")
# rov75$year <- 1975
#
# Mindist <- rbind(Mindist, rov75)
#
# # Get GFR, GDR, YAR, and YPR in 1990.
# result <- distlist(as.Date("1990-10-01"), type=disttype, useGW=gw)
#
# gfr90 <- sqldf("select * from result where (ccode1 == 260 OR ccode2 == 260) AND (ccode1 != ccode2)")
# gfr90$year <- 1990
#
# gdr90 <- sqldf("select * from result where (ccode1 == 265 OR ccode2 == 265) AND (ccode1 != ccode2)")
# gdr90$year <- 1990
#
# result <- distlist(as.Date("1990-01-01"), type=disttype, useGW=gw)
#
# yar90 <- sqldf("select * from result where (ccode1 == 678 OR ccode2 == 678) AND (ccode1 != ccode2)")
# yar90$year <- 1990
#
# ypr90 <- sqldf("select * from result where (ccode1 == 680 OR ccode2 == 680) AND (ccode1 != ccode2)")
# ypr90$year <- 1990
#
# Mindist <- rbind(Mindist, gfr90, gdr90, yar90, ypr90)
#
# # Of the missing observations remaining, only Namibia shares a temporal overlap with YPR and YAR.
# # However, those are politically irrelevant pairings and I'll ignore them.
# # At some level, there's only so much I can do/should do with data like these. If you insist on having that
# # Namibia-YPR dyad, you've got explaining to do elsewhere.
#
# # Here's new stuff I'm adding beyond what I did for my 2017 CMPS:
# cow_mindist <- Mindist %>% as_tibble()
#
# # I'm anticipating two issues with what remains.
# # First: there's going to be some odd-ball duplicates in 1990 for W and E Germany. Same for the two Yemens.
# # Those are the only ones, though. The mindists are identical, so we're just going to group-by-slice them.
#
# # Second, this file weirdly saves at such a large size and I really don't know why.
# # So, we're going to save these as non-directed dyad-years.
#
# cow_mindist %>%
#   group_by(ccode1, ccode2, year) %>%
#   slice(1) %>% ungroup() %>% filter(ccode2 > ccode1) -> cow_mindist
#
# save(cow_mindist, file="data/cow_mindist.rda")
#
#
# # GW now... -----
# # For what it's worth, I have some misgivings these data are behaving as they're supposed to behave here.
# # Consider: in 1946, there should be a Tibet (ccode|ccode == 711), but there isn't.
# # If there's one recurring theme to this package, it's that I'm encouraging more use of the CoW state system than the GW system.
# # So, here's what I'm going to do. The extent to which the package authors swear this is going to return GW codes, I'm
# # going to leave them "as is" with a bit of a caveat emptor.
#
# gw <- TRUE
#
# # First run
# result <- distlist(as.Date("1948-12-31"), type=disttype, useGW=TRUE)
# result <- result[result$ccode1 != result$ccode2,] # drop duplicate dyads
# result$year <- 1946
#
# for (year in 1947:2015) {
#   date.current <- paste(year, "12", "31", sep="-")
#   result.current <- distlist(as.Date(date.current), type=disttype, useGW=TRUE)
#   result.current <- result.current[result.current$ccode1 != result.current$ccode2,]
#   result.current$year <- year
#   result <- rbind(result, result.current)
# }
#
# result %>% as_tibble() %>%
#   dplyr::arrange(ccode1, ccode2) %>%
#   dplyr::rename(gwcode1 = ccode1,
#          gwcode2 = ccode2) -> gw_mindist
#
# # Let's make this non-directed for space considerations
#
# gw_mindist %>%
#   filter(gwcode2 > gwcode1)  -> gw_mindist
#
# save(gw_mindist, file="data/gw_mindist.rda")
#

# This is version 2.0 now -----

read_csv("~/Dropbox/data/cshapes/cshapes_2.0_dist_COW.csv") %>%
  select(ccode1, ccode2, year, mindist) %>%
  filter(ccode1 != ccode2) %>%
  filter(ccode2 > ccode1) -> cow_mindist

save(cow_mindist, file="data/cow_mindist.rda")

# FYI: the data were already prepared with "ccode" as the country code. We want gwcode
read_csv("~/Dropbox/data/cshapes/cshapes_2.0_dist_GW.csv") %>%
  select(ccode1, ccode2, year, mindist) %>%
  filter(ccode1 != ccode2) %>%
  filter(ccode2 > ccode1) %>%
  rename(gwcode1 = ccode1,
         gwcode2 = ccode2) -> gw_mindist

save(gw_mindist, file="data/gw_mindist.rda")
