sietch.pdf: sietch.tex sietch.bib
	$(MAKE) pdf

LATEX=pdflatex

.PHONY: pdf
pdf:
	printf '\\renewcommand{\\docversion}{Version %s}' "$$(git describe --tags --abbrev=6)" |tee sietch.ver
	# If $(LATEX) fails, touch an input so that 'make' won't think it is up-to-date next time.
	rm -f sietch.aux sietch.bbl sietch.blg sietch.brf sietch.bcf
	$(LATEX) sietch.tex
	biber sietch
	$(LATEX) sietch.tex
	$(LATEX) sietch.tex
	$(LATEX) sietch.tex 
	evince sietch.pdf

.PHONY: clean
clean:
	rm -f sietch.dvi sietch.pdf sietch.bbl sietch.blg sietch.brf sietch.toc sietch.aux sietch.out sietch.log sietch.bcf sietch.run.xml sietch.ver
