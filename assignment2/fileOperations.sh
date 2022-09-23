#!/bin/bash
##############################################
## author: Brian Qu						    ##
## brief: UofT 2022Fall BME1478 assignment2 ##
## date: 2022-09-23						    ##
##############################################



####################################### Task 1 #############################################
# Create a directory called IMAGES. Copy all of the .jpg files from all other directories into this using a
# single command. You may first need to create a loop of that renames these files (first try without
# renaming and you will find out why). Copy all the folders' contents except the jpegs to another new
# directory, DATA_ANALYSIS
####################################### Task 1 #############################################
echo "\n####################################### Task 1 #############################################"
if [ -d "./IMAGES" ]; then
	rm -rf IMAGES
fi
if [ -d "./DATA_ANALYSIS" ]; then
	rm -rf DATA_ANALYSIS
fi
mkdir IMAGES
mkdir DATA_ANALYSIS
cd IMAGES

for i in $(ls ../assignment-data); do
	for j in $(ls ../assignment-data/$i); do
		match=$(echo $j | grep ".jpg")
		if [[ "$match" != "" ]]; then
			cp -rf ../assignment-data/$i/$j ./$i-$j
		else
			cp -rf ../assignment-data/$i/$j ../DATA_ANALYSIS/$i-$j
		fi
	done
done
echo "Task1 DONE"

####################################### Task 2 #############################################
# Meg was not consistent in naming the note files during the experiments, and sometimes even forgot
# to make a note. Write a loop that prints a message to screen informing her which folders are missing
# a note file. Repeat the same for the demographic spreadsheet.
####################################### Task 2 #############################################
echo "\n####################################### Task 2 #############################################"
cd ../
count=0

func_file_check() {
	for i in $(ls assignment-data); do
		for j in $(ls assignment-data/$i); do
			match=$(echo $j | grep "$1")
			if [[ "$match" != "" ]]; then
				count=1
			fi
		done
		if [[ "$count" == "1" ]]; then
			count=0
		else
			if [[ "$1" == ".txt" ]]; then
				echo "Meg, you have missed note files in $i \n"
			else
				echo "Meg, you have missed demographic spreadsheet in $i \n"
			fi
		fi
		count=0
	done
}

func_file_check ".txt"
func_file_check ".csv"
echo "Task2 DONE"

####################################### Task 3 #############################################
# Write a loop that renames all of the note text files in each folder to: notes.txt
####################################### Task 3 #############################################
echo "\n####################################### Task 3 #############################################"
for i in $(ls assignment-data); do
	for j in $(ls assignment-data/$i); do
		match=$(echo $j | grep "txt")
		if 	[[ "$match" != "" ]]; then
			mv assignment-data/$i/$j notes.txt
		else
			continue
		fi
	done
done
echo "Task3 DONE"

####################################### Task 4 #############################################
# Over the course of a few months, she gradually copied her experiment data from the PC in the
# examination room onto an external hard drive. She wants to do a final check that there is in fact a
# copy of all the folders in the hard drive. Tell her how to use a command with arguments to compare
# the list of all the folders on the main computer to those on the hard drive.
####################################### Task 4 #############################################
echo "\n####################################### Task 4 #############################################"
if [[ $# != 2 ]]; then
	echo "-----------------------You have entered wrong arguments----------------------"
	echo "--Usage: sh fileOperations.sh local_folder_address harddrive_folder_address--"
    echo "-----------------------------------------------------------------------------"
else
	local_folder_address=$1
	harddrive_folder_address=$2
fi

diff -urNa $local_folder_address $harddrive_folder_address
echo "Task4 DONE"

####################################### Task 5 #############################################
# Write a command that searches for the word “photo” in every file in all 9 directories and prints the
# number of incidences to screen
####################################### Task 5 #############################################
echo "\n####################################### Task 5 #############################################"
cp -rf IMAGES assignment-data/
cp -rf DATA_ANALYSIS assignment-data/
photo_count=0

for i in $(ls assignment-data); do
    for j in $(ls assignment-data/$i); do
        match=$(grep "photo" assignment-data/$i/$j)
        if [[ "$match" != "" ]]; then
            photo_count=$(($photo_count+1))
        else
            continue
        fi
    done
done
echo "\n-----The number of word-photo is $photo_count-----"
echo "Task5 DONE"
