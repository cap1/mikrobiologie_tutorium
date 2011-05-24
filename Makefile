GNUPLOT = $(addsuffix .pdf, $(basename $(wildcard *.plot)))
INKSCAPE = $(addsuffix .pdf, $(basename $(wildcard *.svg)))
DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all
#	okular ./thesis.pdf 2> /dev/null

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	pdflatex --halt-on-error --output-directory=./tmp ./sections/title.tex
	pdflatex --halt-on-error --output-directory=./tmp ./sections/title.tex
	mv ./tmp/title.pdf .
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
	bibtex ./tmp/thesis
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
	mv ./tmp/thesis.pdf .

evince:
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
#	pdflatex --halt-on-error --output-directory=./tmp ./title.tex
	bibtex ./tmp/thesis
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
	pdflatex --halt-on-error --output-directory=./tmp ./thesis.tex
	cp ./tmp/thesis.pdf .
	evince ./thesis.pdf 2> /dev/null

%.pdf: %.plot *.dat
#	gnuplot $(basename $@).plot 2> $(basename $@).log
#	touch $(basename $@).pdf
#	epstopdf $(basename $@).eps

%.pdf: %.svg
	inkscape $(basename $@).svg --export-eps=$(basename $@).eps
	epstopdf $(basename $@).eps

%.pdf: %.eps
	epstopdf $(basename $@).eps

.PHONY: clean
clean:
	-rm -f ./tmp/*~ ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

replot:
	for i in `find -type f ! -wholename \*.svn\* | grep .dat`; do touch $$i; echo $$i getoucht.; done
#	for i in `find -type f ! -wholename \*.svn\* | grep .plot`; do touch $$i; echo $$i getoucht.; done
	make all

.PHONY: all-evince
all-evince: show
