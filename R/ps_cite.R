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
#' # Cite the package
#' ps_cite("peacesciencer")
#'
#'

ps_cite <- function(x, column = "keywords") {

  if (column == "keywords") {

    #ps_bib %>% filter(grepl(x, .data$KEYWORDS)) %>% df2bib()
    ps_bib %>% filter(grepl(x, .data$KEYWORDS)) -> cites_i_want

  } else if (column == "bibtexkey") {

    # ps_bib %>% filter(grepl(x, .data$BIBTEXKEY)) %>% df2bib()
    ps_bib %>% filter(grepl(x, .data$BIBTEXKEY)) -> cites_i_want


  }

  not_all_na <- function(x) any(!is.na(x))

  cites_i_want %>%
    group_split(.data$BIBTEXKEY) -> group_split_cites

  lapply(group_split_cites, function(x) select_if(x, not_all_na)) -> group_split_cites


  suppressWarnings(
  for(i in 1:length(group_split_cites)) {
    group_split_cites[[i]]$AUTHOR <- group_split_cites[[i]]$AUTHOR %>% unlist(.data$AUTHOR) %>% paste(., collapse = " and ")
    group_split_cites[[i]]$EDITOR <- group_split_cites[[i]]$EDITOR %>% unlist(.data$EDITOR) %>% paste(., collapse = " and ")
  }
  )


  lapply(group_split_cites, function(x) mutate(x,  EDITOR = ifelse(.data$EDITOR == "", NA, .data$EDITOR))) -> group_split_cites
  lapply(group_split_cites, function(x) select_if(x, not_all_na)) -> group_split_cites


  for(i in 1:length(group_split_cites)) {
    tibble(x = names(unlist(group_split_cites[[i]])),
           y = unlist(group_split_cites[[i]])) -> hold_this

    hold_this %>% filter((x %in% c("BIBTEXKEY", "CATEGORY"))) -> hold_this_a
    hold_this %>% filter(!(x %in% c("BIBTEXKEY", "CATEGORY"))) -> hold_this_b

    print_the_thing_already <- cat(paste0("@", hold_this_a$y[1],
                       "{", hold_this_a$y[2],",\n",
                       paste0("  ",
                              hold_this_b$x,
                              " = {",
                              hold_this_b$y,
                              "}",
                              collapse = ",\n"),"}"),
                collapse = "\n\n",
                #fill=TRUE,
                file = "",
                append = TRUE)
    invisible(file)
  }

}
