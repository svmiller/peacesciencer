
# `peacesciencer`: Tools and Data for Quantitative Peace Science

[![](https://www.r-pkg.org/badges/version/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/grand-total/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/last-month/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/last-week/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)

<img src="http://svmiller.com/images/peacesciencer-hexlogo.png" alt="peacesciencer  hexlogo" align="right" width="200" style="padding: 0 15px; float: right;"/>

`peacesciencer` is an R package including various functions and data
sets to allow easier analyses in the field of quantitative peace
science. The goal is to provide an R package that reasonably
approximates what made
[EUGene](https://journals.sagepub.com/doi/abs/10.1177/0738894211413055)
so attractive to scholars working in the field of quantitative peace
science in the early 2000s. EUGene shined because it encouraged
replications of conflict models while having the user also generate data
from scratch. Likewise, this R package will offer tools to approximate
what EUGene did within the R environment (i.e. not requiring Windows for
installation).

# Installation

You can install this on CRAN, as follows:

``` r
install.packages("peacesciencer")
```

You can install the development version of this package through the
`devtools` package. The development version of the package invariably
has more goodies, but may or may not be at various levels of
stress-testing.

``` r
devtools::install_github("svmiller/peacesciencer")
```

# What’s Included in `{peacesciencer}`

The package is already well developed and its functionality continues to
expand. The current development version has the following functions.

| **Function**                                                                                                    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|:----------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`add_archigos()`](http://svmiller.com/peacesciencer/reference/add_archigos.html)                               | add\_archigos() allows you to add some information about leaders to dyad-year or state-year data. The function leans on an abbreviated version of the data, which also comes in this package.                                                                                                                                                                                                                                                                       |
| [`add_atop_alliance()`](http://svmiller.com/peacesciencer/reference/add_atop_alliance.html)                     | add\_atop\_alliance() allows you to add Alliance Treaty Obligations and Provisions (ATOP) data to a dyad-year data frame.                                                                                                                                                                                                                                                                                                                                           |
| [`add_capital_distance()`](http://svmiller.com/peacesciencer/reference/add_capital_distance.html)               | add\_capital\_distance() allows you to add capital-to-capital distance to a dyad-year or state-year data frame. The capitals are coded in the cow\_capitals and gw\_capitals data frames, along with their latitudes and longitudes. The distance variable that emerges capdist is calculated using the “Vincenty” method (i.e. “as the crow flies”) and is expressed in kilometers.                                                                                |
| [`add_ccode_to_gw()`](http://svmiller.com/peacesciencer/reference/add_ccode_to_gw.html)                         | add\_ccode\_to\_gw() allows you to match, as well as one can, Correlates of War system membership data with Gleditsch-Ward system data.                                                                                                                                                                                                                                                                                                                             |
| [`add_contiguity()`](http://svmiller.com/peacesciencer/reference/add_contiguity.html)                           | add\_contiguity() allows you to add Correlates of War contiguity data to a dyad-year or state-year data frame.                                                                                                                                                                                                                                                                                                                                                      |
| [`add_cow_alliance()`](http://svmiller.com/peacesciencer/reference/add_cow_alliance.html)                       | add\_cow\_alliance() allows you to add Correlates of War alliance data to a dyad-year data frame                                                                                                                                                                                                                                                                                                                                                                    |
| [`add_cow_majors()`](http://svmiller.com/peacesciencer/reference/add_cow_majors.html)                           | add\_cow\_majors() allows you to add Correlates of War major power variables to a dyad-year or state-year data frame.                                                                                                                                                                                                                                                                                                                                               |
| [`add_cow_mids()`](http://svmiller.com/peacesciencer/reference/add_cow_mids.html)                               | add\_cow\_mids() merges in CoW’s MID data to a dyad-year data frame. The current version of the CoW-MID data is version 5.0.                                                                                                                                                                                                                                                                                                                                        |
| [`add_cow_trade()`](http://svmiller.com/peacesciencer/reference/add_cow_trade.html)                             | add\_cow\_trade() allows you to add Correlates of War alliance data to a dyad-year data frame                                                                                                                                                                                                                                                                                                                                                                       |
| [`add_cow_wars()`](http://svmiller.com/peacesciencer/reference/add_cow_wars.html)                               | add\_cow\_wars() allows you to add UCDP Armed Conflict data to a state-year data frame                                                                                                                                                                                                                                                                                                                                                                              |
| [`add_creg_fractionalization()`](http://svmiller.com/peacesciencer/reference/add_creg_fractionalization.html)   | add\_creg\_fractionalization() allows you to add information about the fractionalization/polarization of a state’s ethnic and religious groups to your dyad-year or state-year data.                                                                                                                                                                                                                                                                                |
| [`add_democracy()`](http://svmiller.com/peacesciencer/reference/add_democracy.html)                             | add\_democracy() allows you to add estimates of democracy to either dyad-year or state-year data.                                                                                                                                                                                                                                                                                                                                                                   |
| [`add_gml_mids()`](http://svmiller.com/peacesciencer/reference/add_gml_mids.html)                               | add\_gml\_mids() merges in GML’s MID data to a dyad-year data frame. The current version of the GML MID data is 2.1.1.                                                                                                                                                                                                                                                                                                                                              |
| [`add_gwcode_to_cow()`](http://svmiller.com/peacesciencer/reference/add_gwcode_to_cow.html)                     | add\_gwcode\_to\_cow() allows you to match, as well as one can, Gleditsch-Ward system membership data with Correlates of War state system membership data.                                                                                                                                                                                                                                                                                                          |
| [`add_igos()`](http://svmiller.com/peacesciencer/reference/add_igos.html)                                       | add\_igos() allows you to add information from the Correlates oF War International Governmental Organizations data to dyad-year or state-year data, matching on Correlates of War system codes.                                                                                                                                                                                                                                                                     |
| [`add_minimum_distance()`](http://svmiller.com/peacesciencer/reference/add_minimum_distance.html)               | add\_minimum\_distance() allows you to add the minimum distance (in kilometers) to a dyad-year or state-year data frame. These estimates are recorded in the cow\_mindist and gw\_mindist data that come with this package. The data are current as of the end of 2019.                                                                                                                                                                                             |
| [`add_nmc()`](http://svmiller.com/peacesciencer/reference/add_nmc.html)                                         | add\_nmc() allows you to add the Correlates of War National Material Capabilities data to dyad-year or state-year data.                                                                                                                                                                                                                                                                                                                                             |
| [`add_peace_years()`](http://svmiller.com/peacesciencer/reference/add_peace_years.html)                         | add\_peace\_years() calculates peace years for your ongoing dyadic conflicts. The function works for both the CoW-MID data and the Gibler-Miller-Little (GML) MID data.                                                                                                                                                                                                                                                                                             |
| [`add_rugged_terrain()`](http://svmiller.com/peacesciencer/reference/add_rugged_terrain.html)                   | add\_rugged\_terrain() allows you to add information, however crude, about the “ruggedness” of a state’s terrain to your dyad-year or state-year data.                                                                                                                                                                                                                                                                                                              |
| [`add_sdp_gdp()`](http://svmiller.com/peacesciencer/reference/add_sdp_gdp.html)                                 | add\_sdp\_gdp() allows you to add estimated GDP and “surplus” domestic product data from a 2020 analysis published in International Studies Quarterly by Anders, Fariss, and Markowitz.                                                                                                                                                                                                                                                                             |
| [`add_strategic_rivalries()`](http://svmiller.com/peacesciencer/reference/add_strategic_rivalries.html)         | add\_strategic\_rivalries() merges in Thompson and Dreyer’s (2012) strategic rivalry data to a dyad-year data frame. The right-bound, as of right now, are bound at 2010.                                                                                                                                                                                                                                                                                           |
| [`add_ucdp_acd()`](http://svmiller.com/peacesciencer/reference/add_ucdp_acd.html)                               | add\_ucdp\_acd() allows you to add UCDP Armed Conflict data to a state-year data frame                                                                                                                                                                                                                                                                                                                                                                              |
| [`add_ucdp_onsets()`](http://svmiller.com/peacesciencer/reference/add_ucdp_onsets.html)                         | add\_ucdp\_onsets() allows you to add information about conflict episode onsets from the UCDP data program to state-year data.                                                                                                                                                                                                                                                                                                                                      |
| [`create_dyadyears()`](http://svmiller.com/peacesciencer/reference/create_dyadyears.html)                       | create\_dyadyears() allows you to dyad-year data from either the Correlates of War (CoW) state system membership data or the Gleditsch-Ward (gw) system membership data. The function leans on internal data provided in the package.                                                                                                                                                                                                                               |
| [`create_statedays()`](http://svmiller.com/peacesciencer/reference/create_statedays.html)                       | create\_statedays() allows you to create state-day data from either the Correlates of War (CoW) state system membership data or the Gleditsch-Ward (gw) system membership data. The function leans on internal data provided in the package.                                                                                                                                                                                                                        |
| [`create_stateyears()`](http://svmiller.com/peacesciencer/reference/create_stateyears.html)                     | create\_stateyears() allows you to generate state-year data from either the Correlates of War (CoW) state system membership data or the Gleditsch-Ward (gw) system membership data. The function leans on internal data provided in the package.                                                                                                                                                                                                                    |
| [`filter_prd()`](http://svmiller.com/peacesciencer/reference/filter_prd.html)                                   | filter\_prd() filters a dyad-year data frame to just those that are “politically relevant.” This is useful for discarding unnecessary (and unwanted) observations that just consume space in memory.                                                                                                                                                                                                                                                                |
| [`ps_cite()`](http://svmiller.com/peacesciencer/reference/ps_cite.html)                                         | ps\_cite() allows the user to get citations to scholarship that they should include in their papers that incorporate the functions and data in this package.                                                                                                                                                                                                                                                                                                        |
| [`show_duplicates()`](http://svmiller.com/peacesciencer/reference/show_duplicates.html)                         | show\_duplicates() shows which data are duplicated in data generated in peacesciencer. It’s a useful diagnostic tool for users doing some do-it-yourself functions with peacesciencer.                                                                                                                                                                                                                                                                              |
| [`whittle_conflicts_duration()`](http://svmiller.com/peacesciencer/reference/whittle_conflicts_duration.html)   | whittle\_conflicts\_duration() is in a class of do-it-yourself functions for coercing (i.e. “whittling”) conflict-year data with cross-sectional units to unique conflict-year data by cross-sectional unit. The inspiration here is clearly the problem of whittling dyadic dispute-year data into true dyad-year data (like in the Gibler-Miller-Little conflict data). This particular function will keep the observations with the highest estimated duration.  |
| [`whittle_conflicts_fatality()`](http://svmiller.com/peacesciencer/reference/whittle_conflicts_fatality.html)   | whittle\_conflicts\_fatality() is in a class of do-it-yourself functions for coercing (i.e. “whittling”) conflict-year data with cross-sectional units to unique conflict-year data by cross-sectional unit. The inspiration here is clearly the problem of whittling dyadic dispute-year data into true dyad-year data (like in the Gibler-Miller-Little conflict data). This particular function will keep the observations with the highest observed fatality.   |
| [`whittle_conflicts_hostility()`](http://svmiller.com/peacesciencer/reference/whittle_conflicts_hostility.html) | whittle\_conflicts\_hostility() is in a class of do-it-yourself functions for coercing (i.e. “whittling”) conflict-year data with cross-sectional units to unique conflict-year data by cross-sectional unit. The inspiration here is clearly the problem of whittling dyadic dispute-year data into true dyad-year data (like in the Gibler-Miller-Little conflict data). This particular function will keep the observations with the highest observed hostility. |
| [`whittle_conflicts_onsets()`](http://svmiller.com/peacesciencer/reference/whittle_conflicts_onsets.html)       | whittle\_conflicts\_onsets() is in a class of do-it-yourself functions for coercing (i.e. “whittling”) conflict-year data with cross-sectional units to unique conflict-year data by cross-sectional unit. The inspiration here is clearly the problem of whittling dyadic dispute-year data into true dyad-year data (like in the Gibler-Miller-Little conflict data). This particular function will drop ongoing conflicts in the presence of unique onsets.      |

The current development version also includes the following data.

| **Object Name**                                                                         | **Description**                                                                                |
|:----------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------|
| [`archigos`](http://svmiller.com/peacesciencer/reference/archigos.html)                 | Archigos: A (Subset of a) Dataset on Political Leaders                                         |
| [`atop_alliance`](http://svmiller.com/peacesciencer/reference/atop_alliance.html)       | Alliance Treaty Obligations and Provisions (ATOP) Project Data (v. 5.0)                        |
| [`ccode_democracy`](http://svmiller.com/peacesciencer/reference/ccode_democracy.html)   | Democracy data for all Correlates of War states                                                |
| [`cow_alliance`](http://svmiller.com/peacesciencer/reference/cow_alliance.html)         | Correlates of War directed dyad-year alliance data                                             |
| [`cow_capitals`](http://svmiller.com/peacesciencer/reference/cow_capitals.html)         | A complete list of capitals and capital transitions for Correlates of War state system members |
| [`cow_contdir`](http://svmiller.com/peacesciencer/reference/cow_contdir.html)           | Correlates of War Direct Contiguity Data (v. 3.2)                                              |
| [`cow_ddy`](http://svmiller.com/peacesciencer/reference/cow_ddy.html)                   | A directed dyad-year data frame of Correlates of War state system members                      |
| [`cow_gw_years`](http://svmiller.com/peacesciencer/reference/cow_gw_years.html)         | Correlates of War and Gleditsch-Ward states, by year                                           |
| [`cow_igo_ndy`](http://svmiller.com/peacesciencer/reference/cow_igo_ndy.html)           | Correlates of War Non-Directed Dyad-Year International Governmental Organizations (IGOs) Data  |
| [`cow_igo_sy`](http://svmiller.com/peacesciencer/reference/cow_igo_sy.html)             | Correlates of War State-Year International Governmental Organizations (IGOs) Data              |
| [`cow_majors`](http://svmiller.com/peacesciencer/reference/cow_majors.html)             | Correlates of War Major Powers Data (1816-2016)                                                |
| [`cow_mid_ddydisps`](http://svmiller.com/peacesciencer/reference/cow_mid_ddydisps.html) | Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0)               |
| [`cow_mid_dirdisps`](http://svmiller.com/peacesciencer/reference/cow_mid_dirdisps.html) | Directed Dyadic Dispute-Year Data (CoW-MID, v. 5.0)                                            |
| [`cow_mid_disps`](http://svmiller.com/peacesciencer/reference/cow_mid_disps.html)       | Abbreviate CoW-MID Dispute-level Data (v. 5.0)                                                 |
| [`cow_mindist`](http://svmiller.com/peacesciencer/reference/cow_mindist.html)           | The Minimum Distance Between States in the Correlates of War System, 1886-2019                 |
| [`cow_nmc`](http://svmiller.com/peacesciencer/reference/cow_nmc.html)                   | Correlates of War National Military Capabilities Data                                          |
| [`cow_sdp_gdp`](http://svmiller.com/peacesciencer/reference/cow_sdp_gdp.html)           | (Surplus and Gross) Domestic Product for Correlates of War States                              |
| [`cow_states`](http://svmiller.com/peacesciencer/reference/cow_states.html)             | Correlates of War State System Membership Data (1816-2016)                                     |
| [`cow_trade_ndy`](http://svmiller.com/peacesciencer/reference/cow_trade_ndy.html)       | Correlates of War Dyadic Trade Data Set (v. 4.0)                                               |
| [`cow_trade_sy`](http://svmiller.com/peacesciencer/reference/cow_trade_sy.html)         | Correlates of War National Trade Data Set (v. 4.0)                                             |
| [`cow_war_inter`](http://svmiller.com/peacesciencer/reference/cow_war_inter.html)       | Correlates of War Inter-State War Data (v. 4.0)                                                |
| [`cow_war_intra`](http://svmiller.com/peacesciencer/reference/cow_war_intra.html)       | Correlates of War Intra-State War Data (v. 4.1)                                                |
| [`creg`](http://svmiller.com/peacesciencer/reference/creg.html)                         | Composition of Religious and Ethnic Groups (CREG) Fractionalization/Polarization Estimates     |
| [`gml_dirdisp`](http://svmiller.com/peacesciencer/reference/gml_dirdisp.html)           | Directed dispute-year data (Gibler, Miller, and Little, 2016)                                  |
| [`gml_mid_ddydisps`](http://svmiller.com/peacesciencer/reference/gml_mid_ddydisps.html) | Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (GML, v. 2.2.1)                 |
| [`gml_mid_disps`](http://svmiller.com/peacesciencer/reference/gml_mid_disps.html)       | Abbreviated GML MID Dispute-level Data (v. 2.2.1)                                              |
| [`gw_capitals`](http://svmiller.com/peacesciencer/reference/gw_capitals.html)           | A complete list of capitals and capital transitions for Gleditsch-Ward state system members    |
| [`gw_cow_years`](http://svmiller.com/peacesciencer/reference/gw_cow_years.html)         | Gleditsch-Ward states and Correlates of War, by year                                           |
| [`gw_ddy`](http://svmiller.com/peacesciencer/reference/gw_ddy.html)                     | A directed dyad-year data frame of Gleditsch-Ward state system members                         |
| [`gw_mindist`](http://svmiller.com/peacesciencer/reference/gw_mindist.html)             | The Minimum Distance Between States in the Gleditsch-Ward System, 1886-2019                    |
| [`gw_sdp_gdp`](http://svmiller.com/peacesciencer/reference/gw_sdp_gdp.html)             | (Surplus and Gross) Domestic Product for Gleditsch-Ward States                                 |
| [`gw_states`](http://svmiller.com/peacesciencer/reference/gw_states.html)               | Gleditsch-Ward (Independent States) System Membership Data (1816-2017)                         |
| [`gwcode_democracy`](http://svmiller.com/peacesciencer/reference/gwcode_democracy.html) | Democracy data for all Gleditsch-Ward states                                                   |
| [`hief`](http://svmiller.com/peacesciencer/reference/hief.html)                         | Historical Index of Ethnic Fractionalization data                                              |
| [`maoz_powers`](http://svmiller.com/peacesciencer/reference/maoz_powers.html)           | Zeev Maoz’ Regional/Global Power Data                                                          |
| [`ps_bib`](http://svmiller.com/peacesciencer/reference/ps_bib.html)                     | A ‘BibTeX’ Data Frame of Citations                                                             |
| [`rugged`](http://svmiller.com/peacesciencer/reference/rugged.html)                     | Rugged/Mountainous Terrain Data                                                                |
| [`td_rivalries`](http://svmiller.com/peacesciencer/reference/td_rivalries.html)         | Thompson and Dreyer’s (2012) Strategic Rivalries, 1494-2010                                    |
| [`ucdp_acd`](http://svmiller.com/peacesciencer/reference/ucdp_acd.html)                 | UCDP Armed Conflict Data (ACD) (v. 20.1)                                                       |
| [`ucdp_onsets`](http://svmiller.com/peacesciencer/reference/ucdp_onsets.html)           | UCDP Onset Data (v. 19.1)                                                                      |

<!-- The package is very much a work in progress. Right now, it has the following functions: -->
<!-- - `add_archigos()`: adds some summary variables from Archigos about political leaders for state-year or dyad-year data. -->
<!-- - `add_atop_alliance()`: adds ATOP alliance information to dyad-year data. -->
<!-- - `add_capital_distance()`: adds capital-to-capital distance (in kilometers, "as the crow flies") to dyad-year or state-year data. -->
<!-- - `add_ccode_to_gw()`:     Add Correlates of War state system codes to dyad-year or state-year data with Gleditsch-Ward state codes. -->
<!-- - `add_contiguity()`: adds Correlates of War direct contiguity data to dyad-year or state-year data. -->
<!-- - `add_cow_alliance()`: adds Correlates of War major alliance information to dyad-year data. -->
<!-- - `add_cow_majors()`: adds Correlates of War major power information to dyad-year or state-year data. -->
<!-- - `add_cow_mids()`: adds Correlates of War (CoW) Militarized Interstate Dispute (MID) data to dyad-year data frame -->
<!-- - `add_cow_trade()`: adds Correlates of War trade data to dyad-year or state-year data. -->
<!-- - `add_creg_fractionalization()`: add fractionalization/polarization estimates from CREG to your dyad-year or state-year data -->
<!-- - `add_democracy()`: adds estimates of democracy/levels of democracy to dyad-year or state-year data. -->
<!-- - `add_gwcode_to_cow():` adds Gleditsch-Ward state codes to dyad-year or state-year data with Correlates of War state codes. -->
<!-- - `add_gml_mids():` adds dyad-year information about ongoing MIDs and MID onsets from the Gibler-Miller-Little data. -->
<!-- - `add_igos()`: adds Correlates of War International Governmental Organizations (IGOs) data to dyad-year or state-year data. -->
<!-- - `add_mids():` adds dyad-year information about ongoing MIDs and MID onsets from the Gibler-Miller-Little data. (DEPRECATED) -->
<!-- - `add_minimum_distance()`: adds minimum distance (in kilometers) to dyad-year or state-year data. -->
<!-- - `add_nmc()`: adds estimates of national material capabilities (from Correlates of War) to dyad-year or state-year data. -->
<!-- - `add_peace_years()`: Add Peace Years to Your Conflict Data -->
<!-- - `add_sdp_gdp()`: adds estimates of (gross and surplus) domestic product and population size to dyad-year or state-year data -->
<!-- - `add_strategic_rivalries()`: Add Thompson and Dreyer's (2012) strategic rivalry data to dyad-year data frame -->
<!-- - `add_ucdp_acd()`: Add UCDP Armed Conflict Data to state-year data frame -->
<!-- - `add_ucdp_onsets()`: adds UCDP onsets to state-year data -->
<!-- - `create_dyadyears()`: converts Correlates of War or Gleditsch-Ward state system membership data into dyad-year format -->
<!-- - `create_statedays()`: converts Correlates of War or Gleditsch-Ward state membership data into state-day format.. -->
<!-- - `create_stateyears()`: converts Correlates of War or Gleditsch-Ward state membership data into state-year format. -->
<!-- - `filter_prd()`: filters dyad-year data frame to just "politically relevant" dyads. -->
<!-- It also has the following data sets: -->
<!-- - `archigos`: an abbreviated version of the Archigos data, used internally -->
<!-- - `atop_alliance:` directed dyad-year alliance data from ATOP -->
<!-- - `capitals`: a list of capitals and capital transitions for Correlates of War state system members -->
<!-- - `ccode_democracy`: Correlates of War state-year data with three different estimates of democracy (Varieties of Democracy, Polity, Xavier Marquez/Pemstein et al.'s "(Quick) Unified Democracy Scores"). -->
<!-- - `cow_alliance`: directed dyad-year alliance formation data from the Correlates of War -->
<!-- - `cow_contdir`: Correlates of War Direct Contiguity Data (v. 3.2) -->
<!-- - `cow_ddy`: a full directed dyad-year data frame of Correlates of War state system members -->
<!-- - `cow_gw_years`: a yearly data frame including information about Correlates of War and Gleditsch-Ward states. -->
<!-- - `cow_igo_ndy`: non-directed dyad-year data for Correlates of War intergovernmental organizations data. -->
<!-- - `cow_igo_sy`: state-year data for Correlates of War intergovernmental organizations data. -->
<!-- - `cow_majors`: Correlates of War major powers data (version: 2016) -->
<!-- - `cow_mid_ddydisps`:  Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0) -->
<!-- - `cow_mid_dirdisps`: Correlates of War Militarized Interstate Dispute data (directed dyadic dispute-year, v. 5.0)  -->
<!-- - `cow_mid_disps`: Correlates of War Militarized Interstate Dispute data (abbreviated dispute-level, v. 5.0)  -->
<!-- - `cow_mindist`: the minimum distance between Correlates of War states, in kilometers, in non-directed dyad-year format (1946-2015) -->
<!-- - `cow_nmc`: Correlates of War National Material Capabilities data (version 5.0) -->
<!-- - `cow_sdp_gdp`: (Surplus and Gross) Domestic Product for Correlates of War States -->
<!-- - `cow_states`: Correlates of War state system membership data (version: 2016) -->
<!-- - `cow_trade_sy`: Correlates of War state-year trade data (version 4.0) -->
<!-- - `creg`: Composition of Religious and Ethnic Groups (CREG) Fractionalization/Polarization Estimates -->
<!-- - `gml_dirdisp`: directed dispute-year data from version 2.1.1 of the Gibler-Miller-Little inter-state dispute data. -->
<!-- - `gml_mid_ddydisps`:  Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (Gibler-Miller-Little, v. 2.1.1) -->
<!-- - `gw_ddy`: a full directed dyad-year data frame of Gleditsch-Ward state system members -->
<!-- - `gw_mindist`: the minimum distance between  Gleditsch-Ward states, in kilometers, in non-directed dyad-year format (1946-2015) -->
<!-- - `gw_sdp_gdp`: (Surplus and Gross) Domestic Product for Correlates of War States -->
<!-- - `gw_states`: Gleditsch-Ward independent state system data (version: 2017) -->
<!-- - `gwcode_democracy`: Gleditsch-Ward state-year data with three different estimates of democracy (Varieties of Democracy, Polity, Xavier Marquez/Pemstein et al.'s "(Quick) Unified Democracy Scores"). -->
<!-- - `hief`: Historical Index of Ethnic Fractionalization data -->
<!-- - `maoz_powers`: Zeev Maoz' global/regional power data -->
<!-- - `rugged`: Rugged/Mountainous Terrain Data -->
<!-- - `td_rivalries`: Thompson and Dreyer's (2012) Strategic Rivalries, 1494-2010 -->
<!-- - `ucdp_acd`: a (not quite) dyad-year and (not quite) state-year data set on armed conflict episodes -->
<!-- - `ucdp_onsets`: a state-year data set of UCDP armed conflict onsets/episodes. -->

# How to Use `{peacesciencer}`

[`{peacesciencer}` has a user’s
guide](http://svmiller.com/peacesciencer/ms.pdf) that is worth reading.
The workflow is going to look something like this. This is a
“tidy”-friendly approach to a data-generating process in quantitative
peace science.

First, start with one of two processes to create either dyad-year or
state-year data. The dyad-year data are created with the
`create_dyadyears()` function. It has a few optional parameters with
hidden defaults. The user can specify what kind of state system
(`system`) data they want to use—either Correlates of War (`"cow"`) or
Gleditsch-Ward (`"gw"`), whether they want to extend the data to the
most recently concluded calendar year (`mry`) (i.e. Correlates of War
state system membership data are current as of Dec. 31, 2016 and the
script can extend that to the end of the most recently concluded
calendar year), and whether the user wants directed or non-directed
dyad-year data (`directed`).

The `create_stateyears()` works much the same way, though “directed” and
“non-directed” make no sense in the state-year context. Both functions
default to Correlates of War state system membership data to the most
recently concluded calendar year.

Thereafter, the user can specify what additional variables they want
added to these dyad-year or state-year data. Do note: the additional
functions lean primarily on Correlates of War state code identifiers.
Indeed, the bulk of the quantitative peace science data ecosystem is
built around the Correlates of War project. The variables the user wants
are added in [a “pipe”](https://r4ds.had.co.nz/pipes.html) in a process
like this. Do note that the user may want to break up the
data-generating process into a few manageable “chunks” (e.g. first
generating dyad-year data and saving to an object, adding to it piece by
piece).

All told, the process will look something like this. Assume you want to
create some data for something analogous to a “dangerous dyads” design
for all non-directed dyad-years. Here’s how you’d do it in
`{peacesciencer}`, which is going to be lifted from the source R scripts
for the user’s guide. The first part of this code chunk will lean on
core `{peacesciencer}` functionality whereas the other stuff is some
post-processing and, as a bonus, some modeling.

``` r
# library(tidyverse) # load this first for most/all things
# library(peacesciencer) # the package of interest
# library(stevemisc) # a dependency, but also used for standardizing variables for better interpretation
library(tictoc)

tic()
create_dyadyears(directed = FALSE, mry = FALSE) %>%
  filter_prd() %>%
  add_gml_mids(keep = NULL) %>%
  add_peace_years() %>%
  add_nmc() %>%
  add_democracy() %>%
  add_cow_alliance() %>%
  add_sdp_gdp() -> Data


Data %>%
  mutate(landcontig = ifelse(conttype == 1, 1, 0)) %>%
  mutate(cowmajdyad = ifelse(cowmaj1 == 1 | cowmaj2 == 1, 1, 0)) %>%
  # Create estimate of militarization as milper/tpop
  # Then make a weak-link
  mutate(milit1 = milper1/tpop1,
         milit2 = milper2/tpop2,
         minmilit = ifelse(milit1 > milit2,
                           milit2, milit1)) %>%
  # create CINC proportion (lower over higher)
  mutate(cincprop = ifelse(cinc1 > cinc2,
                           cinc2/cinc1, cinc1/cinc2)) %>%
  # create weak-link specification using Quick UDS data
  mutate(mindemest = ifelse(xm_qudsest1 > xm_qudsest2,
                            xm_qudsest2, xm_qudsest1)) %>%
  # Create "weak-link" measure of jointly advanced economies
  mutate(minwbgdppc = ifelse(wbgdppc2011est1 > wbgdppc2011est2,
                             wbgdppc2011est2, wbgdppc2011est1)) -> Data

# r2sd() is in {stevemisc}, a {peacesciencer} dependency.
# This is just for a more readable regression output.
Data %>%
  mutate_at(vars("cincprop", "mindemest", "minwbgdppc", "minmilit"),
            ~r2sd(.)) -> Data

broom::tidy(modDD <- glm(gmlmidonset ~ landcontig + cincprop + cowmajdyad + cow_defense +
               mindemest + minwbgdppc + minmilit +
               gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3), data= Data,
             family=binomial(link="logit")))
#> # A tibble: 11 × 5
#>    term               estimate   std.error statistic   p.value
#>    <chr>                 <dbl>       <dbl>     <dbl>     <dbl>
#>  1 (Intercept)      -3.05      0.0635         -48.1  0        
#>  2 landcontig        1.06      0.0568          18.7  4.09e- 78
#>  3 cincprop          0.453     0.0362          12.5  7.16e- 36
#>  4 cowmajdyad        0.144     0.0575           2.51 1.21e-  2
#>  5 cow_defense      -0.118     0.0580          -2.04 4.10e-  2
#>  6 mindemest        -0.499     0.0525          -9.51 1.92e- 21
#>  7 minwbgdppc        0.293     0.0511           5.72 1.06e-  8
#>  8 minmilit          0.260     0.0231          11.3  2.13e- 29
#>  9 gmlmidspell      -0.146     0.00505        -29.0  7.61e-185
#> 10 I(gmlmidspell^2)  0.00247   0.000135        18.4  3.16e- 75
#> 11 I(gmlmidspell^3) -0.0000116 0.000000891    -13.0  1.24e- 38
toc()
#> 11.572 sec elapsed
```

Here is how you might do a standard civil conflict analysis using
Gleditsch-Ward states and UCDP conflict data.

``` r
tic()
create_stateyears(system = 'gw') %>%
  filter(year %in% c(1946:2019)) %>%
  add_ucdp_acd(type=c("intrastate"), only_wars = FALSE) %>%
  add_peace_years() %>%
  add_democracy() %>%
  add_creg_fractionalization() %>%
  add_sdp_gdp() %>%
  add_rugged_terrain() -> Data

create_stateyears(system = 'gw') %>%
  filter(year %in% c(1946:2019)) %>%
  add_ucdp_acd(type=c("intrastate"), only_wars = TRUE) %>%
  add_peace_years() %>%
  rename_at(vars(ucdpongoing:ucdpspell), ~paste0("war_", .)) %>%
  left_join(Data, .) -> Data

Data %>%
  arrange(gwcode, year) %>%
  group_by(gwcode) %>%
  mutate_at(vars("xm_qudsest", "wbgdppc2011est",
                 "wbpopest"), list(l1 = ~lag(., 1))) %>%
  rename_at(vars(contains("_l1")),
            ~paste("l1", gsub("_l1", "", .), sep = "_") ) -> Data

modCW <- list()
broom::tidy(modCW$"All UCDP Conflicts" <- glm(ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    ucdpspell + I(ucdpspell^2) + I(ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))
#> # A tibble: 11 × 5
#>    term                 estimate std.error statistic  p.value
#>    <chr>                   <dbl>     <dbl>     <dbl>    <dbl>
#>  1 (Intercept)        -5.10      1.35         -3.77  0.000161
#>  2 l1_wbgdppc2011est  -0.285     0.110        -2.59  0.00952 
#>  3 l1_wbpopest         0.229     0.0672        3.41  0.000645
#>  4 l1_xm_qudsest       0.257     0.181         1.43  0.154   
#>  5 I(l1_xm_qudsest^2) -0.726     0.211        -3.44  0.000574
#>  6 newlmtnest          0.0549    0.0666        0.824 0.410   
#>  7 ethfrac             0.442     0.358         1.23  0.217   
#>  8 relfrac            -0.389     0.402        -0.969 0.333   
#>  9 ucdpspell          -0.0738    0.0393       -1.88  0.0601  
#> 10 I(ucdpspell^2)      0.00443   0.00205       2.16  0.0304  
#> 11 I(ucdpspell^3)     -0.0000602 0.0000280    -2.15  0.0316

broom::tidy(modCW$"Wars Only"  <- glm(war_ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    war_ucdpspell + I(war_ucdpspell^2) + I(war_ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))
#> # A tibble: 11 × 5
#>    term                 estimate std.error statistic p.value
#>    <chr>                   <dbl>     <dbl>     <dbl>   <dbl>
#>  1 (Intercept)        -6.59      2.08         -3.16  0.00157
#>  2 l1_wbgdppc2011est  -0.343     0.172        -1.99  0.0463 
#>  3 l1_wbpopest         0.272     0.106         2.56  0.0105 
#>  4 l1_xm_qudsest      -0.0846    0.270        -0.313 0.754  
#>  5 I(l1_xm_qudsest^2) -0.761     0.352        -2.16  0.0307 
#>  6 newlmtnest          0.342     0.112         3.05  0.00226
#>  7 ethfrac             0.333     0.554         0.601 0.548  
#>  8 relfrac            -0.281     0.593        -0.474 0.635  
#>  9 war_ucdpspell      -0.111     0.0562       -1.98  0.0478 
#> 10 I(war_ucdpspell^2)  0.00466   0.00252       1.85  0.0643 
#> 11 I(war_ucdpspell^3) -0.0000499 0.0000302    -1.65  0.0982

toc()
#> 4.113 sec elapsed
```

# Citing What You Do in `{peacesciencer}`

You can (and should) cite what you do in `{peacesciencer}`. The package
includes a data frame of a `BibTeX` file (`ps_bib`) and a function for
finding and returning `BibTeX` entries that you can include in your
projects. This is the `ps_cite()` function. The `ps_cite()` function
takes a string and does a partial match for relevant keywords (as
`KEYWORDS`) associated with entries in the `ps_bib` file. For example,
you can (and should) cite the package itself.

``` r
ps_cite("peacesciencer")
#> @Manual{peacesciencer-package,
#>   Author = {Steven V. Miller},
#>   Title = {peacesciencer}: A User's Guide for Quantitative Peace Science in R},
#>   Year = {2021},
#>   Keywords = {peacesciencer, add_capital_distance(), add_ccode_to_gw(), add_gwcode_to_cow(), capitals},
#>   Url = {http://svmiller.com/peacesciencer/}
#> }
```

You can see what are the relevant citations to consider using for the
data returned by `add_democracy()`

``` r
ps_cite("add_democracy()")
#> @Unpublished{coppedgeetal2020vdem,
#>   Author = {Michael Coppedge and John Gerring and Carl Henrik Knutsen and Staffan I. Lindberg and Jan Teorell and David Altman and Michael Bernhard and M. Steven Fish and Adam Glynn and Allen Hicken and Anna Luhrmann and Kyle L. Marquardt and Kelly McMann and Pamela Paxton and Daniel Pemstein and Brigitte Seim and Rachel Sigman and Svend-Erik Skaaning and Jeffrey Staton and Agnes Cornell and Lisa Gastaldi and Haakon Gjerl{\o}w and Valeriya Mechkova and Johannes von R{\"o}mer and Aksel Sundtr{\"o}m and Eitan Tzelgov and Luca Uberti and Yi-ting Wang and Tore Wig and Daniel Ziblatt},
#>   Note = {Varieties of Democracy ({V}-{D}em) Project},
#>   Title = {V-Dem Codebook v10},
#>   Year = {2020},
#>   Keywords = {add_democracy(), v-dem, varieties of democracy}
#> }
#> 
#> 
#> @Unpublished{marshalletal2017p,
#>   Author = {Monty G. Marshall and Ted Robert Gurr and Keith Jaggers},
#>   Note = {University of Maryland, Center for International Development and Conflict Management},
#>   Title = {Polity {IV} Project: Political Regime Characteristics and Transitions, 1800-2016},
#>   Year = {2017},
#>   Keywords = {add_democracy(), polity}
#> }
#> 
#> 
#> @Unpublished{marquez2016qme,
#>   Author = {Xavier Marquez},
#>   Note = {Available at SSRN: http://ssrn.com/abstract=2753830},
#>   Title = {A Quick Method for Extending the {U}nified {D}emocracy {S}cores},
#>   Year = {2016},
#>   Keywords = {add_democracy(), UDS, Unified Democracy Scores},
#>   Url = {http://dx.doi.org/10.2139/ssrn.2753830}
#> }
#> 
#> 
#> @Article{pemsteinetal2010dc,
#>   Author = {Pemstein, Daniel and Stephen A. Meserve and James Melton},
#>   Journal = {Political Analysis},
#>   Number = {4},
#>   Pages = {426--449},
#>   Title = {Democratic Compromise: A Latent Variable Analysis of Ten Measures of Regime Type},
#>   Volume = {18},
#>   Year = {2010},
#>   Keywords = {add_democracy(), UDS, Unified Democracy Scores},
#>   Owner = {steve},
#>   Timestamp = {2011.01.30}
#> }
```

You can also return partial matches to see what citations are associated
with, say, alliance data in this package.

``` r
ps_cite("alliance")
#> @Article{leedsetal2002atop,
#>   Author = {Bretty Ashley Leeds and Jeffrey M. Ritter and Sara McLaughlin Mitchell and Andrew G. Long},
#>   Journal = {International Interactions},
#>   Pages = {237--260},
#>   Title = {Alliance Treaty Obligations and Provisions, 1815-1944},
#>   Volume = {28},
#>   Year = {2002},
#>   Keywords = {add_atop_alliance()}
#> }
#> 
#> 
#> @Book{gibler2009ima,
#>   Author = {Douglas M. Gibler},
#>   Publisher = {Washington DC: CQ Press},
#>   Title = {International Military Alliances, 1648-2008},
#>   Year = {2009},
#>   Keywords = {add_cow_alliance()}
#> }
```

This function might expand in complexity in future releases, but you can
use it right now for finding appropriate citations. You an also scan the
`ps_bib` data to see what is in there.

# Issues/Requests

`{peacesciencer}` is already more than capable to meet a wide variety of
needs in the peace science community. Users are free to raise an issue
on the project’s Github if some feature is not performing as they think
it should or if there are additions they would like to see.
