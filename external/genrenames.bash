#!/bin/bash
echo "This script outputs all images from a mod with an underscore in the name to rename.txt in that folder."

if [[ $1 = *[![:space:]]* ]]; then
	folder=$1
else
	read -p "What is the mod abbreviation/relative folder path? " folder
fi

folder=${folder%/}
if [ -z $folder ] || [ ! -e $folder ] || [ ! -d $folder ]; then
	echo "A folder does not exist at $folder, please run this script again."
	exit 1
fi

if [[ -e "$folder/renames.txt" ]]; then
	echo Moving old renames.txt to renames_old.txt
	mv $folder/renames.txt $folder/renames_old.txt
fi

read -p "Would you like to output ALL images to be renamed? [Y/n] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
	allimgs=0
else
	allimgs=1
fi

let count=0
for i in $folder/*.png; do
    if [[ $i =~ \*\.png$ ]]; then
    	break
	fi

	if [[ allimgs -eq 0 ]] || [[ $i =~ _ ]]; then
		printf "$(basename -s .png "$i")=\n" >> "$folder/renames.txt"
		let count++
	fi
done

if [[ count -eq 0 ]]; then
	if [ $allimgs = true ]; then
		echo "No images were found"
	else
		echo "No images were found with underscores"
	fi
else
	echo "Output $count images to $folder/renames.txt"
	xdg-open $folder/renames.txt
fi