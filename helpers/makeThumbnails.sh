#!/bin/bash

# Directory containing the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Load IMAGE_DIR from .env file
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
else
    echo "Error: .env file not found."
    exit 1
fi

# Loop through each file in the directory
for file in "$IMAGE_DIR"/*; do
    # Check if file is an image
    if [[ $file == *.jpg || $file == *.png || $file == *.jpeg ]]; then
        # Get image dimensions
        width=$(identify -format "%w" "$file")
        height=$(identify -format "%h" "$file")

        # Determine if image is landscape or portrait
        if [ "$width" -ge "$height" ]; then
            # Landscape image, resize to 200x100
            convert "$file" -resize 200x100 "${file%.*}_thumbnail.${file##*.}"
        else
            # Portrait image, resize to 100x200
            convert "$file" -resize 100x200 "${file%.*}_thumbnail.${file##*.}"
        fi
    fi
done
