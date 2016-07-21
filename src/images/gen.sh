#!/bin/sh
DVIPS="dvips -Pdl"
DVIPSK="dvipsk -Pdl"
DVIPDFM="dvipdfmx -f msembed.map"
HOGE="sleep 1"

echo "!!! IM is ImageMagick convert program path.!!!"
$HOGE
#IM=/usr/bin/convert
IM="/cygdrive/c/IM/convert"

echo "!!!convert character set from * to iso-2022-jp!!!"
$HOGE
SRC=`ls *.tex`
mkdir jis
for s in $SRC; do
  nkf -j -Lu $s > jis/$s
done

echo "!!!convert bitmap images from *.png *.jpg to *.eps!!!"
$HOGE
BIT=`ls *.jpg`
for b in $BIT; do
  fig=`basename $b .jpg`
  $IM $b $fig.eps
done

echo "!!!making dvi files!!!"
$HOGE
platex jis/abst
platex jis/abst
mpost mpsample.mp
platex jis/mylayout
latex jis/pst
latex jis/vector

echo "!!!making postscript files!!!"
$HOGE
$DVIPSK -pp 1 -o abst1.eps abst
$DVIPSK -pp 2 -o abst2.eps abst
$DVIPSK -E -o mylayout.eps mylayout
mv mpsample.1 mpsample.eps
$DVIPS -E -o pst.ps pst.dvi
$DVIPS -E -o vector.ps vector.dvi

echo "!!!fix bounding boxes!!!"
$HOGE
perl -pe 's/%%BoundingBox: .* .* .* .*/%%BoundingBox: 70 710 230 840/' pst.ps > pst.eps
perl -pe 's/%%BoundingBox: .* .* .* .*/%%BoundingBox: 13 689 137 787/' vector.ps > vector.eps

echo "!!!making pdf files!!!"
$HOGE
$DVIPDFM -s 1 -o abst1.pdf abst
$DVIPDFM -s 2 -o abst2.pdf abst
ps2pdf mpsample.eps
epstopdf mylayout.eps
epstopdf pst.eps 
echo "%%BoundingBox: 0 0 160 130" > pst.bb
epstopdf vector.eps
echo "%%BoundingBox: 0 0 124 98" > vector.bb

echo "!!!removing temporary files!!!"
rm -f *.aux *.log *.dvi *~
rm -fr jis/
