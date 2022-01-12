the_output <- "latex"

rmarkdown::render("appendix.Rmd", output_file="doc/appendix-anon.pdf",
                  params=list(anonymous=TRUE,doublespacing=TRUE),
                  bookdown::pdf_document2(template = stevetemplates::templ_article2(),
                                          latex_engine = "xelatex", dev= "cairo_pdf",
                                          toc = FALSE,
                                          number_sections = FALSE, keep_tex = FALSE))
