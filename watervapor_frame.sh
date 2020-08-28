#!/bin/bash

#set -eux

sat=$1
frame=$2
year=$3
doy=$(printf "%03d" $((10#$4)))
hour=$(printf "%02d" $5)
minute=$(printf "%02d" $6)

start_time="$year$doy$hour$minute"
dst_path="${7}/${sat}_${start_time}.jpg"

#blu=`./list-prefix.sh $sat $frame 1 $year $doy $hour $minute`
#red=`./list-prefix.sh $sat $frame 2 $year $doy $hour $minute`
#nir=`./list-prefix.sh $sat $frame 3 $year $doy $hour $minute`
mlwp=`./list-prefix.sh $sat $frame 9 $year $doy $hour $minute`

./get.sh $mlwp $start_time.mlwp.nc

./toa.sh $start_time.mlwp.nc

gdalwarp \
  -q \
  -wm 1000 \
  -r average \
  -te -1984357.698 -756736.329 2209214.168 2038978.249 \
  -t_srs "+proj=aea +lon_0=-88.59375 +lat_1=12.3151551 +lat_2=33.5211038 +lat_0=22.9181295 +datum=WGS84 +units=m +no_defs" \
  $start_time.mlwp.toa.tif \
  $start_time.mlwp.toa.resized.tif

#mv $start_time.mlwp.toa.resized.tif $start_time.mlwp.toa.tif
gdaldem hillshade -z 10 $start_time.mlwp.toa.resized.tif $start_time.mlwp.hillshade.tif
convert -brightness-contrast 15x15 $start_time.mlwp.hillshade.tif $start_time.mlwp.hillshadelight.tif 2> /dev/null
mv $start_time.mlwp.hillshadelight.tif $start_time.mlwp.hillshade.tif
gdaldem color-relief $start_time.mlwp.toa.resized.tif watervapor_ramp2.txt $start_time.mlwp.color.tif

./timestamp.sh $year$doy$hour $start_time.timelabel.mobile.png

convert $start_time.mlwp.color.tif $start_time.mlwp.hillshade.tif -compose multiply -composite -resize 1440x960   $start_time.mlwp.composite.png 2> /dev/null
convert $start_time.mlwp.composite.png $start_time.timelabel.mobile.png  -gravity northeast -composite $dst_path 2> /dev/null

#rio stack --overwrite --rgb --co compress=lzw $start_time.red.toa.tif $start_time.grn.tif $start_time.blu.toa.tif $start_time.rgb.tif

# blehhh
#convert -gamma 1.5 -sigmoidal-contrast 10,10% -modulate 100,150 -channel B -gamma 0.55 -channel G -gamma 0.7 +channel -gamma 0.7 $start_time.rgb.tif $dst_path
#convert -gamma 2.5 -sigmoidal-contrast 5,25% -modulate 100,190 -channel B -gamma 0.55 -channel G -gamma 0.7 +channel -gamma 0.7 +sigmoidal-contrast 0,15% -resize 2560x1536 $start_time.rgb.tif $dst_path
#convert -gamma 2.5 -sigmoidal-contrast 5,25% -modulate 100,190 -channel B -gamma 0.55 -channel G -gamma 0.7 +channel -gamma 0.7 +sigmoidal-contrast 0,15% $start_time.rgb.tif $dst_path

#rio edit-info $dst_path --like $start_time.blu.toa.tif --crs like --transform like --nodata 0
echo $dst_path
rm $start_time.mlwp.composite.png $start_time.timelabel.mobile.png $start_time.mlwp.color.tif $start_time.mlwp.toa.resized.tif $start_time.mlwp.hillshade.tif
