## Test environments

* ubuntu 18.04, R 4.0.3

## R CMD check results and Feedback From/Responses to CRAN

R CMD check done via `devtools::check()`, resulting in 0 errors, 0 warnings, and 0 notes. All tests passed.

A manual inspection identified DOI links that needed to be fixed, which I've done in this release. I also fixed the documentation mismatch that the manual inspection found.

CRAN's automated checks result in a a NAMESPACE/DESCRIPTION issue, largely concerning the `countrycode` and `tibble` package. From what I gathered, I had declared these as imports in the DESCRIPTION file, but did not directly use them in the package. On CRAN's end, I think it saw them in the imports and expected to see something from them in NAMESPACE. Under these conditions, I think it makes sense to move both `countrycode` and `tibble` to the `suggests:` field in DESCRIPTION. Neither are strictly necessary for this package.

CRAN's check log also identifies 116 UTF-8 strings, though I think these are false positives.

`devtools::spell_check()` suggests several spelling errors. However, what I submit to CRAN includes only the false positives. Almost all of these false positives occur in the R Documentation files and concern proper nouns (e.g. data set authors) or peculiar terms that are unfamiliar in the R programming context (e.g. "dyad"). 

## Downstream dependencies

There are no downstream dependencies to note.
