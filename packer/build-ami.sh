#!/bin/bash

# Name: build-ami.sh
# Purpose: Run Packer inside Docker using Ansible to build an AWS AMI

set -euo pipefail

LOG_FILE="build-ami.log"
DOCKER_IMAGE="packer-ansible"

echo "===================================="
echo "Starting AMI build process..."
echo "Logging to $LOG_FILE"
echo "===================================="

# Check Docker image
if ! docker image inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
  echo "[ERROR] Docker image '$DOCKER_IMAGE' not found. Please build it with:"
  echo "        docker build -t $DOCKER_IMAGE ."
  exit 1
fi

# Check for required directories
if [ ! -d "$HOME/.aws" ]; then
  echo "[ERROR] AWS credentials directory not found at ~/.aws"
  exit 1
fi

if [ ! -d "$HOME/.ssh" ]; then
  echo "[ERROR] SSH directory not found at ~/.ssh"
  exit 1
fi

# Run the Docker container and log the output
{
  echo "[INFO] Running Packer inside Docker..."
  docker run --rm -it \
    -v $HOME/.ssh:/root/.ssh \
    -v $HOME/.aws:/root/.aws \
    -v $(pwd):/workspace \
    -w /workspace \
    "$DOCKER_IMAGE" packer build .
} | tee "$LOG_FILE"

# Check exit status
if [ "${PIPESTATUS[0]}" -eq 0 ]; then
  echo "===================================="
  echo "✅ AMI build completed successfully!"
  echo "Log saved to $LOG_FILE"
  echo "===================================="
else
  echo "===================================="
  echo "❌ AMI build failed. Check $LOG_FILE for details."
  echo "===================================="
  exit 1
fi
