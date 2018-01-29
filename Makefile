##

PAPERNAME = mptcp
#TOFOLDER = /mnt/hgfs/SharedFolder/
TOFOLDER = /mnt/c/Users/wenfe/Desktop

TARGETS = paper

TEXFILES = $(wildcard *.tex)
PDFS = $(addsuffix .pdf,$(TARGETS))

all: $(PDFS)

%.pdf: %.tex %.bib %.blg %.toc $(TEXFILES)
	pdflatex $*.tex
	bibtex $*
	pdflatex $*.tex
	pdflatex $*.tex

%.blg: %.bib 
	pdflatex $*.tex
	bibtex $*
	pdflatex $*.tex

%.toc: %.tex
	pdflatex $*.tex

clean:
	/bin/rm -f $(PDFS) *.dvi *.aux *.ps *~ *.log *.out *.lot *.lof *.toc *.blg *.bbl url.sty

FORCE:

evince:
	pdflatex $(TARGETS).tex
	evince $(PDFS) &

acro:
	pdflatex $(TARGETS).tex
	acroread $(PDFS) &

osx:
	pdflatex $(TARGETS).tex
	open $(PDFS)

windows:
	pdflatex $(TARGETS).tex
	explorer.exe $(PDFS) &

home: osx

check:
	pdflatex $(TARGETS).tex | grep -i -e "undefined" -e "multiply"


commit:
	git commit -a
	git push
copy:
	cp $(TARGETS).pdf $(TOFOLDER)/$(PAPERNAME).pdf
