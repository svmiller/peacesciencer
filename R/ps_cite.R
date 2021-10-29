#' Get \code{BibTeX} Entries Associated with \pkg{peacesciencer} Data and Functions
#'
#' @description \code{ps_cite()} allows the user to get citations to scholarship that they
#' should include in their papers that incorporate the functions and data in this package.
#'
#' @return \code{ps_cite()} takes a character vector and scans the \code{ps_bib} data in
#' this package to return a \code{BibTeX} citation (or citations) for the researcher to use
#' to properly cite the material they are getting from this package. The citations
#' are returned as a full \code{BibTeX} entry (or entries) that they can copy-paste into their
#' own \code{BibTeX} file.
#'
#' @details The base functionality here is simple pattern-matching on keywords in \code{ps_bib}. This
#' simple pattern-matching is in base R. I assume the user has some familiarity with \code{BibTeX}.
#'
#' @author Steven V. Miller
#'
#' @param x a character vector
#' @param column a character vector for the particular column of \code{ps_bib} the user wants to search. The default here is `"keywords"`,
#' which searches the \code{KEYWORDS} column in \code{ps_bib} for the most general search. The other option is `"bibtexkey"`, which will
#' search the `BIBTEXKEY` column in `ps_bib`. Use the latter option more for pairing with output from \code{ps_version()}
#'
#'
#' @examples
#'
#' # You can cite the package
#' ps_cite("peacesciencer")
#'
#' # You can do partial matching
#' ps_cite("democracy")
#'
#' # Or more partial matching
#' ps_cite("alliance")
#'
#' # You can also get all citations for a particular function
#' ps_cite("add_archigos()")
#'
#' # If you know some of the `BibTeX` keys, you can search there as well.
#' ps_cite("gibler", column = "bibtexkey")
#'

ps_cite <- function(x, column = "keywords") {

  if (column == "keywords") {

    ps_bib %>% filter(grepl(x, .data$KEYWORDS)) %>% df2bib()

  } else if (column == "bibtexkey") {

    ps_bib %>% filter(grepl(x, .data$BIBTEXKEY)) %>% df2bib()


  }

}
