#!/bin/bash
#
# Helper script to quickly regenerate/create spritesheets and temporary gif exports from the aseprite files
# first argument is the character basename (ie icecream)
# second argument is the statename being edited (ie idle)
# third argument is the state that will be copied from if the second argument doesnt exist
# default is the ref state

# referenced from the scripts location up one folder
storage=raw
exportfolder=art
empty=empty

usage() {
	>&2 echo Usage: [ basename ] [ stateedited ] [ OPTIONAL: copiedfrom ]
	exit 1
}


[ -z "$1" ] || [ -z "$2" ] && usage

filebase="$(dirname "${BASH_SOURCE[0]}")/../"  # gets file's location then goes up one

# the file prefix for the raw files
charprefix="$filebase/$storage/$1"

# the currently focused on new file
newfile="${charprefix}_$2.aseprite"

if [ -n "$3" ]
then
	reference="${charprefix}_$3.aseprite"
else
	reference="${charprefix}_ref.aseprite"
fi

if [ ! -e "$newfile" ]
then
	if [ ! -e "$reference" ] 
	then
		>&2 echo WARNING: Base reference does not exist, creating..
		template=$(find $filebase/$empty -name '*.aseprite' | fzf --prompt='size >')
		[ -z "$template" ] && exit 2
		cp -v $template $reference
		aseprite $reference
	fi
	cp -vn $reference "$newfile"
fi

aseprite "$newfile"

aseprite -bv $newfile --scale 5 --save-as "/tmp/$1_$2.gif" && echo Saved gif to /tmp.
aseprite -bv $newfile --sheet-type horizontal --sheet "$filebase/$exportfolder/$1_$2.png" > /dev/null && echo Saved spritesheet to $filebase/$exportfolder
