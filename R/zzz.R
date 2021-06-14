# CRAN Note avoidance. I hate this check.
# Inspiration: https://github.com/HughParsonage/grattan/blob/master/R/zzz.R
# Also:
if(getRversion() >= "2.15.1")
  utils::globalVariables(
    # underlying data used for behind-the-scenes handsomeness
    c("capitals", "ccode_democracy", "cow_alliance", "cow_contdir",
      "cow_ddy", "cow_gw_years", "cow_majors", "cow_states",
      "gml_dirdisp", "gw_ddy", "gw_states", "maoz_powers", "cow_nmc",
      "cow_igo_ndy", "cow_igo_sy", "cow_trade_sy", "gw_mindist", "cow_mindist",
      "archigos", "atop_alliance", "gw_sdp_gdp", "cow_sdp_gdp", "ucdp_onsets",
      "ucdp_acd", "cow_mid_dirdisps", "cow_mid_disps", "cow_mid_ddydisps",
      "gml_mid_ddydisps", "td_rivalries", "gw_cow_years", "rugged", "creg",
      "hief", "gwcode_democracy", "cow_war_intra", "cow_war_inter", "cow_trade_ndy")
  )
