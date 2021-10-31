#' Get Version Information About Data Included in \pkg{peacesciencer}
#'
#' @description \code{ps_version()} allows the user to see version information about data
#' included in \pkg{peacesciencer}.
#'
#' @return \code{ps_version()} takes a character vector and scans the \code{ps_data_version} data in
#' this package to return information about the particular data versions included in \pkg{peacesciencer} as well as a suggested
#' citation key for scanning \code{ps_cite()}. If no category is specified for searching, it just returns all version
#' information for all data included in functions in this package.
#'
#'
#' @details The base functionality here is simple pattern-matching on keywords in \code{ps_data_version}. This
#' simple pattern-matching is in base R. I assume the user has some familiarity with the types of data included in
#' this package.
#'
#' The searching is done by category included in the `ps_data_version` data. Users may want to just minimally run
#' `ps_version()` with no argument specified to see for themselves what's in it. Typing `unique(ps_data_version$category)`
#' may also get them started.
#'
#' The user can consider this a companion function to \code{ps_cite()}. Whereas \code{ps_cite()} will return the appropriate citation
#' to use in the bibliography, it may not tell them the version number at all. For example, the classic and suggested citations for
#' the Correlates of War National Material Capabilities data are too Singer et al. (1972) and Singer (1987), though the data included
#' in this package are about 30 years older than the most recent citation of the two.
#'
#' The information communicated here can/should be included alongside a parenthetical citation. For example, the contiguity data are
#' quite a bit more current than the suggested citation to Stinnett et al. (2002). Thus, a user may want to cite the data in their paper
#' as something like (Stinnett et al. 2002, v. 3.2).
#'
#' @author Steven V. Miller
#'
#' @param category a category of data type the user wants, as a character
#'
#' @examples
#'
#' # What can you search for...
#' unique(ps_data_version$category)
#'
#' # will show the data versions for everything
#' ps_version()
#'
#' # will show data versions for particular categories of data
#' ps_version("democracy")
#'
#' ps_version("leaders")
#'

ps_version <- function(category) {

  if (missing(category)) {
    ps_data_version -> output
  } else {
    ps_data_version %>% filter(grepl(category, .data$category)) -> output
  }

  return(output)
}
