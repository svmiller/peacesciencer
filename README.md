
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

| **Function**                                                                                                  | **Description**                                                                                                                                                                                                                                                                                                                                           |
|:--------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [add\_archigos()](http://svmiller.com/peacesciencer/reference/add_archigos.html)                              | add\_archigos() allows you to add some information about leaders to dyad-yearor state-year data. The function leans on an abbreviated version of the data, which also comes in this package.                                                                                                                                                              |
| [add\_atop\_alliance()](http://svmiller.com/peacesciencer/reference/add_atop_alliance.html)                   | add\_atop\_alliance() allows you to add Alliance Treaty Obligations and Provisions (ATOP)data to a dyad-year data frame.                                                                                                                                                                                                                                  |
| [add\_capital\_distance()](http://svmiller.com/peacesciencer/reference/add_capital_distance.html)             | add\_capital\_distance() allows you to add capital-to-capitaldistance to a dyad-year or state-year data frame. The capitals are coded in the capitalsdata frame, along with their latitudes and longitudes. The distance variable thatemerges capdist is calculated using the “Vincenty” method (i.e. “as the crowflies”) and is expressed in kilometers. |
| [add\_ccode\_to\_gw()](http://svmiller.com/peacesciencer/reference/add_ccode_to_gw.html)                      | add\_ccode\_to\_gw() allows you to match, as well as one can, Correlates of War system membership datawith Gleditsch-Ward system data.                                                                                                                                                                                                                    |
| [add\_contiguity()](http://svmiller.com/peacesciencer/reference/add_contiguity.html)                          | add\_contiguity() allows you to add Correlates of War contiguitydata to a dyad-year or state-year data frame.                                                                                                                                                                                                                                             |
| [add\_cow\_alliance()](http://svmiller.com/peacesciencer/reference/add_cow_alliance.html)                     | add\_cow\_alliance() allows you to add Correlates of War alliancedata to a dyad-year data frame                                                                                                                                                                                                                                                           |
| [add\_cow\_majors()](http://svmiller.com/peacesciencer/reference/add_cow_majors.html)                         | add\_cow\_majors() allows you to add Correlates of War major power variablesto a dyad-year or state-year data frame.                                                                                                                                                                                                                                      |
| [add\_cow\_mids()](http://svmiller.com/peacesciencer/reference/add_cow_mids.html)                             | add\_cow\_mids() merges in CoW’s MID data to a dyad-year data frame. The current versionof the CoW-MID data is version 5.0.                                                                                                                                                                                                                               |
| [add\_cow\_trade()](http://svmiller.com/peacesciencer/reference/add_cow_trade.html)                           | add\_cow\_trade() allows you to add Correlates of War alliancedata to a dyad-year data frame                                                                                                                                                                                                                                                              |
| [add\_cow\_wars()](http://svmiller.com/peacesciencer/reference/add_cow_wars.html)                             | add\_cow\_wars() allows you to add UCDP Armed Conflict data to a state-year data frame                                                                                                                                                                                                                                                                    |
| [add\_creg\_fractionalization()](http://svmiller.com/peacesciencer/reference/add_creg_fractionalization.html) | add\_creg\_fractionalization() allows you to add informationabout the fractionalization/polarization of a state’s ethnic and religious groups to your dyad-yearor state-year data.                                                                                                                                                                        |
| [add\_democracy()](http://svmiller.com/peacesciencer/reference/add_democracy.html)                            | add\_democracy() allows you to add estimates of democracy to either dyad-year or state-year data.                                                                                                                                                                                                                                                         |
| [add\_gml\_mids()](http://svmiller.com/peacesciencer/reference/add_gml_mids.html)                             | add\_gml\_mids() merges in GML’s MID data to a dyad-year data frame. The current versionof the GML MID data is 2.1.1.                                                                                                                                                                                                                                     |
| [add\_gwcode\_to\_cow()](http://svmiller.com/peacesciencer/reference/add_gwcode_to_cow.html)                  | add\_gwcode\_to\_cow() allows you to match, as well as one can, Gleditsch-Ward system membership datawith Correlates of War state system membership data.                                                                                                                                                                                                 |
| [add\_igos()](http://svmiller.com/peacesciencer/reference/add_igos.html)                                      | add\_igos() allows you to add information from the Correlates oF War InternationalGovernmental Organizations data to dyad-year or state-year data, matching on Correlates of War system codes.                                                                                                                                                            |
| [add\_mids()](http://svmiller.com/peacesciencer/reference/add_mids.html)                                      | add\_mids() merges in GML’s MID data to a dyad-year data frame. The current versionof the GML MID data is 2.1.1. The function is depcrecated and replaced by add\_gml\_mids() to avoidconfusion with the other conflict data option (add\_cow\_mids())                                                                                                    |
| [add\_minimum\_distance()](http://svmiller.com/peacesciencer/reference/add_minimum_distance.html)             | add\_minimum\_distance() allows you to add the minimumdistance (in kilometers) to a dyad-year or state-year data frame. These estimatesare recorded in the cow\_mindist and gw\_mindist data that come with this package. Thedata are current as of the end of 2015.                                                                                      |
| [add\_nmc()](http://svmiller.com/peacesciencer/reference/add_nmc.html)                                        | add\_nmc() allows you to add the Correlates of War National Material Capabilities data to dyad-year or state-year data.                                                                                                                                                                                                                                   |
| [add\_peace\_years()](http://svmiller.com/peacesciencer/reference/add_peace_years.html)                       | add\_peace\_years() calculates peace years for your ongoing dyadic conflicts. The functionworks for both the CoW-MID data and the Gibler-Miller-Little (GML) MID data.                                                                                                                                                                                    |
| [add\_rugged\_terrain()](http://svmiller.com/peacesciencer/reference/add_rugged_terrain.html)                 | add\_rugged\_terrain() allows you to add information, however crude,about the “ruggedness” of a state’s terrain to your dyad-year or state-year data.                                                                                                                                                                                                     |
| [add\_sdp\_gdp()](http://svmiller.com/peacesciencer/reference/add_sdp_gdp.html)                               | add\_sdp\_gdp() allows you to add estimated GDP and “surplus” domestic product data from a 2020 analysis published inInternational Studies Quarterly by Anders, Fariss, and Markowitz.                                                                                                                                                                    |
| [add\_strategic\_rivalries()](http://svmiller.com/peacesciencer/reference/add_strategic_rivalries.html)       | add\_strategic\_rivalries() merges in Thompson and Dreyer’s (2012) strategic rivalry datato a dyad-year data frame. The right-bound, as of right now, are bound at 2010.                                                                                                                                                                                  |
| [add\_ucdp\_acd()](http://svmiller.com/peacesciencer/reference/add_ucdp_acd.html)                             | add\_ucdp\_acd() allows you to add UCDP Armed Conflict data to a state-year data frame                                                                                                                                                                                                                                                                    |
| [add\_ucdp\_onsets()](http://svmiller.com/peacesciencer/reference/add_ucdp_onsets.html)                       | add\_ucdp\_onsets() allows you to add information about conflict episode onsets from the UCDPdata program to state-year data.                                                                                                                                                                                                                             |
| [create\_dyadyears()](http://svmiller.com/peacesciencer/reference/create_dyadyears.html)                      | create\_dyadyears() allows you to dyad-year data fromeither the Correlates of War (CoW) state system membership data or theGleditsch-Ward (gw) system membership data. The function leans on internaldata provided in the package.                                                                                                                        |
| [create\_statedays()](http://svmiller.com/peacesciencer/reference/create_statedays.html)                      | create\_statedays() allows you to create state-day data fromeither the Correlates of War (CoW) state system membership data or theGleditsch-Ward (gw) system membership data. The function leans on internaldata provided in the package.                                                                                                                 |
| [create\_stateyears()](http://svmiller.com/peacesciencer/reference/create_stateyears.html)                    | create\_stateyears() allows you to generate state-year data fromeither the Correlates of War (CoW) state system membership data or theGleditsch-Ward (gw) system membership data. The function leans on internaldata provided in the package.                                                                                                             |
| [filter\_prd()](http://svmiller.com/peacesciencer/reference/filter_prd.html)                                  | filter\_prd() filters a dyad-year data frame to just those thatare “politically relevant.” This is useful for discarding unnecessary (and unwanted)observations that just consume space in memory.                                                                                                                                                        |

The current development version also includes the following data.

| **Object Name**                                                                         | **Description**                                                                                |
|:----------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------|
| [`archigos`](http://svmiller.com/peacesciencer/reference/archigos.html)                 | Archigos: A (Subset of a) Dataset on Political Leaders                                         |
| [`atop_alliance`](http://svmiller.com/peacesciencer/reference/atop_alliance.html)       | Alliance Treaty Obligations and Provisions (ATOP) Project Data (v. 5.0)                        |
| [`capitals`](http://svmiller.com/peacesciencer/reference/capitals.html)                 | A complete list of capitals and capital transitions for Correlates of War state system members |
| [`ccode_democracy`](http://svmiller.com/peacesciencer/reference/ccode_democracy.html)   | Democracy data for all Correlates of War states                                                |
| [`citations`](http://svmiller.com/peacesciencer/reference/citations.html)               | Citations for Data/Functions Used in ‘peacesciencer’                                           |
| [`cow_alliance`](http://svmiller.com/peacesciencer/reference/cow_alliance.html)         | Correlates of War directed dyad-year alliance data                                             |
| [`cow_contdir`](http://svmiller.com/peacesciencer/reference/cow_contdir.html)           | Correlates of War Direct Contiguity Data (v. 3.2)                                              |
| [`cow_ddy`](http://svmiller.com/peacesciencer/reference/cow_ddy.html)                   | A directed dyad-year data frame of Correlates of War state system members                      |
| [`cow_gw_years`](http://svmiller.com/peacesciencer/reference/cow_gw_years.html)         | Correlates of War and Gleditsch-Ward states, by year                                           |
| [`cow_igo_ndy`](http://svmiller.com/peacesciencer/reference/cow_igo_ndy.html)           | Correlates of War Non-Directed Dyad-Year International Governmental Organizations (IGOs) Data  |
| [`cow_igo_sy`](http://svmiller.com/peacesciencer/reference/cow_igo_sy.html)             | Correlates of War State-Year International Governmental Organizations (IGOs) Data              |
| [`cow_majors`](http://svmiller.com/peacesciencer/reference/cow_majors.html)             | Correlates of War Major Powers Data (1816-2016)                                                |
| [`cow_mid_ddydisps`](http://svmiller.com/peacesciencer/reference/cow_mid_ddydisps.html) | Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0)               |
| [`cow_mid_dirdisps`](http://svmiller.com/peacesciencer/reference/cow_mid_dirdisps.html) | Directed Dyadic Dispute-Year Data (CoW-MID, v. 5.0)                                            |
| [`cow_mid_disps`](http://svmiller.com/peacesciencer/reference/cow_mid_disps.html)       | Abbreviate CoW-MID Dispute-level Data (v. 5.0)                                                 |
| [`cow_mindist`](http://svmiller.com/peacesciencer/reference/cow_mindist.html)           | The Minimum Distance Between States in the Correlates of War System, 1946-2015                 |
| [`cow_nmc`](http://svmiller.com/peacesciencer/reference/cow_nmc.html)                   | Correlates of War National Military Capabilities Data                                          |
| [`cow_sdp_gdp`](http://svmiller.com/peacesciencer/reference/cow_sdp_gdp.html)           | (Surplus and Gross) Domestic Product for Correlates of War States                              |
| [`cow_states`](http://svmiller.com/peacesciencer/reference/cow_states.html)             | Correlates of War State System Membership Data (1816-2016)                                     |
| [`cow_trade_sy`](http://svmiller.com/peacesciencer/reference/cow_trade_sy.html)         | Correlates of War National Trade Data Set (v. 4.0)                                             |
| [`cow_war_inter`](http://svmiller.com/peacesciencer/reference/cow_war_inter.html)       | Correlates of War Inter-State War Data (v. 4.0)                                                |
| [`cow_war_intra`](http://svmiller.com/peacesciencer/reference/cow_war_intra.html)       | Correlates of War Intra-State War Data (v. 4.1)                                                |
| [`creg`](http://svmiller.com/peacesciencer/reference/creg.html)                         | Composition of Religious and Ethnic Groups (CREG) Fractionalization/Polarization Estimates     |
| [`gml_dirdisp`](http://svmiller.com/peacesciencer/reference/gml_dirdisp.html)           | Directed dispute-year data (Gibler, Miller, and Little, 2016)                                  |
| [`gml_mid_ddydisps`](http://svmiller.com/peacesciencer/reference/gml_mid_ddydisps.html) | Directed Dyadic Dispute-Year Data with No Duplicate Dyad-Years (CoW-MID, v. 5.0)               |
| [`gw_cow_years`](http://svmiller.com/peacesciencer/reference/gw_cow_years.html)         | Gleditsch-Ward states and Correlates of War, by year                                           |
| [`gw_ddy`](http://svmiller.com/peacesciencer/reference/gw_ddy.html)                     | A directed dyad-year data frame of Gleditsch-Ward state system members                         |
| [`gw_mindist`](http://svmiller.com/peacesciencer/reference/gw_mindist.html)             | The Minimum Distance Between States in the Gleditsch-Ward System, 1946-2015                    |
| [`gw_sdp_gdp`](http://svmiller.com/peacesciencer/reference/gw_sdp_gdp.html)             | (Surplus and Gross) Domestic Product for Gleditsch-Ward States                                 |
| [`gw_states`](http://svmiller.com/peacesciencer/reference/gw_states.html)               | Gleditsch-Ward (Independent States) System Membership Data (1816-2017)                         |
| [`gwcode_democracy`](http://svmiller.com/peacesciencer/reference/gwcode_democracy.html) | Democracy data for all Gleditsch-Ward states                                                   |
| [`hief`](http://svmiller.com/peacesciencer/reference/hief.html)                         | Historical Index of Ethnic Fractionalization data                                              |
| [`maoz_powers`](http://svmiller.com/peacesciencer/reference/maoz_powers.html)           | Zeev Maoz’ Regional/Global Power Data                                                          |
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
guide](https://github.com/svmiller/peacesciencer/blob/master/user-guide/doc/ms.pdf)
that is worth reading. The workflow is going to look something like
this. This is a “tidy”-friendly approach to a data-generating process in
quantitative peace science.

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
#library(tidyverse)
#library(peacesciencer)
# library(stevemisc)
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
Data %>%
  mutate_at(vars("cincprop", "mindemest", "minwbgdppc", "minmilit"),
            ~r2sd(.)) -> Data

summary(modDD <- glm(gmlmidonset ~ landcontig + cincprop + cowmajdyad + cow_defense +
               mindemest + minwbgdppc + minmilit +
               gmlmidspell + I(gmlmidspell^2) + I(gmlmidspell^3), data= Data,
             family=binomial(link="logit")))
```

    ## 
    ## Call:
    ## glm(formula = gmlmidonset ~ landcontig + cincprop + cowmajdyad + 
    ##     cow_defense + mindemest + minwbgdppc + minmilit + gmlmidspell + 
    ##     I(gmlmidspell^2) + I(gmlmidspell^3), family = binomial(link = "logit"), 
    ##     data = Data)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.8623  -0.2188  -0.1373  -0.0961   5.7550  
    ## 
    ## Coefficients:
    ##                    Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)      -3.041e+00  6.343e-02 -47.944  < 2e-16 ***
    ## landcontig        1.052e+00  5.677e-02  18.527  < 2e-16 ***
    ## cincprop          4.461e-01  3.629e-02  12.293  < 2e-16 ***
    ## cowmajdyad        1.411e-01  5.749e-02   2.454   0.0141 *  
    ## cow_defense      -9.927e-02  5.764e-02  -1.722   0.0850 .  
    ## mindemest        -4.918e-01  5.243e-02  -9.381  < 2e-16 ***
    ## minwbgdppc        2.828e-01  5.091e-02   5.555 2.77e-08 ***
    ## minmilit          2.608e-01  2.308e-02  11.299  < 2e-16 ***
    ## gmlmidspell      -1.475e-01  5.066e-03 -29.112  < 2e-16 ***
    ## I(gmlmidspell^2)  2.486e-03  1.353e-04  18.376  < 2e-16 ***
    ## I(gmlmidspell^3) -1.164e-05  8.953e-07 -13.000  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 23398  on 103922  degrees of freedom
    ## Residual deviance: 19710  on 103912  degrees of freedom
    ##   (19234 observations deleted due to missingness)
    ## AIC: 19732
    ## 
    ## Number of Fisher Scoring iterations: 8

``` r
toc()
```

    ## 12.5 sec elapsed

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
summary(modCW$"All UCDP Conflicts" <- glm(ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    ucdpspell + I(ucdpspell^2) + I(ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))
```

    ## 
    ## Call:
    ## glm(formula = ucdponset ~ l1_wbgdppc2011est + l1_wbpopest + l1_xm_qudsest + 
    ##     I(l1_xm_qudsest^2) + newlmtnest + ethfrac + relfrac + ucdpspell + 
    ##     I(ucdpspell^2) + I(ucdpspell^3), family = binomial(link = "logit"), 
    ##     data = subset(Data))
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.4103  -0.2142  -0.1658  -0.1024   3.4601  
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)        -5.097e+00  1.351e+00  -3.774 0.000161 ***
    ## l1_wbgdppc2011est  -2.854e-01  1.101e-01  -2.593 0.009516 ** 
    ## l1_wbpopest         2.294e-01  6.723e-02   3.412 0.000645 ***
    ## l1_xm_qudsest       2.574e-01  1.805e-01   1.426 0.153887    
    ## I(l1_xm_qudsest^2) -7.260e-01  2.108e-01  -3.444 0.000574 ***
    ## newlmtnest          5.490e-02  6.660e-02   0.824 0.409743    
    ## ethfrac             4.418e-01  3.580e-01   1.234 0.217095    
    ## relfrac            -3.892e-01  4.017e-01  -0.969 0.332563    
    ## ucdpspell          -7.381e-02  3.926e-02  -1.880 0.060108 .  
    ## I(ucdpspell^2)      4.431e-03  2.047e-03   2.165 0.030396 *  
    ## I(ucdpspell^3)     -6.019e-05  2.801e-05  -2.149 0.031638 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1359.9  on 8191  degrees of freedom
    ## Residual deviance: 1275.0  on 8181  degrees of freedom
    ##   (2298 observations deleted due to missingness)
    ## AIC: 1297
    ## 
    ## Number of Fisher Scoring iterations: 9

``` r
summary(modCW$"Wars Only"  <- glm(war_ucdponset ~ l1_wbgdppc2011est + l1_wbpopest  +
                    l1_xm_qudsest + I(l1_xm_qudsest^2) +
                    newlmtnest + ethfrac + relfrac +
                    war_ucdpspell + I(war_ucdpspell^2) + I(war_ucdpspell^3), data=subset(Data),
                  family = binomial(link="logit")))
```

    ## 
    ## Call:
    ## glm(formula = war_ucdponset ~ l1_wbgdppc2011est + l1_wbpopest + 
    ##     l1_xm_qudsest + I(l1_xm_qudsest^2) + newlmtnest + ethfrac + 
    ##     relfrac + war_ucdpspell + I(war_ucdpspell^2) + I(war_ucdpspell^3), 
    ##     family = binomial(link = "logit"), data = subset(Data))
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.3897  -0.1381  -0.0955  -0.0491   3.4561  
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept)        -6.590e+00  2.084e+00  -3.162  0.00157 **
    ## l1_wbgdppc2011est  -3.430e-01  1.721e-01  -1.993  0.04625 * 
    ## l1_wbpopest         2.723e-01  1.065e-01   2.557  0.01054 * 
    ## l1_xm_qudsest      -8.464e-02  2.701e-01  -0.313  0.75404   
    ## I(l1_xm_qudsest^2) -7.612e-01  3.523e-01  -2.160  0.03074 * 
    ## newlmtnest          3.417e-01  1.119e-01   3.054  0.00226 **
    ## ethfrac             3.334e-01  5.545e-01   0.601  0.54762   
    ## relfrac            -2.811e-01  5.927e-01  -0.474  0.63536   
    ## war_ucdpspell      -1.113e-01  5.625e-02  -1.979  0.04779 * 
    ## I(war_ucdpspell^2)  4.662e-03  2.520e-03   1.850  0.06434 . 
    ## I(war_ucdpspell^3) -4.991e-05  3.018e-05  -1.654  0.09819 . 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 689.84  on 8191  degrees of freedom
    ## Residual deviance: 626.95  on 8181  degrees of freedom
    ##   (2298 observations deleted due to missingness)
    ## AIC: 648.95
    ## 
    ## Number of Fisher Scoring iterations: 10

``` r
toc()
```

    ## 4.135 sec elapsed

# Issues/Requests

`{peacesciencer}` is already more than capable to meet a wide variety of
needs in the peace science community. Users are free to raise an issue
on the project’s Github if some feature is not performing as they think
it should or if there are additions they would like to see.
