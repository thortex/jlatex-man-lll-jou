#!/bin/sh
#\begin{comment}
## Author  : Thor Watanabe
## date    : 2016/08/01 
## Name    : Makefile
## version : 1.2
#\end{comment}
#\begin{setting}[valiable]
TEX=	uplatex
BIBTEX=	upbibtex
DVIPDFMX=dvipdfmx
MAKEIDX=upmendex
FILE=	jou
#REF=	jou.bib latexbase.bib latexbase2.bib latextools.bib manual.bib
IST=	sind.ist
GST=	sgls.ist
BST=	splain.bst
#\end{setting}
#\begin{setting}[sources]
SRC=	001kuchie.tex \
	002preface.tex \
	003thanx.tex \
	004fwfm.tex \
	01pregame.tex \
	02pre.tex \
	03text.tex \
	04biblio.tex \
	05output.tex \
	06ml.tex \
	07math.tex \
	08graphic.tex \
	09highmath.tex \
	10apply.tex \
	14sample.tex \
	15info.tex \
	fdl.tex 
SRC2=	sampleMakefile \
	jou.dic \
	gnuplot1.tex \
	gnuplot2.tex \
	roji06.tex \
	roji10.tex \
	flow.tex 
STY=	jsbook.cls \
	cite.sty epic.sty eepic.sty indent.sty \
	jlisting.sty  joumac.sty okumacro.sty 
MAC=joumac.sty joumac.dtx joumac.ins joumac.dvi
#\end{setting}
#\begin{target}
all: joumac.sty $(FILE).pdf $(FILE)hyper.pdf cleanany
#
joumac.sty:	joumac.dtx joumac.ins
	$(TEX) joumac.ins
#
joumac.dvi:	joumac.dtx
	$(TEX) joumac.dtx && $(TEX) joumac.dtx
	$(MAKEIDX) -s gind.ist -o joumac.ind joumac.idx
#	$(MAKEIDX) -s gglo.ist -o joumac.gls joumac.glo
	$(TEX) joumac.dtx
	rm -f joumac.aux joumac.glo joumac.idx joumac.ilg
	rm -f joumac.log *~
#
#$(FILE)hyper.tex: $(FILE).tex
#	echo -e "\AtBeginDvi{\special{pdf:tounicode EUC-UCS2}}"\
#	> $(FILE)hyper.tex
#	grep "%" $(FILE).tex >> $(FILE)hyper.tex

$(FILE).ps: $(FILE).dvi
	$(DVIPS) -o $(FILE).ps $(FILE).dvi

$(FILE).pdf: $(FILE).dvi
	$(TEX) $(FILE)
	$(DVIPDFMX) -o $(FILE).pdf $(FILE).dvi

$(FILE)hyper.pdf: cleanany $(FILE)hyper.tex
	$(TEX) $(FILE)hyper
	$(TEX) $(FILE)hyper
	$(MAKEIDX) -s $(IST) -d jou.dic -o $(FILE)hyper.ind $(FILE)hyper.idx
	$(MAKEIDX) -s $(GST) -d jou.dic -o $(FILE)hyper.gls $(FILE)hyper.glo
	$(TEX) $(FILE)hyper
	$(TEX) $(FILE)hyper
	$(DVIPDFMX) -o $(FILE)hyper.pdf $(FILE)hyper

$(FILE).dvi:$(FILE).ind $(FILE).gls# $(FILE).bbl 
	$(TEX) $(FILE) 
	(while egrep "may have changed" $(FILE).log; \
           do $(TEX) $(FILE); done)

$(FILE).ind: $(FILE).idx 
	$(MAKEIDX) -s $(IST) -d jou.dic -o $(FILE).ind $(FILE).idx

$(FILE).gls: $(FILE).glo
	$(MAKEIDX) -s $(GST) -d jou.dic -o $(FILE).gls $(FILE).glo

$(FILE).bbl: $(FILE).aux
	$(BIBTEX) $(FILE)

$(FILE).glo: $(FILE).aux $(SRC)
	$(TEX) $(FILE)

$(FILE).idx: $(FILE).aux $(SRC)
	$(TEX) $(FILE)

$(FILE).aux: $(FILE).tex $(SRC)
	$(TEX) $(FILE)

tar: $(FILE).tex $(STY) $(BST) $(IST) $(GST) $(SRC) $(SRC2) $(REF) \
	Makefile $(MAC)
	mkdir -p $(FILE)src/images && mkdir -p $(FILE)src/sjis
	cp $(REF) $(SRC) $(SRC2) $(IST) $(GST) $(BST) $(STY) $(FILE).tex \
           $(FILE)src/
	cp images/*.* $(FILE)src/images/
	./sjis.sh && cp sjis/*.* $(FILE)src/sjis/
	cp Makefile $(MAC) $(FILE)hyper.tex $(FILE)src/
	tar czf $(FILE)src.tgz $(FILE)src/
	rm -fr $(FILE)src

clean:
	rm -f $(FILE).glo $(FILE).blg $(FILE).lof $(FILE).lot
	rm -f $(FILE).out $(FILE).toc $(FILE).ind $(FILE).aux
	rm -f $(FILE).dvi $(FILE).idx $(FILE).ilg $(FILE).brf
	rm -f $(FILE).gls $(FILE).exa $(FILE).chl

cleanh:
	rm -f $(FILE)hyper.bbl $(FILE)hyper.blg $(FILE)hyper.lof 
	rm -f $(FILE)hyper.lot 
	rm -f $(FILE)hyper.out $(FILE)hyper.toc $(FILE)hyper.ind 
	rm -f $(FILE)hyper.aux
	rm -f $(FILE)hyper.dvi $(FILE)hyper.idx $(FILE)hyper.ilg 
	rm -f $(FILE)hyper.brf $(FILE)hyper.exa
	rm -f $(FILE)hyper.glo $(FILE)hyper.gls

cleanany: clean cleanh
	rm -f *.log *.aux *~ *.flc .DS_Store
#\end{target}
