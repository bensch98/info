#!/bin/bash

# create output directory if it doesn't exist
OUTPUT_DIR="cropped_videos"
ORIG_RES="1920,1200"
mkdir -p "$OUTPUT_DIR"

# process all .mp4 files in the current directory
for file in *.mp4; do
	# skip if no files match
	[ -e "$file" ] || continue

	# get video resolution
	resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$file")
	
	# check if resolution is 1920x1200
	if [[ "$resolution" == $ORIG_RES ]]; then
		echo "Cropping $file to 1920x1080..."
		
		# output file path
		output_file="$OUTPUT_DIR/$file"
		
		# apply cropping
		ffmpeg -i "$file" -vf "crop=1920:1080:0:60" -c:a copy "$output_file"
		echo "Saved cropped video to $output_file"
	else
		echo "Skipping $file (Resolution: $resolution)"
	fi
done

