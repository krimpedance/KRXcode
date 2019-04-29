#!/bin/sh

text=$1
output_dir=$2

color="#FFF"
text_color="#000"
font="/System/Library/Fonts/HelveticaNeue.ttc"

pixels=(20 29 40 60 76)
sizes=(1 2 3)

for pixel in "${pixels[@]}"
do
  for size in "${sizes[@]}"
  do
    convert -matte -size `expr $pixel \* $size`x`expr $pixel \* $size` -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon${pixel}_x$size.png"
  done
done

convert -matte -size `expr 167`x`expr 167` -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon83.5_x2.png"
convert -matte -size `expr 1024`x`expr 1024` -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon1024.png"
