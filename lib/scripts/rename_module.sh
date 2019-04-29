#!/usr/local/bin/bash

export LANG=C

base_path=$1

declare -A variables=(
  [__PREFIX__]=$2
  [__TARGET__]=$3
  [__ORGANIZATION__]=$4
  [__DATE__]=`date "+%Y\\/%m\\/%d"`
  [__YEAR__]=`date "+%Y"`
  [__MONTH__]=`date "+%m"`
  [__DAY__]=`date "+%d"`
)

# Rename file and folder

for key in ${!variables[@]}
do
  paths=`find -d $base_path -name "*$key*"`
  for path in $paths
  do
    replacePath=`dirname $path`/`basename $path | sed "s/$key/${variables[$key]}/g"`
    mv $path $replacePath
  done
done

# Replace file texts

files=`find $base_path -type f -print`
for file in $files
do
  for key in ${!variables[@]}
  do
    sed -i '' -e "s/$key/${variables[$key]}/g" $file
  done
done
