#!/bin/sh

text=$1
output_dir=$2

color="#FFF"
text_color="#000"
font="/System/Library/Fonts/HelveticaNeue.ttc"

pixels=(20 29 40)
sizes=(1 2 3)

for pixel in "${pixels[@]}"
do
  for size in "${sizes[@]}"
  do
    convert -matte -size `expr $pixel \* $size`x`expr $pixel \* $size` -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon${pixel}_x$size.png"
  done
done

convert -matte -size 120x120 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon60_x2.png"
convert -matte -size 180x180 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon60_x3.png"

convert -matte -size 76x76 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon76_x1.png"
convert -matte -size 152x152 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon76_x2.png"

convert -matte -size 167x167 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon83.5_x2.png"

convert -matte -size 1024x1024 -background "$color" -fill "$text_color" -font "$font" -gravity center label:$text "$output_dir/appicon1024.png"
