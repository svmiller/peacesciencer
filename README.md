
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
  - `add_cow_alliance()`: adds Correlates of War major power information
    to dyad-year data.
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
  - `cow_alliance`: directed dyad-year alliance formation data from the
    Correlates of War
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

# Usage

The workflow is going to look something like this.

``` r
library(tidyverse, quietly = TRUE)
library(peacesciencer)
library(tictoc)

tic()
create_dyadyears() %>%
  # Add Gleditsch-Ward codes
  add_gwcode_to_cow() %>%
  # Add capital-to-capital distance
  add_capital_distance() %>%
  # Add contiguity information
  add_contiguity() %>%
  # Add major power data
  add_cow_majors() %>%
  # Add democracy variables
  add_democracy() %>%
  # add alliance data from Correlates of War
  add_cow_alliance() %>%
  # you should probably filter to politically relevant dyads earlier than later...
  # Or not, it's your time and computer processor...
  filter_prd()
```

    ## # A tibble: 246,314 x 20
    ##    ccode1 ccode2  year gwcode1 gwcode2 capdist conttype cowmaj1 cowmaj2
    ##     <dbl>  <dbl> <dbl>   <dbl>   <dbl>   <dbl>    <dbl>   <dbl>   <dbl>
    ##  1      2     20  1920       2      20    735.        1       1       0
    ##  2      2     20  1921       2      20    735.        1       1       0
    ##  3      2     20  1922       2      20    735.        1       1       0
    ##  4      2     20  1923       2      20    735.        1       1       0
    ##  5      2     20  1924       2      20    735.        1       1       0
    ##  6      2     20  1925       2      20    735.        1       1       0
    ##  7      2     20  1926       2      20    735.        1       1       0
    ##  8      2     20  1927       2      20    735.        1       1       0
    ##  9      2     20  1928       2      20    735.        1       1       0
    ## 10      2     20  1929       2      20    735.        1       1       0
    ## # … with 246,304 more rows, and 11 more variables: v2x_polyarchy1 <dbl>,
    ## #   polity21 <dbl>, xm_qudsest1 <dbl>, v2x_polyarchy2 <dbl>, polity22 <dbl>,
    ## #   xm_qudsest2 <dbl>, defense <dbl>, neutrality <dbl>, nonaggression <dbl>,
    ## #   entente <dbl>, prd <dbl>

``` r
toc()
```

    ## 12.911 sec elapsed
