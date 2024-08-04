#!/bin/bash

# Define source and destination directories
SOURCE_DIR="."
DEST_DIR="../JusticeForBangladesh2024/Website"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy all files and directories except .git
rsync -av --exclude='.git' "$SOURCE_DIR/" "$DEST_DIR/"