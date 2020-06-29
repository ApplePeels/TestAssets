#!/bin/bash

root=`pwd`
imageDir=${root}/Image/*
assetsDir=${root}/Assets.xcassets/

for fileName in ${imageDir}; do

	echo ${fileName}
		


	# if [[ -d $fileName ]]; then
	# 	echo $fileName;
	# elif [[ ! -e $fileName ]]; then
	# 		echo $fileName not exist
	# fi
	
done
