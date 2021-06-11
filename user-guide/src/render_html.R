rmarkdown::render("ms.Rmd",
                  output_file="../docs/ms.html",
                  bookdown::html_document2(template = stevetemplates::templ_html_article(),
                                           toc = FALSE, number_sections = FALSE))
