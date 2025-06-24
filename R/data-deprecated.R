#' @title Data sets that have been deprecated
#'
#' @description These are data sets that have been deprecated and scheduled for
#' removal, or data that have since been removed after deprecation. Data sets
#' may be deprecated either by insistence of the data set's author, because they
#' will be relocated to another package for future development, or because the
#' data themselves are legacy data no longer in active demand or use in the
#' community. Deprecation and removal have the effect of also freeing up disk
#' space given CRAN's 5 MB limitation for R packages.
#'
#' @docType data
#' @name data-deprecated
#' @keywords internal deprecated
#' @format Users interested in the data referenced here can check the Github
#' repository associated with the package. The scripts that generated them are
#' available in the `data-raw/` directory. Previous versions of the data are
#' available in CRAN archives as well.
NULL

#' @rdname data-deprecated
#' @name cow_alliance
#' @details \code{cow_alliance} is defunct. The data set's maintainer requests
#' that users who want the Correlates of War alliance data in their analyses
#' should download and process the data manually, without assistance of any
#' convenience functions.
"cow_alliance"


#' @rdname data-deprecated
#' @name ccode_democracy
#' @details \code{ccode_democracy} is defunct. The data are now maintained in
#' the \pkg{isard} package as \code{cw_democracy}.
"ccode_democracy"


#' @rdname data-deprecated
#' @name gwcode_democracy
#' @details \code{gwcode_democracy} is defunct. The data are now maintained in
#' the \pkg{isard} package as \code{gw_democracy}.
"gwcode_democracy"


#' @rdname data-deprecated
#' @name cow_sdp_gdp
#' @details \code{cow_sdp_gdp} is defunct. The data are now maintained in
#' the \pkg{isard} package as \code{cw_gdppop}.
"cow_sdp_gdp"


#' @rdname data-deprecated
#' @name gw_sdp_gdp
#' @details \code{gw_sdp_gdp} is defunct. The data are now maintained in
#' the \pkg{isard} package as \code{gw_gdppop}.
"gw_sdp_gdp"
