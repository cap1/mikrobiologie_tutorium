DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all
#	okular ./thesis.pdf 2> /dev/null

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .

evince:
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	pdflatex --halt-on-error --output-directory=./tmp ./document.tex
	mv ./tmp/document.pdf .
	evince document.pdf &> /dev/null

clean:
	-rm -f ./tmp/*~ ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

all-evince: show
