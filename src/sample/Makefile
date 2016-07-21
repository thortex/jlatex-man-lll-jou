# \begin{setting}[Suffixes]
# \comment{拡張子の登録}
.SUFFIXES: \
	.aux .bb .bbl .bib .blg .bmp .cls .dic .dtx  .dvi  .eps .htm \
	.html .idx .ilg .ind .ins .jpg .jpeg .lof .log .lol .lot .mp \
	.obj .out .pdf .pl .plt .png .ps .sty .tex .toc 
# \end{setting}

# \begin{setting}[Programs]
# \comment{DVI 生成}
TEX=	platex
# \comment{索引生成}
MAKEIDX=mendex
# \comment{DVI \to PDF 生成}
DVIPDF=	dvipdfmx
# \comment{削除}
RM=	rm -f
# \comment{再起的削除}
RMFR=	rm -fr
# \comment{再起的ディレクトリ作成}
MKDIR=	mkdir -p 
# \comment{Make の本体}
AUTOMAKE=make
# \end{setting}

# \begin{setting}[Filenames]
# \comment{基本となるファイル}
F=	main
# \comment{基本となるマクロパッケージ}
M=	mymacros
# \comment{索引スタイル}
IST=	$M.ist 
# \comment{必要となるソース}
SRC=	$(IST) $F.dic $F.tex $F.pdf \
	$M.dtx $M.ins $M.sty $M.pdf \
	Makefile makebb 
# \comment{画像のディレクトリ}
IMG=	img
# \end{setting}

# \begin{setting}[CommandLineOptions]
# \comment{$TEX のオプション}
TEXOPT=		-src-specials
# \comment{$DVIPDF のオプション}
DVIPDFOPT=	-O 2 -p a4 -V 4 -r 1200
# \comment{$DVIPS のオプション}
DVIPSOPT=	-t a4
# \comment{$MAKEIDX のオプション}
IDXOPT=		-s $(IST) -d $F.dic
# \end{setting}

# \begin{setting}[Printer]
# \comment{ラインプリンタ}
LPNAME=	10.24.194.2
# \end{setting}

# \begin{setting}[Programs]
#    \begin{subsetting}[Mac OS X]
# \comment{DVI ファイルプレビューア}
XDVI=	mxdvi  
# \comment{PDF ファイルプレビューア}
PDFVIEWER=open
# \comment{DVI \to PS 生成}
DVIPS=	dvips
#    \end{subsetting}

#    \begin{subsetting}[Linux]
#XDVI=	xdvi # or pxdvi
#PDFVIEWER=acroread
#DVIPS=	dvips # or pdvips
#    \end{subsetting}

#    \begin{subsetting}[Windows + Cygwin]
#XDVI=	/cygdrive/c/dviout/dviout.exe 
#PDFVIEWER=/cygdrive/c/Program\ Files/Adobe/Reader32.exe 
#DVIPS=dvipsk
#    \end{subsetting}
# \end{setting}

# \begin{dependency}
# \comment{標準のターゲット}
all: $F.pdf

$F.dvi: $F.tex
$F.ind: $F.idx
$F.idx: $F.tex
$F.pdf: $F.dvi

$M.dvi: $M.dtx
$M.pdf: $M.dvi
$M.sty: $M.dtx
# \end{dependency}

# \begin{GenerationRules}
.tex.dvi:
	$(TEX) $*; $(TEX) $*;
# \comment{相互参照の解決が終了するまでタイプセットを続ける．
	(while egrep "may have changed" $*.log; do $(TEX) $*; done)
.dtx.dvi:
	$(TEX) $<; $(TEX) $<
.tex.idx:
	$(TEX) $*;
.idx.ind:
	$(MAKEIDX) $(IDXOPT) -o $*.ind $*.idx
.dvi.pdf:
	$(DVIPDF) $(DVIPDFOPT) $*
.dvi.ps:
	$(DVIPS) $(DVIPSOPT) -o $@ $*
.dtx.sty:
	$(TEX) $*.ins
# \end{GenerationRules}

# \begin{aliases}
#    \begin{subsetting}[Primary]
# \comment{$F.tex の PDF ファイル $F.pdf の作成}
pdf:	$F.pdf 
# \comment{$F.tex の DVI ファイル $F.dvi の作成}
dvi:	$F.dvi 
# \comment{$F.tex の索引 $F.ind の作成}
ind:	$F.ind 
# \comment{マクロパッケージ istt.sty の作成}
sty:	$M.sty 
# \comment{マクロパッケージ istt.sty のマニュアル}
man:	$M.pdf 
#    \end{subsetting}

#     \begin{subsetting}[Secondary]
# \comment{依存関係を無視した二度のタイプセット}
fast:   
	$(TEX) $F; $(TEX) $F
# \comment{依存関係を無視した一度のタイプセット}
faster: 
	$(TEX) $F
# \comment{今日の日付の PDF ファイルを作成}
today:	$F.pdf 
	cp $< $F-`date +%Y-%m-%d-%H-%M`.pdf
#    \end{subsetting}

#    \begin{subsetting}[Previewing]
view:	$F.dvi
	$(XDVI) $<
viewpdf: $F.pdf
	$(PDFVIEWER) $<
#    \end{subsetting}
# \end{aliases}

# \begin{setting}[Distribution]
clean:
	$(RM) $F.aux $F.log $F.toc $F.dvi $F.ind
	$(RM) $F.out $F.brf $F.idx $F.ilg *~
# \comment{原稿の配布用 TAR ball}
tar:	$M.pdf $F.pdf 
	$(MKDIR) $(F)src/img
	cp -r img $(F)src/
	cp $(SRC) $(F)src/
	tar czf $(F)src.tgz $(F)src/
	$(RMFR) $(F)src/
# \comment{アーカイブのチェック}
checktar: 
	tar tzf $(F)src.tgz | sort | less
# \comment{PDF のファイル情報とフォント情報のチェック}
checkpdf: $F.pdf 
	pdfinfo $< | less;
	pdffonts $< | less
# \comment{画像 ($IMG ディレクトリ) のBoundingBox の作成}
bb:	
	./makebb $(IMG)
ls:
	ls -lhGF --color=auto
# \end{setting}
