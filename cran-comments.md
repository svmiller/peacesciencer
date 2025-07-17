## Test environments

* Pop! OS 22.04, R 4.1.2

## R CMD check results, Other Comments

R CMD check done via `devtools::check()`, resulting in 0 errors, 0 warnings, and 0 notes. 

`devtools::spell_check()` suggests several spelling errors. However, what I submit to CRAN includes only the false positives. Almost all of these false positives occur in the R Documentation files and concern proper nouns (e.g. data set authors) or peculiar terms that are unfamiliar in the R programming context (e.g. "dyad"). 

`devtools::check(manual = TRUE, remote = TRUE, incoming = TRUE)` identified any URL redirect issues in advance of submission. This check is always the death of me. It did identify a note about the DOI being forbidden in the `inst/CITATION` file but my review of others who have received this note suggest it's not an issue for CRAN. The DOI itself is valid.

## Downstream dependencies

There are no downstream dependencies to note.
