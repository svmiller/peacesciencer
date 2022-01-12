rmarkdown::render("ms.Rmd",
                  output_file="../docs/ms.html",
                  params=list(ps_website = "http://svmiller.com/peacesciencer",
                              ps_manuals = "http://svmiller.com/peacesciencer/reference",
                              ps_github = "https://github.com/svmiller/peacesciencer/"),
                  bookdown::html_document2(template = stevetemplates::templ_html_article(),
                                           toc = FALSE, number_sections = FALSE))
