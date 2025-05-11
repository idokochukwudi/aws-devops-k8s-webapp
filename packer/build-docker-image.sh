#!/bin/bash

# Name: build-docker-image.sh
# Purpose: Build the Docker image used for running Packer with Ansible

set -euo pipefail

IMAGE_NAME="packer-ansible"
LOG_FILE="docker-build.log"

echo "===================================="
echo "Building Docker image: $IMAGE_NAME"
echo "Logging to $LOG_FILE"
echo "===================================="

# Check if Dockerfile exists
if [ ! -f Dockerfile ]; then
  echo "[ERROR] Dockerfile not found in the current directory!"
  exit 1
fi

# Build Docker image and log output
{
  docker build -t "$IMAGE_NAME" .
} | tee "$LOG_FILE"

# Check if image build was successful
if [ "${PIPESTATUS[0]}" -eq 0 ]; then
  echo "===================================="
  echo "✅ Docker image '$IMAGE_NAME' built successfully!"
  echo "Log saved to $LOG_FILE"
  echo "===================================="
else
  echo "===================================="
  echo "❌ Failed to build Docker image '$IMAGE_NAME'. Check $LOG_FILE for details."
  echo "===================================="
  exit 1
fi
