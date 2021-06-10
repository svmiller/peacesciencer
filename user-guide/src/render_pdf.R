# rmarkdown::render("ms.Rmd",
#                   output_file="doc/ms.pdf",
#                   rmarkdown::pdf_document(template = stevetemplates::templ_article2(),
#                                           latex_engine = "xelatex", dev="cairo_pdf"))
# ^ old, legacy, here if you want to revert to it.


rmarkdown::render("ms.Rmd",
                  output_file="doc/ms.pdf",
                  bookdown::pdf_document2(template = stevetemplates::templ_article2(),
                                          keep_tex = TRUE,
                                          latex_engine = "xelatex", dev="cairo_pdf",
                                          toc = FALSE, number_sections = FALSE))

# ^ {bookdown} has table/figure cross-ref ability.
