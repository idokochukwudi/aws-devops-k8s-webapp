#!/bin/bash

# Check if Git LFS is installed
if ! command -v git-lfs &> /dev/null; then
    echo "Git LFS not found. Installing..."
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
    sudo apt install git-lfs -y
fi

# Initialize Git LFS
git lfs install

# Track .zip files with Git LFS
git lfs track "*.zip"

# Remove the large file from Git cache and re-add with LFS
git rm --cached awscliv2.zip

# Stage tracking configuration and the zip file
git add .gitattributes
git add awscliv2.zip

# Commit the changes
git commit -m "Move awscliv2.zip to Git LFS"

# Push to remote
git push
