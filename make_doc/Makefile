# Makefile di esempio per la compilazione automatica di documenti
# LaTeX in vari formati.

# file name prefix.
DOC_PREFIX=example

default:\
clean_all\
pdf

all:    \
clean_all   \
text    \
html    \
ps      \
pdf


clean_all: clean
	@rm -f *.dvi;\
	rm -f *.ps;\
	rm -f *.pdf;\
	rm -f *.txt;\
	rm -Rf $(DOC_PREFIX)

clean:
	@echo -e "\\033[1mCleaning...\\033[0m"; \
	rm -f *.aux; \
	rm -f *.bbl; \
	rm -f *.log; \
	rm -f *.lof;\
	rm -f *.lot;\
	rm -f *.toc;\
	rm -f *.out;\
	rm -f *.bak; \
	rm -f *\~

dvi:
	@echo -e "\\033[1mConverting to DVI...\\033[0m"; \
	texi2dvi $(DOC_PREFIX).tex

ps:
	@echo -e "\\033[1mConverting to PS...\\033[0m"; \
	texi2dvi $(DOC_PREFIX).tex;\
	dvips $(DOC_PREFIX).dvi -o

pdf:
	@./eps2pdf.sh;\
	echo -e "\\033[1mConverting to PDF...\\033[0m"; \
	texi2pdf $(DOC_PREFIX).tex

html:
	@echo -e "\\033[1mConverting to HTML...\\033[0m"; \
	latex2html $(DOC_PREFIX).tex

text:
	@echo -e "\\033[1mConverting to Text...\\033[0m"; \
	latex2html\
	-split 0\
	-ascii_mode\
	-nonavigation\
	$(DOC_PREFIX).tex;\
	lynx -dump\
	     -nolist\
	     -dont_wrap_pre\
	     $(DOC_PREFIX)/index.html\
	      > $(DOC_PREFIX).txt;\
	rm -f *.html;\
	rm -f *.css;\
	rm -f labels.pl
