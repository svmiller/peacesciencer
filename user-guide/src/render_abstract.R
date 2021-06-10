library(rmarkdown)
library(ymlthis)
library(magrittr)

YAML <- yaml_front_matter("ms.Rmd")

YAML[names(YAML) %in% c("title","author","abstract","keywords","geometry","mainfont", "params")] %>%
  as_yml() -> A

A %>%
  yml_rticles_opts(header_includes = "\\pagenumbering{gobble}") -> A

yaml::write_yaml(A, file="doc/tmp.yml")

cat(paste0("---\n",readr::read_file("doc/tmp.yml"), "\n---"), file="doc/tmp.Rmd")


rmarkdown::render("doc/tmp.Rmd", output_file="abstract.pdf",
                  params=list(anonymous=TRUE,doublespacing=TRUE,removetitleabstract=TRUE,
                              ps_website = "[LINK REDACTED FOR PEER REVIEW]"),
                  bookdown::pdf_document2(template = stevetemplates::templ_article2(),
                                          latex_engine = "xelatex", dev= "cairo_pdf",
                                          toc = FALSE, number_sections = FALSE))

# render("doc/tmp.Rmd",
#        output_file="abstract.pdf",
#        params=list(ps_website = "[LINK REDACTED FOR PEER REVIEW]"),
#        bookdown::pdf_document2(template = stevetemplates::templ_article2(),
#                                latex_engine = "xelatex", dev= "cairo_pdf",
#                                toc = FALSE, number_sections = FALSE))

delfiles <- dir(path="doc/" ,pattern="tmp")
file.remove(file.path("doc/", delfiles))

# disabled for now...

#tmp <- use_index_rmd(.yml = print(A), path='_dross', open_doc = FALSE)
# render(tmp,
#        output_file="abstract.pdf",
#        rmarkdown::pdf_document(template = stevetemplates::templ_article2(),
#                                           latex_engine = "xelatex", dev="cairo_pdf"))
# file.remove(tmp)
