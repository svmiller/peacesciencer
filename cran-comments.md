## Test environments

* ubuntu 18.04, R 4.0.3

## Comments to CRAN after first-round rejection

I thank CRAN for reminding me that I moved the user's guide. The time issue with the `add_strategic_rivalries()` function is a bit of surprise. I now made that a "don't test" as I have with some of the other, more time-consuming functions.

## R CMD check results, Other Comments

R CMD check done via `devtools::check()`, resulting in 0 errors, 0 warnings, and 0 notes. This release includes the removal of a deprecated function, which triggered a warning in the last update. All tests passed.

CRAN's check log also identifies many UTF-8 strings, though I think don't think these issues in the check log are ultimately actionable or problematic.

`devtools::spell_check()` suggests several spelling errors. However, what I submit to CRAN includes only the false positives. Almost all of these false positives occur in the R Documentation files and concern proper nouns (e.g. data set authors) or peculiar terms that are unfamiliar in the R programming context (e.g. "dyad"). 

## Downstream dependencies

There are no downstream dependencies to note.
