# Specify a few variables to avoid repetition downstream

OUTPUTS=doc/ms.pdf doc/ms-anon.pdf doc/ms.html doc/abstract.pdf
RDS=  data/modDD.rds data/modCW.rds

# Specify the primary targets: the outputs
# Also have a clean option for testing

all: $(OUTPUTS)
refs: inst/refs.bib

clean:
	rm -rf doc/* data/*

.PHONY: clean

# Specialty sourcing for each output

doc/ms.pdf:	ms.Rmd $(RDS)
	Rscript -e 'source("src/render_pdf.R")'

doc/ms-anon.pdf: ms.Rmd $(RDS)
	Rscript -e 'source("src/render_pdf-anon.R")'

#doc/ms.docx: ms.Rmd $(RDS)
#	Rscript -e 'source("src/render_docx.R")'

doc/ms.html:	ms.Rmd
	Rscript -e 'source("src/render_html.R")'

doc/abstract.pdf:	ms.Rmd
	Rscript -e 'source("src/render_abstract.R")'

inst/refs.bib: ms.Rmd
	Rscript -e 'source("src/get_citations.R")'

# Specify what to do for each target .rds

data/modCW.rds: R/3-gw-civil-conflict-onset.R
	Rscript -e 'source("R/3-gw-civil-conflict-onset.R")'


#data/Times.rds: R/2-dangerous-dyads-prd-times.R
#	Rscript -e 'source("R/2-dangerous-dyads-prd-times.R")'

data/modDD.rds: R/1-dangerous-dyads-prd.R
	Rscript -e 'source("R/1-dangerous-dyads-prd.R")'

