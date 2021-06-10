# rmarkdown::render("ms.Rmd", output_file="doc/ms.docx", rmarkdown::word_document(reference_docx = stevetemplates::templ_word()))
# ^ old, legacy, here if you want to revert to it.

rmarkdown::render("ms.Rmd", output_file="doc/ms.docx",
                  bookdown::word_document2(reference_docx = stevetemplates::templ_word(),
                                           toc = FALSE, number_sections = FALSE))

# ^ {bookdown} has table/figure cross-ref ability.
