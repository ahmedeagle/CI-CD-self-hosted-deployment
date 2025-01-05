# Production Deployment Workflow

This repository contains a **GitHub Actions** workflow for deploying code to a production environment, using **SSH key-based authentication** for secure communication.

## Workflow Overview

The GitHub Actions workflow is triggered manually using the `workflow_dispatch` event. It performs the following steps:

1. **OTP Verification**: Ensures that the deployment is authorized by verifying the OTP entered by the user.
2. **SSH Setup**: Configures the SSH agent with the private key stored on the production machine to authenticate with GitHub.
3. **Code Deployment**: Pulls the latest code from the selected GitHub branch and deploys it to the production server.

## Steps to Set Up

### 1. SSH Key Setup

#### On Your Local Machine (Vagrant VM):

1. **Generate SSH Key Pair** (if not already created):
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your-email@example.com"

This will generate two files:

id_rsa (private key)
id_rsa.pub (public key)
Copy the Public Key to GitHub:

Copy the content of the public key (id_rsa.pub):
cat ~/.ssh/id_rsa.pub

In your GitHub repository, navigate to Settings > Deploy Keys and Add Deploy Key.
Paste the public key and enable Allow write access if necessary.
Ensure Correct Permissions for the Private Key:

Set the correct permissions for the private key file (id_rsa):

chmod 600 ~/.ssh/id_rsa

2. GitHub Secrets Configuration
Add the following secrets in your GitHub repository settings:

PROD_OTP: The OTP used for verifying the deployment process.
