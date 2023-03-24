
# `peacesciencer`: Tools and Data for Quantitative Peace Science

[![](https://www.r-pkg.org/badges/version/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/grand-total/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/last-month/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)
[![](http://cranlogs.r-pkg.org/badges/last-week/peacesciencer?color=green)](https://cran.r-project.org/package=peacesciencer)

<img src="http://svmiller.com/images/peacesciencer-hexlogo.png" alt="peacesciencer  hexlogo" align="right" width="200" style="padding: 0 15px; float: right;"/>

`peacesciencer` is an R package including various functions and data
sets to allow easier analyses in the field of quantitative peace
science. The goal is to provide an R package that reasonably
approximates what made EUGene so attractive to scholars working in the
field of quantitative peace science in the early 2000s. EUGene shined
because it encouraged replications of conflict models while having the
user also generate data from scratch. Likewise, this R package will
offer tools to approximate what EUGene did within the R environment
(i.e. not requiring Windows for installation).

<!-- [EUGene](https://journals.sagepub.com/doi/10.1177/0738894211413055) -->

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

# How to Use `{peacesciencer}`

New users should read two things to get started. [The package’s
website](http://svmiller.com/peacesciencer/index.html) has an exhaustive
list and description of [all the functions and data
included](http://svmiller.com/peacesciencer/reference/index.html) in the
package. [`{peacesciencer}` has a user’s
guide](http://svmiller.com/peacesciencer/ms.pdf) that is worth reading.
The user’s guide points to its potential uses and benefits while also
offering some encouragement for those completely new to the R
programming language. The package is designed to be accessible to those
with no prior experience with R, though completely new users who feel
lost or overwhelmed should learn about [the “tidy” approach to
R](https://www.tidyverse.org/) to help them get started.

The workflow is going to look something like this. First, start with one
of two processes to create either dyad-year or state-year data. The
dyad-year data are created with the `create_dyadyears()` function. It
has a few optional parameters with hidden defaults. The user can specify
what kind of state system (`system`) data they want to use—either
Correlates of War (`"cow"`) or Gleditsch-Ward (`"gw"`), whether they
want to extend the data to the most recently concluded calendar year
(`mry`) (i.e. Correlates of War state system membership data are current
as of Dec. 31, 2016 and the script can extend that to the end of the
most recently concluded calendar year), and whether the user wants
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

Here’s what this will look like in operation. Assume you want to create
some data for something analogous to a “dangerous dyads” design for all
non-directed dyad-years. Here’s how you’d do it in `{peacesciencer}`,
which is going to be lifted from the source R scripts for the user’s
guide. The first part of this code chunk will lean on core
`{peacesciencer}` functionality whereas the other stuff is some
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
#>  1 (Intercept)      -3.06      0.0635         -48.2  0        
#>  2 landcontig        1.06      0.0568          18.7  4.21e- 78
#>  3 cincprop          0.455     0.0363          12.5  6.63e- 36
#>  4 cowmajdyad        0.144     0.0575           2.51 1.20e-  2
#>  5 cow_defense      -0.119     0.0580          -2.04 4.09e-  2
#>  6 mindemest        -0.499     0.0525          -9.51 1.93e- 21
#>  7 minwbgdppc        0.293     0.0511           5.72 1.06e-  8
#>  8 minmilit          0.255     0.0226          11.3  2.02e- 29
#>  9 gmlmidspell      -0.147     0.00505        -29.0  5.33e-185
#> 10 I(gmlmidspell^2)  0.00247   0.000135        18.4  2.74e- 75
#> 11 I(gmlmidspell^3) -0.0000116 0.000000891    -13.0  1.16e- 38
toc()
#> 7.35 sec elapsed
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
#>  1 (Intercept)        -5.10      1.35         -3.77  0.000160
#>  2 l1_wbgdppc2011est  -0.285     0.110        -2.59  0.00953 
#>  3 l1_wbpopest         0.229     0.0672        3.41  0.000644
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
#>  1 (Intercept)        -6.59      2.08         -3.16  0.00156
#>  2 l1_wbgdppc2011est  -0.343     0.172        -1.99  0.0463 
#>  3 l1_wbpopest         0.272     0.106         2.56  0.0105 
#>  4 l1_xm_qudsest      -0.0847    0.270        -0.313 0.754  
#>  5 I(l1_xm_qudsest^2) -0.761     0.352        -2.16  0.0307 
#>  6 newlmtnest          0.342     0.112         3.05  0.00226
#>  7 ethfrac             0.333     0.554         0.601 0.548  
#>  8 relfrac            -0.281     0.593        -0.474 0.635  
#>  9 war_ucdpspell      -0.111     0.0562       -1.98  0.0478 
#> 10 I(war_ucdpspell^2)  0.00466   0.00252       1.85  0.0643 
#> 11 I(war_ucdpspell^3) -0.0000499 0.0000302    -1.65  0.0982

toc()
#> 2.315 sec elapsed
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
#> @ARTICLE{peacesciencer-package,
#>   AUTHOR = {Steven V. Miller},
#>   JOURNAL = {Conflict Management and Peace Science},
#>   TITLE = {peacesciencer}: An R Package for Quantitative Peace Science Research},
#>   YEAR = {2022},
#>   KEYWORDS = {peacesciencer, add_capital_distance(), add_ccode_to_gw(), add_gwcode_to_cow(), capitals},
#>   URL = {http://svmiller.com/peacesciencer/}}
```

You can see what are the relevant citations to consider using for the
data returned by `add_democracy()`

``` r
ps_cite("add_democracy()")
#> @UNPUBLISHED{coppedgeetal2020vdem,
#>   AUTHOR = {Michael Coppedge and John Gerring and Carl Henrik Knutsen and Staffan I. Lindberg and Jan Teorell and David Altman and Michael Bernhard and M. Steven Fish and Adam Glynn and Allen Hicken and Anna Luhrmann and Kyle L. Marquardt and Kelly McMann and Pamela Paxton and Daniel Pemstein and Brigitte Seim and Rachel Sigman and Svend-Erik Skaaning and Jeffrey Staton and Agnes Cornell and Lisa Gastaldi and Haakon Gjerl{\o}w and Valeriya Mechkova and Johannes von R{\"o}mer and Aksel Sundtr{\"o}m and Eitan Tzelgov and Luca Uberti and Yi-ting Wang and Tore Wig and Daniel Ziblatt},
#>   NOTE = {Varieties of Democracy ({V}-{D}em) Project},
#>   TITLE = {V-Dem Codebook v10},
#>   YEAR = {2020},
#>   KEYWORDS = {add_democracy(), v-dem, varieties of democracy}} 
#> 
#> @UNPUBLISHED{marquez2016qme,
#>   AUTHOR = {Xavier Marquez},
#>   NOTE = {Available at SSRN: http://ssrn.com/abstract=2753830},
#>   TITLE = {A Quick Method for Extending the {U}nified {D}emocracy {S}cores},
#>   YEAR = {2016},
#>   KEYWORDS = {add_democracy(), UDS, Unified Democracy Scores},
#>   URL = {http://dx.doi.org/10.2139/ssrn.2753830}} 
#> 
#> @UNPUBLISHED{marshalletal2017p,
#>   AUTHOR = {Monty G. Marshall and Ted Robert Gurr and Keith Jaggers},
#>   NOTE = {University of Maryland, Center for International Development and Conflict Management},
#>   TITLE = {Polity {IV} Project: Political Regime Characteristics and Transitions, 1800-2016},
#>   YEAR = {2017},
#>   KEYWORDS = {add_democracy(), polity}} 
#> 
#> @ARTICLE{pemsteinetal2010dc,
#>   AUTHOR = {Pemstein, Daniel and Stephen A. Meserve and James Melton},
#>   JOURNAL = {Political Analysis},
#>   NUMBER = {4},
#>   PAGES = {426--449},
#>   TITLE = {Democratic Compromise: A Latent Variable Analysis of Ten Measures of Regime Type},
#>   VOLUME = {18},
#>   YEAR = {2010},
#>   KEYWORDS = {add_democracy(), UDS, Unified Democracy Scores},
#>   OWNER = {steve},
#>   TIMESTAMP = {2011.01.30}}
```

You can also return partial matches to see what citations are associated
with, say, alliance data in this package.

``` r
ps_cite("alliance")
#> @BOOK{gibler2009ima,
#>   AUTHOR = {Douglas M. Gibler},
#>   PUBLISHER = {Washington DC: CQ Press},
#>   TITLE = {International Military Alliances, 1648-2008},
#>   YEAR = {2009},
#>   KEYWORDS = {add_cow_alliance()}} 
#> 
#> @ARTICLE{leedsetal2002atop,
#>   AUTHOR = {Bretty Ashley Leeds and Jeffrey M. Ritter and Sara McLaughlin Mitchell and Andrew G. Long},
#>   JOURNAL = {International Interactions},
#>   PAGES = {237--260},
#>   TITLE = {Alliance Treaty Obligations and Provisions, 1815-1944},
#>   VOLUME = {28},
#>   YEAR = {2002},
#>   KEYWORDS = {add_atop_alliance()}}
```

This function might expand in complexity in future releases, but you can
use it right now for finding appropriate citations. You an also scan the
`ps_bib` data to see what is in there.

# Issues/Requests

`{peacesciencer}` is already more than capable to meet a wide variety of
needs in the peace science community. Users are free to raise an issue
on the project’s Github if some feature is not performing as they think
it should or if there are additions they would like to see.
