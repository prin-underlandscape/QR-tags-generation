#!/bin/bash

visita="    Inquadra per maggiori informazioni"
nota="Altri QR-code informativi in quest'area" 
credit="Underlandscape\nProgetto di ricerca di Interesse Nazionale MIUR - 2021"
root="https://sites.google.com/view/prin-underlandscape/home-page/itinerari"
bg="lightgray"

mktags() {

while read -r line
do
  id=`echo $line | cut -f1 -d"|"`
  name=`echo $line | cut -f2 -d"|"`
  descr=`echo $line | cut -f3 -d"|"`
#  echo $id
  echo "- $name"
#  echo $descr
  URL="$root"/"$1"/"$id"
  ( echo "$descr"; echo; echo "$URL" ) | qrencode -8 -s 6 -t PNG -o tmp.png
  convert \
	-size 960x1260 canvas:$bg \
	logoEle_v2.2_small.png -geometry 150x150+30+30 -composite \
	-size 720x150 -font Times-Roman -background $bg caption:"$name" -geometry +210+30 -composite \
	-size 600x60 -font Times-Roman -background $bg caption:"$visita" -geometry +210+180 -composite \
	tmp.png -geometry 900x+30+240 -composite \
	-size 900x40 -font Times-Roman -background $bg caption:"$nota" -geometry +130+1150 -composite \
	-size 900x75 -font Ubuntu-Mono -background $bg caption:"$credit" -geometry +30+1200 -composite \
    $1/$id.png
  rm tmp.png
done

}

fn=$1
bn=`basename $fn .geojson`

echo "Creating backup for $1"
cp $fn $fn-backup.geojson

echo "Creating QR-codes for $1"
if [ -d $bn ]; then rm -Rf $bn; fi
mkdir $bn
python3 split_geojson.py $fn | mktags $bn

echo "Assembling A3 image of QRcodes (5*3)"
montage -geometry 710x900+120+120 -border 20 -frame 4 -label %d"-"%t -tile 5x3 $bn/*.png $bn.png

echo "Create GPX file for import in GaiaGPS"
ogr2ogr -dsco GPX_USE_EXTENSIONS=YES -f GPX $bn.gpx $bn.geojson

echo "Create GPKG file for import in SMASH"
ogr2ogr  -select "description,name" -f GPKG $bn.gpkg $bn.geojson


