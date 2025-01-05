#!/bin/bash

# Configuration - Update these variables
GITHUB_REPO_URL="https://github.com/ahmedeagle/CI-CD-self-hosted-deployment"
RUNNER_NAME="prod-machine"
RUNNER_VERSION="2.304.0"  # Update to the latest version if needed
RUNNER_INSTALL_DIR="/home/vagrant/actions-runner"

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl git

# Create directory for the runner
echo "Creating directory for GitHub Actions runner..."
mkdir -p $RUNNER_INSTALL_DIR
cd $RUNNER_INSTALL_DIR

# Download the latest GitHub Actions runner
echo "Downloading GitHub Actions runner version $RUNNER_VERSION..."
curl -O -L "https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz"

# Extract the downloaded tar.gz file
echo "Extracting GitHub Actions runner..."
tar xzf actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

# Configure the runner
echo "Configuring the runner for repository $GITHUB_REPO_URL..."
echo "Please make sure you have generated the GitHub runner token manually from the Actions settings."
read -p "Enter your GitHub Actions runner token: " RUNNER_TOKEN

./config.sh --url $GITHUB_REPO_URL --token $RUNNER_TOKEN --name $RUNNER_NAME

# Start the runner as a service
echo "Installing the runner as a service..."
sudo ./svc.sh install
sudo ./svc.sh start

# Verify if the runner started successfully
echo "Verifying the runner is active..."
./run.sh
