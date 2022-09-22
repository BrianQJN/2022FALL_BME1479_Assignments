#!/bin/bash

# Create a directory called IMAGES. Copy all of the .jpg files from all other directories into this using a
# single command. You may first need to create a loop of that renames these files (first try without
# renaming and you will find out why). Copy all the folders' contents except the jpegs to another new
# directory, DATA_ANALYSIS

mkdir IMAGES
cd IMAGES

for i in $(ls ../assignment-data); do
	for j in $(ls ../assignment-data/$i); do
		match=$(echo $j | grep ".jpg")
		if [[ "$match" != "" ]]; then
			cp -rf ../assignment-data/$i/$j ./$i-$j
		else
			continue
		fi
	done
done

