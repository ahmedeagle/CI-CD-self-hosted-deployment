#!/bin/bash

# Configuration - Update these variables
GITHUB_REPO_URL="https://github.com/ahmedeagle/CI-CD-self-hosted-deployment"
RUNNER_NAME="prod-machine"
RUNNER_VERSION="2.321.0"  # Updated to match the provided version
RUNNER_INSTALL_DIR="/home/vagrant/actions-runner"

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl git

# Create directory for the runner
echo "Creating directory for GitHub Actions runner..."
mkdir -p $RUNNER_INSTALL_DIR
cd $RUNNER_INSTALL_DIR

# Download the specified version of GitHub Actions runner
echo "Downloading GitHub Actions runner version $RUNNER_VERSION..."
curl -o "actions-runner-linux-x64-$RUNNER_VERSION.tar.gz" -L "https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz"

# Optional: Validate the hash (disabled by default, uncomment to enable)
# echo "Validating the hash..."
# echo "<INSERT_HASH_HERE>  actions-runner-linux-x64-$RUNNER_VERSION.tar.gz" | shasum -a 256 -c

# Extract the downloaded tar.gz file
echo "Extracting GitHub Actions runner..."
tar xzf "actions-runner-linux-x64-$RUNNER_VERSION.tar.gz"

# Configure the runner
echo "Configuring the runner for repository $GITHUB_REPO_URL..."
echo "Please generate a GitHub Actions runner token manually from the repository's Actions settings."

# Prompt for the token
read -p "Enter your GitHub Actions runner token: " RUNNER_TOKEN

./config.sh --url $GITHUB_REPO_URL --token $RUNNER_TOKEN --name $RUNNER_NAME

# Run the GitHub Actions runner
echo "Starting the GitHub Actions runner..."
./run.sh
