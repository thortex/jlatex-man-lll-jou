#!/usr/bin/zsh

for f in *.tex;{platex $f}   
rm -f *.log *.aux
for f in *.dvi;{dvipdfmx -f hira.map -s 1 -o `basename $f .dvi`-1.pdf $f} 
for f in *.dvi;{dvipdfmx -f hira.map -s 2 -o `basename $f .dvi`-2.pdf $f} 
for f in *.pdf;{pdfcrop $f}
for f in *-crop.pdf; {pdfinfo $f | grep "Page size"| sed -e 's/x//;s/Page size/%%BoundingBox/;s/:/: 0 0 /;s/pts//;' >`basename $f .pdf`.bb}