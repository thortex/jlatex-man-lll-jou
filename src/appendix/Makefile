all: jou-app.pdf
f=jou-app
p=platex -kanji=utf8
m=mendex -U
SRC=Makefile 8.6.pdf dvipdfmx.pre
VER=1.1.4

jou-app.pdf:	jou-app.tex
	$p $f
	$p $f
	$m -s $f.ist -d $f.dic -o $f.ind $f.idx
	$p $f
	$p $f
	dvipdfmx $f

clean:	
	rm -f $f.pdf $f.aux $f.toc $f.dvi $f.ind $f.idx $f.ilg $f.log \
		$f.ist $f.map $f.dic $f.tmp
	rm -f *~

tar:
	mkdir -p $f-$(VER)
	cp $f.tex $(SRC) $f-$(VER)
	tar cjf $f-$(VER).tar.bz2 $f-$(VER)
	rm -fr $f-$(VER)