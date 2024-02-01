#!/bin/bash

# Define the absolute paths for the source, destination, and temporary directories
SOURCE_DIR="$PWD/doc/example-snippets"
DEST_DIR="$PWD/doc/compiled-snippets"
TMP_DIR="/dev/shm/my_temp_dir"
#DEST_DIR="$PWD/doc/tmp"

# Read the version number from typst.toml
VERSION=$(grep '^version' "$PWD/typst.toml" | cut -d '"' -f2)

# Check if VERSION is empty
if [ -z "$VERSION" ]; then
    echo "Version not found in typst.toml"
    exit 1
fi

# Create and setup the temporary directory
mkdir -p "$TMP_DIR"
cp -r "$SOURCE_DIR/"* "$TMP_DIR"

# Check if the destination directory exists, if not, create it
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
else
    # If the directory exists, clear its contents
    rm -rf "${DEST_DIR:?}"/*
fi

# Preprocessing step
find "$SOURCE_DIR" -type f -name '*.typ' | while read -r file; do
    # Get the relative path from SOURCE_DIR
    relative_path="${file#$SOURCE_DIR/}"
    relative_dir=$(dirname "$relative_path")
    filename=$(basename "${file%.*}")

    # Create corresponding subdirectory in temporary directory
    mkdir -p "$TMP_DIR/$relative_dir"

    # Define the path for the temporary file
    temp_file="$TMP_DIR/$relative_path"

    echo "Pre-processing file: $relative_path"

    # Prepend the required string to the new temp file
    echo "#set page(background: box(width: 100%, height: 100%, fill: luma(97%)), width: auto, height: auto, margin: 2pt)" > "$temp_file"

    # Append the contents of the original file to the new temp file, replacing "<<VERSION>>" with the actual version number
    sed "s/<<VERSION>>/$VERSION/g" "$file" >> "$temp_file"
done

# Compilation step
find "$TMP_DIR" -type f -name '*.typ' | while read -r temp_file; do
    # Get the relative path from TMP_DIR
    relative_path="${temp_file#$TMP_DIR/}"
    relative_dir=$(dirname "$relative_path")
    filename=$(basename "${temp_file%.*}")

    # Ensure the destination subdirectory exists
    mkdir -p "$DEST_DIR/$relative_dir"

    echo "Compiling file: $relative_path"

    # Compile the temp file to SVG format
    typst compile "$temp_file" "$DEST_DIR/$relative_dir/$filename.svg"
done

# Clean up: remove the temporary directory and its contents
# rm -rf "$TMP_DIR"

echo "All files have been processed."
