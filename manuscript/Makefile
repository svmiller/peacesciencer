# Specify a few variables to avoid repetition downstream

OUTPUTS= ../docs/ms.pdf doc/ms-anon.pdf ../docs/ms.html doc/abstract.pdf inst/refs.bib ../docs/appendix.pdf
RDS=  data/modDD.rds data/modCW.rds data/modLY.rds

# Specify the primary targets: the outputs
# Also have a clean option for testing

all: $(OUTPUTS)
data: $(RDS)
refs: inst/refs.bib

clean:
	rm -rf doc/* data/*

.PHONY: clean

# Specialty sourcing for each output

../docs/appendix.pdf: appendix.Rmd
	Rscript -e 'source("src/render_appendix.R")'

doc/appendix-anon.pdf: appendix.Rmd
	Rscript -e 'source("src/render_appendix-anon.R")'

doc/memo.docx: memo.Rmd
	Rscript -e 'rmarkdown::render("memo.Rmd", output_file="doc/memo.docx", bookdown::word_document2(reference_docx = stevetemplates::templ_word(), toc = FALSE, number_sections = FALSE))'

doc/memo.pdf: memo.Rmd
	Rscript -e 'rmarkdown::render("memo.Rmd", output_file="doc/memo.pdf", bookdown::pdf_document2(template = stevetemplates::templ_cover_letter(), citation_package = "natbib", latex_engine = "xelatex",  number_sections = FALSE))'

../docs/ms.pdf:	ms.Rmd $(RDS)
	Rscript -e 'source("src/render_pdf.R")'

doc/ms-anon.pdf: ms.Rmd $(RDS)
	Rscript -e 'source("src/render_pdf-anon.R")'

#doc/ms.docx: ms.Rmd $(RDS)
#	Rscript -e 'source("src/render_docx.R")'

../docs/ms.html:	ms.Rmd
	Rscript -e 'source("src/render_html.R")'

doc/abstract.pdf:	ms.Rmd
	Rscript -e 'source("src/render_abstract.R")'

inst/refs.bib: ms.Rmd
	Rscript -e 'source("src/get_citations.R")'

# Specify what to do for each target .rds

data/modCW.rds: R/2-gw-civil-conflict-onset.R
	Rscript -e 'source("R/2-gw-civil-conflict-onset.R")'

data/modDD.rds: R/1-dangerous-dyads-prd.R
	Rscript -e 'source("R/1-dangerous-dyads-prd.R")'

data/modLY.rds: R/3-cow-leader-year-initiation.R
	Rscript -e 'source("R/3-cow-leader-year-initiation.R")'
