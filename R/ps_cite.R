#' Get \code{BibTeX} Entries Associated with `{peacesciencer}` Data and Functions
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

ps_cite <- function(x) {

  ps_bib %>% filter(grepl(x, KEYWORDS)) %>% df2bib()

}
