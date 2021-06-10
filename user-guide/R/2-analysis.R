Data <- readRDS("user-guide/data/Data.rds")

Mods <- list()

Mods$"Default" <- lm(immigsent ~ agea + female + eduyrs + uempla + hinctnta + lrscale, data=Data)
Mods$"Default + Noise" <- lm(immigsent ~ agea + female + eduyrs + uempla + hinctnta + lrscale + noise, data=Data)

saveRDS(Mods, "user-guide/data/Mods.rds")
