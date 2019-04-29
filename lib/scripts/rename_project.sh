#!/bin/sh

export LANG=C

templateName="KRXcodeTemplate"
projectPath=$1
projectName=`basename $projectPath`
bundleID=$2
organization=$3
year=`date "+%Y"`

# Rename file and folder

paths=`find -d $projectPath -name "*$templateName*"`
for path in $paths
do
  replacePath=`dirname $path`/`basename $path | sed "s/$templateName/$projectName/g"`
  mv $path $replacePath
done

# Replace file texts

files=`find $projectPath -type f -print`
for file in $files
do
  sed -i '' -e "s/$templateName/$projectName/g" $file
  sed -i '' -e "s/KRXcodeBundleID/$bundleID/g" $file
  sed -i '' -e "s/KRXcodeOrganization/$organization/g" $file
  sed -i '' -e "s/KRXcodeYear/$year/g" $file
done
