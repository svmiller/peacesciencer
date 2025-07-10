
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
