
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

# Usage

The package is very much a work in progress. Right now, it has the
following functions:

-   `add_archigos()`: adds some summary variables from Archigos about
    political leaders for state-year or dyad-year data.
-   `add_atop_alliance()`: adds ATOP alliance information to dyad-year
    data.
-   `add_capital_distance()`: adds capital-to-capital distance (in
    kilometers, “as the crow flies”) to dyad-year or state-year data.
-   `add_ccode_to_gw()`: Add Correlates of War state system codes to
    dyad-year or state-year data with Gleditsch-Ward state codes.
-   `add_contiguity()`: adds Correlates of War direct contiguity data to
    dyad-year or state-year data.
-   `add_cow_alliance()`: adds Correlates of War major alliance
    information to dyad-year data.
-   `add_cow_majors()`: adds Correlates of War major power information
    to dyad-year or state-year data.
-   `add_cow_mids()`: adds Correlates of War (CoW) Militarized
    Interstate Dispute (MID) data to dyad-year data frame
-   `add_cow_trade()`: adds Correlates of War trade data to dyad-year or
    state-year data.
-   `add_democracy()`: adds estimates of democracy/levels of democracy
    to dyad-year or state-year data.
-   `add_gwcode_to_cow():` adds Gleditsch-Ward state codes to dyad-year
    or state-year data with Correlates of War state codes.
-   `add_gml_mids():` adds dyad-year information about ongoing MIDs and
    MID onsets from the Gibler-Miller-Little data.
-   `add_igos()`: adds Correlates of War International Governmental
    Organizations (IGOs) data to dyad-year or state-year data.
-   `add_mids():` adds dyad-year information about ongoing MIDs and MID
    onsets from the Gibler-Miller-Little data. (DEPRECATED)
-   `add_minimum_distance()`: adds minimum distance (in kilometers) to
    dyad-year or state-year data.
-   `add_nmc()`: adds estimates of national material capabilities (from
    Correlates of War) to dyad-year or state-year data.
-   `add_peace_years()`: Add Peace Years to Your Conflict Data
-   `add_sdp_gdp()`: adds estimates of (gross and surplus) domestic
    product and population size to dyad-year or state-year data
-   `add_strategic_rivalries()`: Add Thompson and Dreyer’s (2012)
    strategic rivalry data to dyad-year data frame
-   `add_ucdp_acd()`: Add UCDP Armed Conflict Data to state-year data
    frame
-   `add_ucdp_onsets()`: adds UCDP onsets to state-year data
-   `create_dyadyears()`: converts Correlates of War or Gleditsch-Ward
    state system membership data into dyad-year format
-   `create_statedays()`: converts Correlates of War or Gleditsch-Ward
    state membership data into state-day format..
-   `create_stateyears()`: converts Correlates of War or Gleditsch-Ward
    state membership data into state-year format.
-   `filter_prd()`: filters dyad-year data frame to just “politically
    relevant” dyads.

It also has the following data sets:

-   `archigos`: an abbreviated version of the Archigos data, used
    internally
-   `atop_alliance:` directed dyad-year alliance data from ATOP
-   `capitals`: a list of capitals and capital transitions for
    Correlates of War state system members
-   `ccode_democracy`: Correlates of War state-year data with three
    different estimates of democracy (Varieties of Democracy, Polity,
    Xavier Marquez/Pemstein et al.’s “(Quick) Unified Democracy
    Scores”).
-   `cow_alliance`: directed dyad-year alliance formation data from the
    Correlates of War
-   `cow_contdir`: Correlates of War Direct Contiguity Data (v. 3.2)
-   `cow_ddy`: a full directed dyad-year data frame of Correlates of War
    state system members
-   `cow_gw_years`: a yearly data frame including information about
    Correlates of War and Gleditsch-Ward states.
-   `cow_igo_ndy`: non-directed dyad-year data for Correlates of War
    intergovernmental organizations data.
-   `cow_igo_sy`: state-year data for Correlates of War
    intergovernmental organizations data.
-   `cow_majors`: Correlates of War major powers data (version: 2016)
-   `cow_mid_ddydisps`: Directed Dyadic Dispute-Year Data with No
    Duplicate Dyad-Years (CoW-MID, v. 5.0)
-   `cow_mid_dirdisps`: Correlates of War Militarized Interstate Dispute
    data (directed dyadic dispute-year, v. 5.0)
-   `cow_mid_disps`: Correlates of War Militarized Interstate Dispute
    data (abbreviated dispute-level, v. 5.0)
-   `cow_mindist`: the minimum distance between Correlates of War
    states, in kilometers, in non-directed dyad-year format (1946-2015)
