## Test environments

* ubuntu 18.04, R 4.0.3

## R CMD check results

R CMD check done via `devtools::check()`, resulting in 0 errors, 0 warnings, and 0 notes.

A manual inspection identified DOI links that needed to be fixed, which I've done in this release. I also fixed the documentation mismatch that the manual inspection found.

`devtools::spell_check()` suggests several spelling errors. However, what I submit to CRAN includes only the false positives. Almost all of these false positives occur in the R Documentation files and concern proper nouns (e.g. data set authors) or peculiar terms that are unfamiliar in the R programming context (e.g. "dyad"). 

`devtools::check_rhub()` suggested a few handshake errors for otherwise valid URLs that would render in a browser. These concerned source/detail URLs for the `LTPT` and `LTWT` documentation files. Rather than fight it, or try to belabor the point to CRAN, I elected to remove the URLs in lieu of text descriptions of these URLs. There are still two notes that emerge from this check. One is a possibly misspelled word in the DESCRIPTION entry ("workflow"). That is a false positive. The other is the size of the data directory, which I explained above should not be happening.

## Downstream dependencies

There are no downstream dependencies to note.
