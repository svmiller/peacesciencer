
# `peacesciencer`: Various Tools and Data for Quantitative Peace Science

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

The package is very much a work in progress. Right now, it has the
following functions:

  - `add_capital_distance()`: adds capital-to-capital distance (in
    kilometers, “as the crow flies”) to dyad-year or state-year data.
  - `add_contiguity()`: adds Correlates of War direct contiguity data to
    dyad-year or state-year data.
  - `add_cow_majors()`: adds Correlates of War major power information
    to dyad-year or state-year data.
  - `add_democracy()`: adds estimates of democracy/levels of democracy
    to dyad-year or state-year data.
  - `add_gwcode_to_cow():` adds Gleditsch-Ward state codes to dyad-year
    or state-year data with Correlates of War state codes.
  - `create_stateyears()`: converts Correlates of War or Gleditsch-Ward
    state membership data into state-year format.
  - `create_dyadyears()`: converts Correlates of War or Gleditsch-Ward
    state system membership data into dyad-year format.
  - `filter_prd()`: filters dyad-year data frame to just “politically
    relevant” dyads.

It also has the following data sets:

  - `capitals`: a list of capitals and capital transitions for
    Correlates of War state system members
  - `ccode_democracy`: Correlates of War state-year data with three
    different estimates of democracy (Varieties of Democracy, Polity,
    Xavier Marquez/Pemstein et al.’s “(Quick) Unified Democracy
    Scores”).
  - `cow_contdir`: Correlates of War Direct Contiguity Data (v. 3.2)
  - `cow_ddy`: a full directed dyad-year data frame of Correlates of War
    state system members
  - `cow_gw_years`: a yearly data frame including information about
    Correlates of War and Gleditsch-Ward states.
  - `cow_majors`: Correlates of War major powers data (version: 2016)
  - `cow_states`: Correlates of War state system membership data
    (version: 2016)
  - `gw_ddy`: a full directed dyad-year data frame of Gleditsch-Ward
    state system members
  - `gw_states`: Gleditsch-Ward independent state system data (version:
    2017)
  - `maoz_powers`: Zeev Maoz’ global/regional power data.