-   `cow_nmc`: Correlates of War National Material Capabilities data
    (version 5.0)
-   `cow_sdp_gdp`: (Surplus and Gross) Domestic Product for Correlates
    of War States
-   `cow_states`: Correlates of War state system membership data
    (version: 2016)
-   `cow_trade_sy`: Correlates of War state-year trade data (version
    4.0)
-   `creg`: Composition of Religious and Ethnic Groups (CREG)
    Fractionalization/Polarization Estimates
-   `gml_dirdisp`: directed dispute-year data from version 2.1.1 of the
    Gibler-Miller-Little inter-state dispute data.
-   `gml_mid_ddydisps`: Directed Dyadic Dispute-Year Data with No
    Duplicate Dyad-Years (Gibler-Miller-Little, v. 2.1.1)
-   `gw_ddy`: a full directed dyad-year data frame of Gleditsch-Ward
    state system members
-   `gw_mindist`: the minimum distance between Gleditsch-Ward states, in
    kilometers, in non-directed dyad-year format (1946-2015)
-   `gw_sdp_gdp`: (Surplus and Gross) Domestic Product for Correlates of
    War States
-   `gw_states`: Gleditsch-Ward independent state system data
    (version: 2017)
-   `hief`: Historical Index of Ethnic Fractionalization data
-   `maoz_powers`: Zeev Maoz’ global/regional power data
-   `rugged`: Rugged/Mountainous Terrain Data
-   `td_rivalries`: Thompson and Dreyer’s (2012) Strategic Rivalries,
    1494-2010
-   `ucdp_acd`: a (not quite) dyad-year and (not quite) state-year data
    set on armed conflict episodes
-   `ucdp_onsets`: a state-year data set of UCDP armed conflict
    onsets/episodes.

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
script can extend that to the end of 2019), and whether the user wants
directed or non-directed dyad-year data (`directed`).

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

All told, the process will look something like this.

``` r
library(tidyverse, quietly = TRUE)
library(peacesciencer)
library(tictoc)

tic()
create_dyadyears() %>%
  # Add GML MIDs 
  add_gml_mids(keep=NULL) %>%
  # Add Correlates of War MIDs 
  add_cow_mids(keep=NULL) %>%
  # add peace years
  add_peace_years() %>%
  # Add Gleditsch-Ward codes, because we can
  add_gwcode_to_cow() %>%
  # Add strategic rivalry data
  add_strategic_rivalries() %>%
  # Add trade data
  add_cow_trade() %>%
  # Add capital-to-capital distance
  add_capital_distance() %>%
  # Add contiguity information
  add_contiguity() %>%
  # Add major power data
  add_cow_majors() %>%
  # Add democracy variables
  add_democracy() %>%
  # Add IGOs data
  add_igos() %>%
  # Add National Material Capabilities
  add_nmc() %>%
  # add alliance data from Correlates of War
  add_cow_alliance() %>%
  # add alliance data from ATOP
  add_atop_alliance() %>%
  # add minimum distance. No default, must specify "cow" or "gw"
  add_minimum_distance(system = "cow") %>%
  # add Archigos data
  add_archigos() %>%
  # add gross and surplus GDP data
  add_sdp_gdp(system = "cow") %>%
  # add terrain ruggedness data, if you wanted it
  add_rugged_terrain() %>%
  # you should probably filter to politically relevant dyads earlier than later...
  # Or not, it's your time and computer processor...
  filter_prd()
```

    ## # A tibble: 1,057,922 x 79
    ##    ccode1 ccode2  year gmlmidonset gmlmidongoing cowmidonset cowmidongoing
    ##     <dbl>  <dbl> <dbl>       <dbl>         <dbl>       <dbl>         <dbl>
    ##  1    100    101  1841           0             0           0             0
    ##  2    100    101  1842           0             0           0             0
    ##  3    100    101  1843           0             0           0             0
    ##  4    100    101  1844           0             0           0             0
    ##  5    100    101  1845           0             0           0             0
    ##  6    100    101  1846           0             0           0             0
    ##  7    100    101  1847           0             0           0             0
    ##  8    100    101  1848           0             0           0             0
    ##  9    100    101  1849           0             0           0             0
    ## 10    100    101  1850           0             0           0             0
    ## # … with 1,057,912 more rows, and 72 more variables: cowmidspell <dbl>,
    ## #   gmlmidspell <dbl>, gwcode1 <dbl>, gwcode2 <dbl>, rivalryno <dbl>,
    ## #   rivalryname <chr>, styear <dbl>, endyear <dbl>, region <chr>, type1 <chr>,
    ## #   type2 <chr>, type3 <chr>, flow2 <dbl>, flow1 <dbl>, smoothflow2 <dbl>,
    ## #   smoothflow1 <dbl>, capdist <dbl>, conttype <dbl>, cowmaj1 <dbl>,
    ## #   cowmaj2 <dbl>, v2x_polyarchy1 <dbl>, polity21 <dbl>, xm_qudsest1 <dbl>,
    ## #   v2x_polyarchy2 <dbl>, polity22 <dbl>, xm_qudsest2 <dbl>, dyadigos <dbl>,
    ## #   milex1 <dbl>, milper1 <dbl>, irst1 <dbl>, pec1 <dbl>, tpop1 <dbl>,
    ## #   upop1 <dbl>, cinc1 <dbl>, milex2 <dbl>, milper2 <dbl>, irst2 <dbl>,
    ## #   pec2 <dbl>, tpop2 <dbl>, upop2 <dbl>, cinc2 <dbl>, cow_defense <dbl>,
    ## #   cow_neutral <dbl>, cow_nonagg <dbl>, cow_entente <dbl>, atop_defense <dbl>,
    ## #   atop_offense <dbl>, atop_neutral <dbl>, atop_nonagg <dbl>,
    ## #   atop_consul <dbl>, mindist <dbl>, leadertransition1 <dbl>,
    ## #   irregular1 <dbl>, n_leaders1 <int>, jan1leadid1 <chr>, dec31leadid1 <chr>,
    ## #   leadertransition2 <dbl>, irregular2 <dbl>, n_leaders2 <int>,
    ## #   jan1leadid2 <chr>, dec31leadid2 <chr>, wbgdp2011est1 <dbl>,
    ## #   wbpopest1 <dbl>, sdpest1 <dbl>, wbgdp2011est2 <dbl>, wbpopest2 <dbl>,
    ## #   sdpest2 <dbl>, rugged1 <dbl>, newlmtnest1 <dbl>, rugged2 <dbl>,
    ## #   newlmtnest2 <dbl>, prd <dbl>

