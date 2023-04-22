#!/bin/bash

visita="    Inquadra per maggiori informazioni"
nota="Altri QR-code informativi in quest'area" 
credit="Underlandscape\nProgetto di ricerca di Interesse Nazionale MIUR - 2021"
root="https://sites.google.com/view/prin-underlandscape/home-page/itinerari/"
bg="lightgray"

mktags() {

echo $1

while read -r line
do
  id=`echo $line | cut -f1 -d"|"`
  name=`echo $line | cut -f2 -d"|"`
  descr=`echo $line | cut -f3 -d"|"`
  echo $id
  echo $name
  echo $descr
  URL="$root"/"$1"/"$id"
  ( echo "$descr"; echo; echo "$URL" ) | qrencode -8 -s 6 -t PNG -o tmp.png
  convert \
	-size 320x440 canvas:$bg \
	logoEle_v2.2_small.png -geometry 50x50+10+10 -composite \
	-size 240x50 -font Times-Roman -background $bg caption:"$name" -geometry +70+10 -composite \
	-size 200x20 -font Times-Roman -background $bg caption:"$visita" -geometry +70+60 -composite \
	tmp.png -geometry 300x+10+80 -composite \
	-size 300x25 -font Times-Roman -background $bg caption:"$nota" -geometry +10+380 -composite \
	-size 300x25 -font Ubuntu-Mono -background $bg caption:"$credit" -geometry +10+405 -composite \
    $1/$id.png
  rm tmp.png
done

}

fn=20230430.geojson
bn=`basename $fn .geojson`

if [ -d $bn ]; then rm -Rf $bn; fi
mkdir $bn

python3 split_geojson.py $fn | mktags $bn

montage -geometry 960x1320+120+120 -border 20 -frame 4 -label %d"-"%t -tile 5x3 $bn/*.png $bn.pdf

