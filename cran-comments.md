## Test environments

* Pop! OS 22.04, R 4.1.2

## R CMD check results, Other Comments

R CMD check done via `devtools::check()`, resulting in 0 errors, 0 warnings, and 0 notes. 

`devtools::spell_check()` suggests several spelling errors. However, what I submit to CRAN includes only the false positives. Almost all of these false positives occur in the R Documentation files and concern proper nouns (e.g. data set authors) or peculiar terms that are unfamiliar in the R programming context (e.g. "dyad"). 

I disabled the bulk of the tests after a comment raised in an email by Brian Ripley that my testing approach was overzealously hogging CRAN's testing computers. This was obviously selfish on my part and based on a misunderstanding of the kind of quality control CRAN would do, in batch, for all its packages. As a result, any testing is done on my end and independent of CRAN as a kind of quality control that doesn't overwhelm CRAN's resources.

I want to highlight two other things with this release, both minor in scale. For one, the release of this package is accelerated by a separate note that primarily concerned `{stevemisc}` regarding the use of `order()` on a data frame. Fixing that needed to come before fixing how this package (a downstream dependency) used the function affected by that note. That fix is now on CRAN as part of `{stevemisc}` 1.6.0. There was another small comment about the use of the `{lifecycle}` package, which I have also addressed.

## Downstream dependencies

There are no downstream dependencies to note.