``` r
toc()
```

    ## 87.831 sec elapsed

``` r
# state-years now...

tic()
create_stateyears() %>%
  add_gwcode_to_cow() %>%
  add_ucdp_onsets() %>%
  add_capital_distance() %>%
  add_contiguity() %>%
  add_cow_majors() %>%
  add_cow_trade() %>%
  add_democracy() %>%
  add_igos() %>%
  add_minimum_distance(system = "cow") %>%
  add_archigos() %>%
  add_nmc() %>%
  add_sdp_gdp(system = "cow") 
```

    ## # A tibble: 16,731 x 39
    ##    ccode statenme           year gwcode sumnewconf sumonset1 sumonset2 sumonset3
    ##    <dbl> <chr>             <dbl>  <dbl>      <dbl>     <dbl>     <dbl>     <dbl>
    ##  1     2 United States of…  1816      2          0         0         0         0
    ##  2     2 United States of…  1817      2          0         0         0         0
    ##  3     2 United States of…  1818      2          0         0         0         0
    ##  4     2 United States of…  1819      2          0         0         0         0
    ##  5     2 United States of…  1820      2          0         0         0         0
    ##  6     2 United States of…  1821      2          0         0         0         0
    ##  7     2 United States of…  1822      2          0         0         0         0
    ##  8     2 United States of…  1823      2          0         0         0         0
    ##  9     2 United States of…  1824      2          0         0         0         0
    ## 10     2 United States of…  1825      2          0         0         0         0
    ## # … with 16,721 more rows, and 31 more variables: sumonset5 <dbl>,
    ## #   sumonset10 <dbl>, mincapdist <dbl>, land <dbl>, sea <dbl>, cowmaj <dbl>,
    ## #   imports <dbl>, exports <dbl>, v2x_polyarchy <dbl>, polity2 <dbl>,
    ## #   xm_qudsest <dbl>, sum_igo_full <dbl>, sum_igo_associate <dbl>,
    ## #   sum_igo_observer <dbl>, sum_igo_anytype <dbl>, minmindist <dbl>,
    ## #   leadertransition <dbl>, irregular <dbl>, n_leaders <int>, jan1leadid <chr>,
    ## #   dec31leadid <chr>, milex <dbl>, milper <dbl>, irst <dbl>, pec <dbl>,
    ## #   tpop <dbl>, upop <dbl>, cinc <dbl>, wbgdp2011est <dbl>, wbpopest <dbl>,
    ## #   sdpest <dbl>

``` r
toc()
```

    ## 8.819 sec elapsed
