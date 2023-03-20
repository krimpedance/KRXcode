#!/bin/sh

export LANG=C

base_path=$1

keys=(
  __PREFIX__
  __LOWER_PREFIX__
  __TARGET__
  __ORGANIZATION__
  __DATE__
  __YEAR__
  __MONTH__
  __DAY__
)

values=(
  "$2"
  "$3"
  "$4"
  "$5"
  `date "+%Y\\/%m\\/%d"`
  `date "+%Y"`
  `date "+%m"`
  `date "+%d"`
)

# Rename file and folder

index=0

for key in ${keys[@]}
do
  paths=`find -d $base_path -name "*$key*"`

  for path in $paths
  do
    replacePath=`dirname $path`/`basename $path | sed "s/$key/${values[$index]}/g"`
    mv $path $replacePath
  done

  index=`expr $index + 1`
done

# Replace file texts

files=`find $base_path -type f -print`
for file in $files
do
  index=0
  for key in ${keys[@]}
  do
    sed -i '' -e "s/$key/${values[$index]}/g" $file
    index=`expr $index + 1`
  done
done
