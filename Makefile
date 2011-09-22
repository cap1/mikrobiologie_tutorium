DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	epstopdf ./pictures/ecoli_plot.eps
	epstopdf ./pictures/stoffwechsel.eps
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	bibtex ./tmp/document
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .

evince:
	epstopdf ./pictures/*.eps
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	bibtex ./tmp/document
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .
	evince document.pdf &> /dev/null

okular:
	epstopdf ./pictures/*.eps
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	bibtex ./tmp/document
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .
	okular ./document.pdf 2> /dev/null

%.pdf: %.eps
	epstopdf $(basename $@).eps

clean:
	-rm -f ./tmp/*~ ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

all-evince: show
